Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbSBBXOS>; Sat, 2 Feb 2002 18:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbSBBXOI>; Sat, 2 Feb 2002 18:14:08 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:59639 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP
	id <S276424AbSBBXN5>; Sat, 2 Feb 2002 18:13:57 -0500
Date: Sun, 3 Feb 2002 00:13:54 +0100 (MET)
From: Lars Christensen <larsch@cs.auc.dk>
To: <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.17 agpgart process hang on crash
In-Reply-To: <3C5C68E2.32D11734@zip.com.au>
Message-ID: <Pine.GSO.4.33.0202030009280.794-100000@peta.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2002, Andrew Morton wrote:

> Lars Christensen wrote:
> >
> > Hi. I have experienced a problem with the combination of kernel-2.4.16,
> > the kernel agpgart module and NVIDIA supplied drivers. I don't know which
> > is the cause of the problem.
> >
> > Symptoms: Whenever an OpenGL application crashes (segfault etc.), the
> > process hangs and can't be killed. Responds to no signals (not even 9). ps
> > -ef hangs, it seems, when the crashed process is to be listed (some other
> > processes are listed first).
> >
> > Hardware: AMD Athlon 1.333HGZ, ASUS M266 motherboard (AMD761 AGP
> > chipset), NVIDIA GeForce2 MX400 gfx card.
> >
> > The mem=nopentium option have no effect on the problem, but it doesn't
> > occur if I use the NVIDIA AGP drivers or kernel 2.4.16 agp drivers. I am
> > not able to test the 2.4.17 agpgart with other 3D hardware that nvidia.
> >
>
> This is possibly because the crashing application tries to dump
> core, and the kernel gets a fault accessing the video card's
> mapping, and deadlocks over the recursive attempt to take mmap_sem.
>
> Please apply this patch:
>
> 	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre7/fbmem-mmap.patch
>
> and send a report back.

No luck. Still hangs (e.g. with ./testgart & pkill -ABRT testgart), with
and without that patch and with and without 2.4.18-pre7. Does seem to
happen when dumping core--it doesn't happen with core dumping disabled.

-- 
Lars Christensen, larsch@cs.auc.dk

