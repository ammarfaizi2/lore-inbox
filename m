Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131049AbRAXOGs>; Wed, 24 Jan 2001 09:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131239AbRAXOGj>; Wed, 24 Jan 2001 09:06:39 -0500
Received: from mailhost1.dircon.co.uk ([194.112.32.65]:41234 "EHLO
	mailhost1.dircon.co.uk") by vger.kernel.org with ESMTP
	id <S131049AbRAXOG2>; Wed, 24 Jan 2001 09:06:28 -0500
From: Mark Longair <list-reader@ideaworks3d.com>
To: linux-kernel@vger.kernel.org
Cc: "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: [2.2.18] outgoing connections getting stuck in SYN_SENT
In-Reply-To: <14942.18985.174437.785751@starfruit.iwks.multi.local>
Date: 24 Jan 2001 14:01:14 +0000
In-Reply-To: Mark Longair's message of "Fri, 12 Jan 2001 00:04:57 +0000 (GMT)"
Message-ID: <871ytt1239.fsf@starfruit.iwks.multi.local>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Longair <list-reader@ideaworks3d.com> writes:
[..]
> I'm having a problem where twice a day or so, any new tcp connection
> it gets stuck in SYN_SENT.  Eventually this situation rights itself,
> but obviously in the meantime many services (e.g. squid, X) are
> broken.  The machine does IP masquerdading with ipchains, and
> masqueraded connections through it seem to be unaffected.  The
> kernel version is 2.2.18, although the same happened with 2.2.17.
[..]

It turned out that this was caused by using autofw to forward a range
of ports (2300-2400 in this case.)  It seems that these ports aren't
reserved in any way, so eventually the server tries to use one as a
local port on an outgoing connection.

There was a previous reference to this on the list: 

  http://kernelnotes.org/lnxlists/linux-kernel/lk_9908_01/msg00573.html

I'm looking at finding fix for that.  Would this be an issue with the
new networking code in 2.4?

Thanks for the suggestions...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
