Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUFIWPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUFIWPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUFIWPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:15:39 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:38881 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S265974AbUFIWPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:15:35 -0400
Date: Wed, 9 Jun 2004 23:38:50 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
Message-ID: <20040609213850.GA17243@k3.hellgate.ch>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	"David S. Miller" <davem@redhat.com>, jgarzik@pobox.com,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20040607212804.GA17012@k3.hellgate.ch> <20040607145723.41da5783.davem@redhat.com> <20040608210809.GA10542@k3.hellgate.ch> <40C77C70.5070409@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C77C70.5070409@tmr.com>
X-Operating-System: Linux 2.6.7-rc3-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2004 17:09:04 -0400, Bill Davidsen wrote:
> cases forcing on both ends or just the NIC end results in a fully 
> functional connection.
> 
> We usually do this with module parameters, but do use ethtool (or 
> mii-tool) on occasion.

<sigh> I just killed the module parameters in my via-rhine development
tree. I suppose you don't use via-rhine!? :-) Nobody complained when
the code was broken for the longest time, and the current design has
all kinds of issues, not the least of which is a distinct lack of sane
semantics for stuff like hotplug, interface renaming, etc.

I'd prefer not to spend my time writing a clean implementation (or fixing
up the current one) of a mechanism that is conceptually obsolete.

> >However, "silently ignoring" strikes me as a very poor choice, in
> >stark contrast to Unix/Linux tradition. A user issues a command which
> >cannot be executed and gets the same response that is used to indicate
> >success!? What school of user interface design is that? How is that
> >not confusing users? </rant>
> 
> Yah.
> 
> Seeing this happen while autonegotiation is in progress is a small and 
> unlikely window of course!

Hmm? It's not about autoneg being in progress, and it's not a race
of any kind. If your NIC comes up with nway autoneg enabled, you must
use ethtool to explicitly turn autoneg off before you can use ethtool
duplex/speed options to force a media mode. However, if you try to force
media with autoneg still enabled, your command will be silently ignored.
It's up to the user to find out that the command failed and why.

Roger
