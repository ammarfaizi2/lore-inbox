Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279861AbRJ3EzU>; Mon, 29 Oct 2001 23:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279862AbRJ3EzK>; Mon, 29 Oct 2001 23:55:10 -0500
Received: from anime.net ([63.172.78.150]:272 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S279861AbRJ3EzG>;
	Mon, 29 Oct 2001 23:55:06 -0500
Date: Mon, 29 Oct 2001 20:55:36 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Jonathan Lundell <jlundell@pobox.com>
cc: willy tarreau <wtarreau@yahoo.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <p05100304b803c6908755@[10.128.7.49]>
Message-ID: <Pine.LNX.4.30.0110292054001.13240-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Jonathan Lundell wrote:
> At 6:33 PM -0800 10/29/01, Dan Hollis wrote:
> >On Mon, 29 Oct 2001, Christopher Friesen wrote:
> >>  Are there issues with using MII to detect link state?  I thought
> >>it was fairly
> >>  reliable...
> >It doesn't work to detect link state through bridging device (say, bridged
> >ethernet over T3). The T3 might go down, but your MII link to the local
> >router will remain "up", so you will never know about the loss of link and
> >your packets will happily go into the void...
> ARP isn't going to do much for you once the failure is beyond the
> local segment, is it?

But you can use it to determine end-to-end link status. MII is useless for
that when you're going through a bridge.

So ARP is *perfect* for this situation and is *exactly* what is needed.
When you determine link is down using end-to-end status like ARP then you
can take the device out of the bonding queue. Presto, 100% perfect
failover.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

