Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWAJRvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWAJRvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWAJRvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:51:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9932 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932290AbWAJRve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:51:34 -0500
Date: Tue, 10 Jan 2006 17:51:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Christoph Hellwig <hch@infradead.org>, Roland Dreier <rdreier@cisco.com>,
       sam@ravnborg.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-ID: <20060110175131.GA5235@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bryan O'Sullivan <bos@pathscale.com>,
	Roland Dreier <rdreier@cisco.com>, sam@ravnborg.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <patchbomb.1136579193@eng-12.pathscale.com> <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com> <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com> <1136909276.32183.28.camel@serpentine.pathscale.com> <20060110170722.GA3187@infradead.org> <1136915386.6294.8.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136915386.6294.8.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:49:46AM -0800, Bryan O'Sullivan wrote:
> On Tue, 2006-01-10 at 17:07 +0000, Christoph Hellwig wrote:
> 
> > Or add a CONFIG_GENERIC_MEMCPY_IO that's non-uservisible and just set
> > by all the architectures that don't provide their own version.
> 
> Here's another i386-only review patch that does essentially that.  It
> looks cleaner to me than my previous patch from this morning.
> (Copyrights and other arches omitted, for clarity.)
> 
> What do you think?
> 
> 	<b
> 
> diff -r 48616306e7bd lib/Makefile
> --- a/lib/Makefile	Tue Jan 10 10:41:42 2006 +0800
> +++ b/lib/Makefile	Tue Jan 10 09:32:53 2006 -0800
> @@ -21,6 +21,7 @@
>  lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
>  lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
>  lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
> +lib-$(CONFIG_GENERIC_RAW_MEMCPY_IO) += raw_memcpy_io.o
>  obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
>  obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
>  
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/include/asm-generic/raw_memcpy_io.h	Tue Jan 10 09:32:53 2006 -0800
> @@ -0,0 +1,16 @@
> +#ifndef _ASM_GENERIC_RAW_MEMCPY_IO_H
> +#define _ASM_GENERIC_RAW_MEMCPY_IO_H
> +
> +/*
> + * __raw_memcpy_toio32 - copy data to MMIO space, in 32-bit units
> + *
> + * Order of access is not guaranteed, nor is a memory barrier performed
> + * afterwards.  This is an arch-independent generic implementation.
> + *
> + * @to: destination, in MMIO space (must be 32-bit aligned)
> + * @from: source (must be 32-bit aligned)
> + * @count: number of 32-bit quantities to copy
> + */

This should be in the implementation file, not near the prototype.
And needs to start with /** to be valid kernel doc.

> +void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);

and without that comment I'd suggest just adding this to every asm/io.h
instead of an asm-generic header for just one prototype.

