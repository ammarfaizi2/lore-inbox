Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265739AbSKAUZL>; Fri, 1 Nov 2002 15:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265740AbSKAUZL>; Fri, 1 Nov 2002 15:25:11 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:11148 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265739AbSKAUZG>; Fri, 1 Nov 2002 15:25:06 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bill Davidsen <davidsen@tmr.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Date: Fri, 1 Nov 2002 12:21:35 -0800 (PST)
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211011218560.26353-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One question I have is how much of the driver problem you refer to is
becouse of optimizations that the various drivers have, could you fall
back to the simplest, works-with-everything,
all-timeouts-longer-then-the-slowest-disk slug of a driver that could be
used to do this dump?

David Lang

On Fri, 1 Nov 2002, Linus Torvalds wrote:

> Alan isn't worried about the "which sector do I write" kind of thing.
> That's the trivial part. Alan is worried about the fact that once you know
> which sector to write, actually _doing_ so is a really hard thing. You
> have bounce buffers, you have exceedingly complex drivers that work
> differently in PIO and DMA modes and are more likely than not the _cause_
> of a number of problems etc.
>
> And you have a situation where interrupts are not likely to work well
> (because you crashed with various locks held), so the regular driver
> simply isn't likely to work all that well.
>
> And you have a situation where there are hundreds of different kinds of
> device drivers for the disk.
>
> In other words, the AIX situation isn't even _remotely_ comparable. A
> large portion of the complexity in the PC stability space is in device
> drivers. It's the thing I worry most about for 2.6.x stabilization, by
> _far_.
>
> And if you get these things wrong, you're quite likely to stomp on your
> disk. Hard. You may be tryign to write the swap partition, but if the
> driver gets confused, you just overwrote all your important data. At which
> point it doesn't matter if your filesystem is journaling or not, since you
> just potentially overwrote it.
>
> In other words: it's a huge risk to play with the disk when the system is
> already known to be unstable. The disk drivers tend to be one of the main
> issues even when everything else is _stable_, for chrissake!
>
> To add insult to injury, you will not be able to actually _test_ any of
> the real error paths in real life. Sure, you will be able to test forced
> dumps on _your_ hardware, but while that is fine in the AIX model ("we
> control the hardware, and charge the user five times what it is worth"),
> again that doesn't mean _squat_ in the PC hardware space.
>
> See?
>
> 		Linus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
