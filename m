Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSKFN7V>; Wed, 6 Nov 2002 08:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265327AbSKFN7U>; Wed, 6 Nov 2002 08:59:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7809 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265325AbSKFN7T>; Wed, 6 Nov 2002 08:59:19 -0500
Date: Wed, 6 Nov 2002 09:07:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Marc A. Volovic" <marc@bard.org.il>
cc: Pannaga Bhushan <bhushan@multitech.co.in>, linux-kernel@vger.kernel.org
Subject: Re: A hole in kernel space!
In-Reply-To: <20021106134935.GA24234@glamis.bard.org.il>
Message-ID: <Pine.LNX.3.95.1021106085810.3962A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Marc A. Volovic wrote:

> Quoth Pannaga Bhushan:
> 
> > Hi all,
> >         I am looking for a setup where I need to have a certain amount
> > of data always available to the kernel. The size of data I am looking at
> > is abt
> > 40MB(preferably, but I will settle for 20MB too) . So the normal kmalloc
> 
> I wrote a driver which steals a certain amount of memory from the kernel
> and makes it available to userspace (somewhat like the rd driver).
> If you want - I can send it to you.
> 
> It exports a small device hierarchy which can be read, written and
> mmap'ed. The memory is contiguous. Not VERY elegant, but works quite
> well.
> 
> The driver steals a certain amount of memory from the kernel at boot
> time, a-la the mem= parameter. I have used "holes" of up to 1GB in size.
> 
> 
> Marc

You know, I hope, that you can kmalloc(GFP_KERNEL) something in
init_module() and it will always be resident in the kernel until
you kfree() it in cleanup_module(). You do not have to
allocate/deallocate every time your module does something.

If you need a physical location, mmap() and ioremap() take care
of that. With these capabilities, I don't think you need "holes"
even if you are trying to map-out bad RAM. I think you need to
re-think your requirements. 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


