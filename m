Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288639AbSADOOc>; Fri, 4 Jan 2002 09:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288641AbSADOOW>; Fri, 4 Jan 2002 09:14:22 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:60611 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S288639AbSADOOG>; Fri, 4 Jan 2002 09:14:06 -0500
Date: Fri, 4 Jan 2002 15:11:05 +0100 (CET)
From: kees <kees@schoen.nl>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] solves freeze due to serial comm. on SMP
In-Reply-To: <3C33F01E.EC95DD82@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201041505520.13067-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I tested 2.4.17 bare  and got TLWOH  (total Lockup Within One Hour)
So it is clear (for me at least) that the spinlock protection is _really_
needed.

I applied the 'Patch_for_ted' to 2.4.17 (without difficulty), build a new
kernel and I'm running it now. On 2.4.4 with the patch applied I got
uptime of 108 days when a power outage stopped the box.


regards


Kees


On Wed, 2 Jan 2002, Andrew Morton wrote:

> kees wrote:
> >
> > Hi,
> >
> > In the beginning of last year I reported a solid freeze problem with Linux
> > when I moved from UP to SMP. Some bughunting especially with kdb an hints
> > from AM I was able to nail it down to some SMP unsafe irq table handling
> > in serial.c.
> > I submitted the attached patch to Ted but that never made it to the
> > kernel. It _really_ solved the problem as I had a crash sometimes within
> > 15 minutes and after applying it I reached uptimes over 100 days.
> >
>
> It looks like somebody has already had a go at fixing this in current
> kernels - the restore_flags() has been moved to the end of
> shutdown().  (It's not a complete fix, because request_irq() can
> schedule).
>
> Are you able to test 2.4.17?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

