Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTKLVCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 16:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTKLVCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 16:02:09 -0500
Received: from LION.SEAS.UPENN.EDU ([158.130.12.194]:13228 "EHLO
	lion.seas.upenn.edu") by vger.kernel.org with ESMTP id S261595AbTKLVCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 16:02:06 -0500
Date: Wed, 12 Nov 2003 16:01:58 -0500
From: Peng Li <lipeng@acm.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Suetterlin <P.Suetterlin@astro.uu.nl>, linux-kernel@vger.kernel.org
Subject: Re: 512MB/1GB RAM
Message-ID: <20031112210158.GA20865@seas.upenn.edu>
References: <20031110163546.GA15096@hst33127.phys.uu.nl> <Pine.LNX.4.44.0311100904280.5284-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311100904280.5284-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch works for me.  Thanks.

I used to patch the copy_e820_map() by filling some holes in the
BIOS memory region as E820_RESERVED, i.e.

add_memory_region(0x3ff7a000ULL,0x3ff80000ULL-0x3ff7a000ULL,E820_RESERVED);

Otherwise some of my PCI devices will be mapped to somewhere between
0x3ff7a000 and 0x3ff80000, which doesn't seem to work.  Is it a bug of
the BIOS?

Linux version 2.6.0-test9 (root@think) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r2, propolice)) #11 Wed Nov 12 15:42:56 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff60000 (usable)
 BIOS-e820: 000000003ff60000 - 000000003ff78000 (ACPI data)
 BIOS-e820: 000000003ff78000 - 000000003ff7a000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)

-- Peng

On Mon, Nov 10, 2003 at 09:08:34AM -0800, Linus Torvalds wrote:
> Try this patch and tell me if it makes a difference.
> 
> --- 1.102/arch/i386/kernel/setup.c	Tue Oct 21 22:10:28 2003
> +++ edited/arch/i386/kernel/setup.c	Mon Nov 10 08:23:46 2003
> @@ -87,7 +87,7 @@
>  unsigned int mca_pentium_flag;
>  
>  /* For PCI or other memory-mapped resources */
> -unsigned long pci_mem_start = 0x10000000;
> +unsigned long pci_mem_start = 0x40000000;
>  
>  /* user-defined highmem size */
>  static unsigned int highmem_pages = -1;
> 
