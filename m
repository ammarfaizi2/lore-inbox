Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbREWUr3>; Wed, 23 May 2001 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbREWUrT>; Wed, 23 May 2001 16:47:19 -0400
Received: from cmn2.cmn.net ([206.168.145.10]:5391 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S263253AbREWUrH>;
	Wed, 23 May 2001 16:47:07 -0400
Message-ID: <3B0C21AB.1000800@valinux.com>
Date: Wed, 23 May 2001 14:46:35 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: Christophe Beaumont <christophe@paracel.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: HUGE contiguous mem space with 2.4
In-Reply-To: <NFBBINOGHMOOBMPNBAHKMEFLCAAA.christophe@paracel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Beaumont wrote:

> Hi...
> 
> I am facing an odd problem here. I have an application here
> that requires a HUGE physically contiguous memory area to 
> be locked (yes, I have hardware DMA'ing in and out of that
> area, over the PCI bus). HUGE being like one Gig (could be
> more if needed...)
> I am trying to use the mem=1024M option at boot time (yes,
> the box has 2 Gigs of RAM) and then ioremap() from within 
> my module. There I have a couple of issues:
>  - if I use high_memory as is, I cannot remap any area 
> (high_memory=f800:0000 ???)
>  - if I use high_memory thru virt_to_phys, I can then remap...
> up to 64 Megs (maybe a little more, but for sure less than
> 128 Megs) (virt_to_phys(high_mem)=3800:0000)
> 
> I tried with other values (like mem=250M 512M 1536M) and could
> NOT remap anything close to the whole amount of "reserved" memory
> (best case being with mem=256M I can remap 512M out of 1.75Gigs)
> 
You are running out of virtual address space in the kernel.  Either 
don't map the whole thing all the time (this is really the best solution 
since it works with stock kernels), or hack up your kernel to have more 
virtual address space reserved for the kernel.  This will have the side 
effect of reducing the amount of memory an application can use at one time.

Another solution is to have the driver in user space, were you should be 
able to mmap a much larger amount of device memory.  If your application 
requires no interrupt handling, and can always be run as root, you could 
probably get away with no kernel support at all.  Just use /dev/mem to 
mmap the device and your dma memory.

-Jeff

