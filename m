Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVLIRc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVLIRc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLIRc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:32:58 -0500
Received: from colin.muc.de ([193.149.48.1]:11012 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932455AbVLIRc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:32:57 -0500
Date: 9 Dec 2005 18:32:49 +0100
Date: Fri, 9 Dec 2005 18:32:49 +0100
From: Andi Kleen <ak@muc.de>
To: Matt Tolentino <metolent@cs.vt.edu>
Cc: akpm@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       matthew.e.tolentino@intel.com
Subject: Re: [patch 3/3] add x86-64 support for memory hot-add
Message-ID: <20051209173249.GA54033@muc.de>
References: <200512091523.jB9FNn5J006697@ap1.cs.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512091523.jB9FNn5J006697@ap1.cs.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 10:23:49AM -0500, Matt Tolentino wrote:
> --- linux-2.6.15-rc5/arch/x86_64/mm/init.c	2005-12-04 00:10:42.000000000 -0500
> +++ linux-2.6.15-rc5-matt/arch/x86_64/mm/init.c	2005-12-08 15:02:30.000000000 -0500
> @@ -23,6 +23,8 @@
>  #include <linux/bootmem.h>
>  #include <linux/proc_fs.h>
>  #include <linux/pci.h>
> +#include <linux/module.h>
> +#include <linux/memory_hotplug.h>
>  
>  #include <asm/processor.h>
>  #include <asm/system.h>
> @@ -174,13 +176,19 @@ static  struct temp_map { 
>  	{}
>  }; 
>  
> -static __init void *alloc_low_page(int *index, unsigned long *phys) 
> +static __devinit void *alloc_low_page(int *index, unsigned long *phys) 

These should be all __cpuinit.

In general SRAT has a hotplug memory bit so it's possible
to predict how much memory there will be in advance. Since
the overhead of the kernel page tables should be very
low I would prefer if you just used instead.

(i.e. instead of extending the kernel mapping preallocate
the direct mapping and just clear the P bits) 

That should be much simpler.

-Andi

