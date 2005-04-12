Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVDLK2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVDLK2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVDLK2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:28:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:53702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262101AbVDLK2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:28:01 -0400
Date: Tue, 12 Apr 2005 03:27:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: jes@trained-monkey.org (Jes Sorensen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-Id: <20050412032747.51c0c514.akpm@osdl.org>
In-Reply-To: <16987.39773.267117.925489@jaguar.mkp.net>
References: <16987.39773.267117.925489@jaguar.mkp.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Walk the EFI memory map to pull out leftover pages in the lower
> + * memory regions which do not end up in the regular memory map and
> + * stick them into the uncached allocator
> + */
> +static void __init
> +mspec_walk_efi_memmap_uc (void)
> +{
> +	void *efi_map_start, *efi_map_end, *p;
> +	efi_memory_desc_t *md;
> +	u64 efi_desc_size, start, end;
> +
> +	efi_map_start = __va(ia64_boot_param->efi_memmap);
> +	efi_map_end = efi_map_start + ia64_boot_param->efi_memmap_size;
> +	efi_desc_size = ia64_boot_param->efi_memdesc_size;
> +
> +	for (p = efi_map_start; p < efi_map_end; p += efi_desc_size) {
> +		md = p;
> +		if (md->attribute == EFI_MEMORY_UC) {
> +			start = PAGE_ALIGN(md->phys_addr);
> +			end = PAGE_ALIGN((md->phys_addr+(md->num_pages << EFI_PAGE_SHIFT)) & PAGE_MASK);
> +			if (mspec_build_memmap(start, end) < 0)
> +				return;
> +		}
> +	}
> +}
> +

Does this compile without CONFIG_EFI?

(It seems that ia64 Kconfig tries to turn on EFI always, but I thing
allnoconfig will turn it off)

> --- linux-2.6.12-rc2-mm3-vanilla/include/asm-ia64/sn/fetchop.h	2005-03-01 23:38:12 -08:00
> +++ linux-2.6.12-rc2-mm3/include/asm-ia64/sn/fetchop.h	1969-12-31 16:00:00 -08:00

Did you mean to remove fetchop.h?

> --- linux-2.6.12-rc2-mm3-vanilla/include/asm-ia64/sn/mspec.h	1969-12-31 16:00:00 -08:00
> +++ linux-2.6.12-rc2-mm3/include/asm-ia64/sn/mspec.h	2005-04-12 02:14:06 -07:00

I guess so.


