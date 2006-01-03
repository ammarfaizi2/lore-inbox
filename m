Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWACXta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWACXta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWACXtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:49:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46520 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964994AbWACXsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:48:52 -0500
Date: Tue, 3 Jan 2006 15:48:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [Patch] es7000 broken without acpi
Message-Id: <20060103154808.5ca0d1a4.akpm@osdl.org>
In-Reply-To: <1134427819.18385.2.camel@alice>
References: <1134427819.18385.2.camel@alice>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn / snakebyte <snakebyte@gmx.de> wrote:
>
> hi,
> 
> a make randconfig gave me a situation where es7000 was enabled, but acpi wasnt 
> ( dont know if this makes sense ), gcc gave me some compiling errors, which the
> following patch fixes. Please cc me as i am not on the list. Thanks.
> 
> 

I believe that es7000 requires ACPI, so a better fix would be to enforce
that within Kconfig.

Natalie, can you please comment?

> 
> 
> diff -up linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000.h linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000.h
> --- linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000.h	2005-12-12 23:44:39.000000000 +0100
> +++ linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000.h	2005-12-12 23:43:51.000000000 +0100
> @@ -83,6 +83,7 @@ struct es7000_oem_table {
>  	struct psai psai;
>  };
>  
> +#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
>  struct acpi_table_sdt {
>  	unsigned long pa;
>  	unsigned long count;
> @@ -98,6 +99,7 @@ struct oem_table {
>  	u32 OEMTableAddr;
>  	u32 OEMTableSize;
>  };
> +#endif
>  
>  struct mip_reg {
>  	unsigned long long off_0;
> diff -up linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000plat.c linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000plat.c
> --- linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000plat.c	2005-12-12 23:44:39.000000000 +0100
> +++ linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000plat.c	2005-12-12 23:43:20.000000000 +0100
> @@ -92,7 +92,9 @@ setup_unisys(void)
>  		es7000_plat = ES7000_ZORRO;
>  	else
>  		es7000_plat = ES7000_CLASSIC;
> +#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
>  	ioapic_renumber_irq = es7000_rename_gsi;
> +#endif
>  }
>  
>  /*
> @@ -160,6 +162,7 @@ parse_unisys_oem (char *oemptr)
>  	return es7000_plat;
>  }
>  
> +#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
>  int __init
>  find_unisys_acpi_oem_table(unsigned long *oem_addr)
>  {
> @@ -212,6 +215,7 @@ find_unisys_acpi_oem_table(unsigned long
>  	}
>  	return -1;
>  }
> +#endif
>  
>  static void
>  es7000_spin(int n)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
