Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288528AbSADHyP>; Fri, 4 Jan 2002 02:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288530AbSADHyG>; Fri, 4 Jan 2002 02:54:06 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:57829 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S288528AbSADHxt>; Fri, 4 Jan 2002 02:53:49 -0500
Date: Fri, 4 Jan 2002 08:53:19 +0100 (CET)
From: kees <kees@schoen.nl>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] solves freeze due to serial comm. on SMP
In-Reply-To: <3C33F01E.EC95DD82@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201040852180.6267-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

I'll give it a try, but from what I experienced in those days was that
adding the _spinlock protection_ finally solved all.

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

