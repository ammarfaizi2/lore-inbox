Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbTDVJeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbTDVJeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:34:50 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:2187 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263029AbTDVJet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:34:49 -0400
Date: Tue, 22 Apr 2003 11:46:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use __GFP_REPEAT in pmd_alloc_one()
In-Reply-To: <200304202224.h3KMOE4q003663@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0304221033150.15088-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1124.1.25, 2003/04/20 14:28:32-07:00, akpm@digeo.com
> 
> 	[PATCH] use __GFP_REPEAT in pmd_alloc_one()
> 	
> 	Convert all pmd_alloc_one() implementations to use __GFP_REPEAT

If this change was bogus (cfr. Davem's checkin):

> diff -Nru a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
> --- a/arch/sparc/mm/sun4c.c	Sun Apr 20 15:24:17 2003
> +++ b/arch/sparc/mm/sun4c.c	Sun Apr 20 15:24:17 2003
> @@ -2194,7 +2194,7 @@
>  	BTFIXUPSET_CALL(pte_alloc_one_kernel, sun4c_pte_alloc_one_kernel, BTFIXUPCALL_NORM);
>  	BTFIXUPSET_CALL(pte_alloc_one, sun4c_pte_alloc_one, BTFIXUPCALL_NORM);
>  	BTFIXUPSET_CALL(free_pmd_fast, sun4c_free_pmd_fast, BTFIXUPCALL_NOP);
> -	BTFIXUPSET_CALL(pmd_alloc_one, sun4c_pmd_alloc_one, BTFIXUPCALL_RETO0);
> +	BTFIXUPSET_CALL(pmd_alloc_one, sun4c_lpmd_alloc_one, BTFIXUPCALL_RETO0);
>  	BTFIXUPSET_CALL(free_pgd_fast, sun4c_free_pgd_fast, BTFIXUPCALL_NORM);
>  	BTFIXUPSET_CALL(get_pgd_fast, sun4c_get_pgd_fast, BTFIXUPCALL_NORM);

Then this one is bogus, too:

> diff -Nru a/include/asm-m68k/sun3_pgalloc.h b/include/asm-m68k/sun3_pgalloc.h
> --- a/include/asm-m68k/sun3_pgalloc.h	Sun Apr 20 15:24:17 2003
> +++ b/include/asm-m68k/sun3_pgalloc.h	Sun Apr 20 15:24:17 2003
> @@ -18,7 +18,7 @@
>  
>  extern const char bad_pmd_string[];
>  
> -#define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
> +#define lpmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
>  
>  

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds




