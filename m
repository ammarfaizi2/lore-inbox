Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287139AbSBBWdX>; Sat, 2 Feb 2002 17:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSBBWdO>; Sat, 2 Feb 2002 17:33:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287139AbSBBWc6>;
	Sat, 2 Feb 2002 17:32:58 -0500
Message-ID: <3C5C68E2.32D11734@zip.com.au>
Date: Sat, 02 Feb 2002 14:32:02 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Christensen <larsch@cs.auc.dk>
CC: linux-kernel@vger.kernel.org, linux-bugs@nvidia.com
Subject: Re: 2.4.17 agpgart process hang on crash
In-Reply-To: <Pine.GSO.4.33.0202022219340.29744-100000@peta.cs.auc.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Christensen wrote:
> 
> Hi. I have experienced a problem with the combination of kernel-2.4.16,
> the kernel agpgart module and NVIDIA supplied drivers. I don't know which
> is the cause of the problem.
> 
> Symptoms: Whenever an OpenGL application crashes (segfault etc.), the
> process hangs and can't be killed. Responds to no signals (not even 9). ps
> -ef hangs, it seems, when the crashed process is to be listed (some other
> processes are listed first).
> 
> Hardware: AMD Athlon 1.333HGZ, ASUS M266 motherboard (AMD761 AGP
> chipset), NVIDIA GeForce2 MX400 gfx card.
> 
> The mem=nopentium option have no effect on the problem, but it doesn't
> occur if I use the NVIDIA AGP drivers or kernel 2.4.16 agp drivers. I am
> not able to test the 2.4.17 agpgart with other 3D hardware that nvidia.
> 

This is possibly because the crashing application tries to dump
core, and the kernel gets a fault accessing the video card's
mapping, and deadlocks over the recursive attempt to take mmap_sem.

Please apply this patch:

	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre7/fbmem-mmap.patch

and send a report back.

-
