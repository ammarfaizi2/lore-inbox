Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUHHVzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUHHVzS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUHHVzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:55:18 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:26521 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S265038AbUHHVzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:55:13 -0400
Date: Sun, 8 Aug 2004 23:54:58 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [2/3] via-rhine: de-isolate PHY
Message-ID: <20040808215458.GA21994@k3.hellgate.ch>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
References: <411684D5.8020302@colorfullife.com> <20040808200532.GA19170@k3.hellgate.ch> <41169546.5000308@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41169546.5000308@colorfullife.com>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Aug 2004 23:04:06 +0200, Manfred Spraul wrote:
> Roger Luethi wrote:
> >>I know that PHYs go into isolate mode if the startup id is wired to 0, 
> >
> >Wouldn't that be s/go/can go/ ?
> >
> I don't have the MII standard, my knowledge is from the DP83840A specs:
> The pin description contains a section about the phy ids:
> During power up five pins are latched to determine the initial phy address.
> Then the following sentence in bold: "An address selection of all zeros 
> (00000) will result in a PHY isolation condition".

I suppose all PHYs do that. Even if they don't, though, I should be
safe as long as I de-isolate unconditionally (instead of testing for
phy_id==0).

> I've reread the DP specs and I now think that your current patch is 
> sufficient:
> The isolate state is independant from the phy address - a non-zero phy 
> can be in isolate mode and the phy zero can be non-isolated. The phy id 

Stands to reason. A PHY that can't get out of isolation wouldn't be
very useful.

> If this is really true then handling phy 0 is trivial:
> First scan 1-31. If nothing found: try 0. If a phy is found: clear the 
> isolate bit and then use phy 0.

Makes sense. The Rhine is actually pretty neat in that regard, I've
been able to drop the PHY scanning entirely.

Roger
