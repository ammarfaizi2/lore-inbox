Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWF2UmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWF2UmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWF2UmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:42:09 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:24914 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932459AbWF2UmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:42:07 -0400
Date: Thu, 29 Jun 2006 13:42:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>, gregkh@suse.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060629204206.GA3010@tuatara.stupidest.org>
References: <200606291801.k5TI12br003227@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606291801.k5TI12br003227@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what am i missing here?

> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -529,6 +529,7 @@ config X86_PAE
>  	bool
>  	depends on HIGHMEM64G
>  	default y
> +	select RESOURCES_64BIT
>  
>  # Common NUMA Features
>  config NUMA

this isn't a similar option for x86_64, so...


> diff --git a/include/linux/types.h b/include/linux/types.h
> index a021e15..3f23566 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -178,9 +178,14 @@ #endif
>  #ifdef __KERNEL__
>  typedef unsigned __bitwise__ gfp_t;
>  
> -typedef unsigned long resource_size_t;
> +#ifdef CONFIG_RESOURCES_64BIT
> +typedef u64 resource_size_t;
> +#else
> +typedef u32 resource_size_t;
>  #endif
>  
> +#endif	/* __KERNEL__ */
> +
>  struct ustat {
>  	__kernel_daddr_t	f_tfree;
>  	__kernel_ino_t		f_tinode;

means that on x86_64 resource_size_t will ot be 32-bit when previously
it was 64
