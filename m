Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSHTUku>; Tue, 20 Aug 2002 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSHTUku>; Tue, 20 Aug 2002 16:40:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27779 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317331AbSHTUkt>; Tue, 20 Aug 2002 16:40:49 -0400
Date: Tue, 20 Aug 2002 16:47:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
cc: Mike Galbraith <efault@gmx.de>, Gilad Ben-Yossef <gilad@benyossef.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Alloc and lock down large amounts of memory
In-Reply-To: <23B25974812ED411B48200D0B774071701248C6A@exchusa03.intense3d.com>
Message-ID: <Pine.LNX.3.95.1020820163301.27264A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, Bhavana Nagendra wrote:

> > 
> > Curiosity:  why do you want to do device DMA buffer 
> > allocation from userland?
> 
> I need 256M memory for a graphics operation.  It's a requiremment,
> can't change it. There will be other reasonably sized allocs in kernel 
> space, this is a special case that will be done from userland. As 
> discussed earlier in this thread, there's no good way of alloc()ing 
> and pinning that much in DMA memory space, is there?
> 
> Gilad, I looked at mm/memory.c and map_user_kiobuf() lets me
> map user memory into kernel memory and pins it down.  A scatter 
> gatter mapping (say, pci_map_sg()) will create a seemingly 
> contiguous buffer for DMA purposes.  Does that sound right to you?
> 
> Bhavana

You have to cheat. You can tell the kernel that you only have, say
128 Meg of RAM. Then, your driver adds PTEs for all the other
RAM you really have, easy ioremap(). The kernel doesn't know
nor care that there is RAM at those addresses. You can even call
request_mem_region() so that /proc/iomem has your entries in it.
This gets you all the real RAM you need plus it's guaranteed to
be contiguous and never paged.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

