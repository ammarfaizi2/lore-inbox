Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUEULFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUEULFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbUEULFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:05:24 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:43016 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265517AbUEULFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:05:16 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: pavel@ucw.cz (Pavel Machek), linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Organization: Core
In-Reply-To: <20040521100734.GA31550@elf.ucw.cz>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BR7pl-0000Br-00@gondolin.me.apana.org.au>
Date: Fri, 21 May 2004 21:05:01 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
> 
> --- tmp/linux/arch/i386/mm/init.c       2004-05-20 23:08:05.000000000 +0200
> +++ linux/arch/i386/mm/init.c   2004-05-20 23:10:50.000000000 +0200
> @@ -331,6 +331,13 @@
> void zap_low_mappings (void)
> {
>        int i;
> +
> +#ifdef CONFIG_SOFTWARE_SUSPEND

Can you please define this for CONFIG_PM_DISK as well? Alternatively,
you can do the same as you did in cpu.c and define this for CONFIG_PM.
         *
> --- tmp/linux/arch/i386/power/cpu.c     2004-05-20 23:08:05.000000000 +0200
> +++ linux/arch/i386/power/cpu.c 2004-05-20 23:10:50.000000000 +0200
> @@ -35,6 +35,10 @@
> unsigned long saved_context_esi, saved_context_edi;
> unsigned long saved_context_eflags;
> 
> +/* Special page directory for resume */
> +char __nosavedata swsusp_pg_dir[PAGE_SIZE]
> +                  __attribute__ ((aligned (PAGE_SIZE)));
> +
> extern void enable_sep_cpu(void *);

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
