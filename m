Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbTBDTj6>; Tue, 4 Feb 2003 14:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTBDTj6>; Tue, 4 Feb 2003 14:39:58 -0500
Received: from soul.helsinki.fi ([128.214.3.1]:22027 "EHLO soul.helsinki.fi")
	by vger.kernel.org with ESMTP id <S267435AbTBDTjw>;
	Tue, 4 Feb 2003 14:39:52 -0500
Date: Tue, 4 Feb 2003 21:49:25 +0200 (EET)
From: Mikael Johansson <mpjohans@pcu.helsinki.fi>
X-X-Sender: mpjohans@soul.helsinki.fi
To: linux-kernel@vger.kernel.org
Subject: Re: DAC960, Alpha, 2.4.21-pre4 (Was: DAC960, 2.4.19 alpha problems)
In-Reply-To: <Pine.OSF.4.51.0301311140060.80325@soul.helsinki.fi>
Message-ID: <Pine.OSF.4.51.0302042135520.101271@soul.helsinki.fi>
References: <200301310921.h0V9LJxZ002780@eeyore.valparaiso.cl>
 <Pine.OSF.4.51.0301311140060.80325@soul.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello All!

Top-posting and replying to my own mail. Let's hope this at least is
useful for someone :-)

An update on the issue described below: The "mem=2047M" only _seemed_ to
solve the problem. The machine booted, but processes accessing the
RAID-array mount (/wrk) froze and became unkillable in a "D-state"
(immortal is the wrong word; they weren't alive).

The foolproof method of creating these processes was running bonnie++ -f,
a few seconds after "Rewriting..." all access to /wrk died. Impossible to
kill the processes with "kill -9" either (is there an even deadlier way?)

This happened on all kernels I tested, 2.4.19, 2.4.20, 2.4.21-pre4.
Unfortunately I couldn't test the -ac patches, as they needed a header
file missing on my system, sched_runqueue.h. Failed to locate it anywhere
else also.

So I now compiled the 2.2.23 kernel, and it (again) _seems_ to be running
OK. At least bonnie++ finishes. Now there's only the occasional spinlocks
that get stuck...

Anyway, if someone has a similar system, DP264/Tsunami/2*EV67, and can't
get things working with the DAC960 and 2.4, you can take some comfort in
the fact that you are not alone.

Just realized that I should have checked with a non SMP kernel, to see if
that would have made a difference.

Finally, if there are any wise persons out there who would benefit from
more precise information in efforts to solve this, I will be very glad to
help out.

Have a nice day,
    Mikael J.
    http://www.helsinki.fi/~mpjohans/


On Fri, 31 Jan 2003, Mikael Johansson wrote

> Hello All!
>
> After finally upgrading the 2.2 kernel on one of our alphas to the
> 2.4.21-pre4 kernel, the console got cluttered with EXT2 error messages
> from the RAID-array on the Mylex DAC960PX. First I tought it was a file
> system proble,m, but then found the following post:
>
> On Wed, 20 Nov 2002, Ivan Kokshaysky  wrote:
>
> > That was it, I guess.
> > virt_to_bus() is deprecated - driver *must* be converted
> > to the DMA mapping interface (see Documentation/DMA-mapping.txt).
> >
> > virt_to_bus() on alpha works only for limited range of kernel addresses.
> > On dp264 valid range is 0x00000000-0x7fefffff (i.e. 2Gb - 1Mb).
> > Given the fact that __get_free_pages() returns highest possible
> > pages I'm not surprised that this driver doesn't work on a 2Gb machine.
> >
> > Probably "mem=2047M" boot argument would help...
>
> Actually, I first compiled the kernel as "Generic", which let the system
> boot. When I recompiled the kernel more specifically for the machine type,
> DP264/Tsunami/2*EV67, the boot process would halt when the DAC960 driver
> tried to init. (A good thing; otherwise I would still be looking at the
> problem as an ext2-problem).
>
> Anyway, the machine has 2GB mem, and the "mem=2047M" seems to help (it
> boots).
>
> A question: Is this trick safe? Or should i downgrade to an earlier
> kernel?
>
> A comment: I guess a warning/conflict message about this should also be
> printed for the "Generic" (and maybe other configs that manage to boot)
> kernel compilation, as it seems to lead to massive file system corruption
> on the RAID-array (e2fsck -y /dev/rd/c0d0 printed "a million" screens of
> errors :-)
>
> Have a nice day,
>     Mikael J.
>     http://www.helsinki.fi/~mpjohans/
