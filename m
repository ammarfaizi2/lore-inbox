Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTKUT45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 14:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTKUT45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 14:56:57 -0500
Received: from mail.it.helsinki.fi ([128.214.205.39]:6374 "EHLO
	mail.it.helsinki.fi") by vger.kernel.org with ESMTP id S264422AbTKUT4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 14:56:53 -0500
Date: Fri, 21 Nov 2003 21:56:42 +0200 (EET)
From: Mikael Johansson <mpjohans@pcu.helsinki.fi>
X-X-Sender: mpjohans@soul.helsinki.fi
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RAID-0 read perf. decrease after 2.4.20
In-Reply-To: <Pine.LNX.4.44.0311211144130.15440-100000@logos.cnet>
Message-ID: <Pine.OSF.4.58.0311212139530.519259@soul.helsinki.fi>
References: <Pine.LNX.4.44.0311211144130.15440-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Marcelo and All!

On Fri, 21 Nov 2003, Marcelo Tosatti wrote:

> There have been no significant changes in the RAID driver in 2.4.21, so I
> suspect the cause for the slowdowns might the changes to the IO scheduler
> (ll_rw_blk.c) or VM changes.
>
> Isolating the -pre which the slowdown starts helps a lot.

I tested a few kernels to pin point the where tha changes occured. It
turned out that both 2.4.20 and 2.4.21-pre1 have bad read performance. The
2.4.20-ac's show good read speed. I tested it on two machines (different
from yesterday). I also checked the VIA chipset drivers version; that's
not the reason for the differences.

Athlon XP 2400+, 2.09 GHz, 1.5 GB RAM, 2*160 GB Maxtor Maxtor 6Y080L0
		VIA	write	read
2.4.19		none	10,000	  9,000 K/sec (chipset not supported)
2.4.20		3.35	73,000	 88,000
2.4.20-ac1	3.35-ac	70,000	135,000
2.4.20-ac2	3.35-ac	71,000	140,000
2.4.21-pre1	3.35-ac 71,000	 79,000
2.4.21-pre3	3.35-ac 71,000   79,000

Athlon 1.4 GHz, 1.5 GB RAM, 2*80 GB IC35L040AVER07-0 (IBM, I think)
2.4.13-ac8	?	49,000	 44,000 K/sec
2.4.19		3.34	53,000	 41,000
2.4.20-ac2	3.35-ac	50,000	 69,000
2.4.21-pre1	3.35-ac	53,000	 46,000

So there was apparently something very right with the 2.4.20-ac's. It
would be nice to get it back :-)

Have a nice weekend,
    Mikael J.
    http://www.helsinki.fi/~mpjohans/
