Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUASPFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265159AbUASPFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:05:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:58757 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265149AbUASPFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:05:01 -0500
Date: Mon, 19 Jan 2004 10:06:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modernize i386 string.h
In-Reply-To: <400BE923.1020505@pobox.com>
Message-ID: <Pine.LNX.4.53.0401191003070.6753@chaos>
References: <20040118200919.GA26573@averell> <400BE923.1020505@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Jeff Garzik wrote:

> Andi Kleen wrote:
> > This patch modernizes i386 string.h. It removes all the fragile i386
> > inline str* functions and just switches to gcc's builtin variants.
> > Modern gcc should generate equivalent or better code. Sometimes it
> > calls out-of-line code, in that case the standard C functions in
> > lib/string.c is used.
> [...]
> > diff -u linux-string/arch/i386/kernel/i386_ksyms.c-STRING linux-string/arch/i386/kernel/i386_ksyms.c
> > --- linux-string/arch/i386/kernel/i386_ksyms.c-STRING	2003-10-09 00:28:44.000000000 +0200
> > +++ linux-string/arch/i386/kernel/i386_ksyms.c	2004-01-18 13:26:36.479533784 +0100
> > @@ -133,6 +133,38 @@
> >  EXPORT_SYMBOL(pcibios_get_irq_routing_table);
> >  #endif
> >
> > +/* Export string functions. We normally rely on gcc builtin for most of these,
> > +   but gcc sometimes decides not to inline them. */
> > +#undef memchr
> > +#undef strlen
> > +#undef strcpy
> > +#undef strncmp
> > +#undef strncpy
> > +#undef strchr
> > +#undef strcmp
> > +#undef strcpy
> > +#undef strcat
> > +
> > +extern size_t strlen(const char *);
> > +extern char * strcpy(char * dest,const char *src);
> > +extern int strcmp(const char * cs,const char * ct);
> > +extern void *memchr(const void *s, int c, size_t n);
> > +extern char * strcat(char *, const char *);
>
> ISTR this patch being shot down in the past...
>
> It seems suboptimal for people with ancient compilers, or for people on
> embedded 486's, doesn't it?
>
> 	Jeff
>

I don't think so. It helps reduce the size of the code by having
only one copy of each routine in memory rather than zillions.

If your code can't stand the overhead of the call/return, then
you put some inline code at that particular place, not everywhere!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


