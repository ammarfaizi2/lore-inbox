Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUASO23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUASO1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:27:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1456 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265094AbUASO04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:26:56 -0500
Message-ID: <400BE923.1020505@pobox.com>
Date: Mon, 19 Jan 2004 09:26:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modernize i386 string.h
References: <20040118200919.GA26573@averell>
In-Reply-To: <20040118200919.GA26573@averell>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> This patch modernizes i386 string.h. It removes all the fragile i386
> inline str* functions and just switches to gcc's builtin variants.
> Modern gcc should generate equivalent or better code. Sometimes it
> calls out-of-line code, in that case the standard C functions in
> lib/string.c is used. 
[...]
> diff -u linux-string/arch/i386/kernel/i386_ksyms.c-STRING linux-string/arch/i386/kernel/i386_ksyms.c
> --- linux-string/arch/i386/kernel/i386_ksyms.c-STRING	2003-10-09 00:28:44.000000000 +0200
> +++ linux-string/arch/i386/kernel/i386_ksyms.c	2004-01-18 13:26:36.479533784 +0100
> @@ -133,6 +133,38 @@
>  EXPORT_SYMBOL(pcibios_get_irq_routing_table);
>  #endif
>  
> +/* Export string functions. We normally rely on gcc builtin for most of these,
> +   but gcc sometimes decides not to inline them. */    
> +#undef memchr
> +#undef strlen
> +#undef strcpy
> +#undef strncmp
> +#undef strncpy
> +#undef strchr	
> +#undef strcmp 
> +#undef strcpy 
> +#undef strcat
> +
> +extern size_t strlen(const char *);
> +extern char * strcpy(char * dest,const char *src);
> +extern int strcmp(const char * cs,const char * ct);
> +extern void *memchr(const void *s, int c, size_t n);
> +extern char * strcat(char *, const char *);

ISTR this patch being shot down in the past...

It seems suboptimal for people with ancient compilers, or for people on 
embedded 486's, doesn't it?

	Jeff



