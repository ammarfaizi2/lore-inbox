Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWJMSTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWJMSTZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWJMSTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:19:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33035 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751798AbWJMSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:19:25 -0400
Date: Fri, 13 Oct 2006 20:19:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephane Eranian <eranian@hpl.hp.com>, sam@ravnborg.org
Subject: Re: [PATCH] rename net_random to random32
Message-ID: <20061013181922.GB721@stusta.de>
References: <200610111900.k9BJ01M4021853@hera.kernel.org> <452D4491.30806@garzik.org> <20061011122938.7e81f4bc@freekitty> <20061012000749.be62f2e0.akpm@osdl.org> <20061012102638.7381269a@freekitty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012102638.7381269a@freekitty>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 10:26:38AM -0700, Stephen Hemminger wrote:
> 
> Make net_random() more widely available by calling it random32
>...
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -5,7 +5,7 @@ #
>  lib-y := ctype.o string.o vsprintf.o cmdline.o \
>  	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
>  	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
> -	 sha1.o irq_regs.o carta_random32.o
> +	 sha1.o irq_regs.o random32.o carta_random32.o
>...
> --- /dev/null
> +++ b/lib/random32.c
>...
> +EXPORT_SYMBOL(random32);
>...
> +EXPORT_SYMBOL(srandom32);
>...

EXPORT_SYMBOL's in lib-y are latent bugs (IMHO kbuild should error
on them):

The problem is that if only modules use these functions, they will be 
omitted from the kernel image.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

