Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132767AbRDEL7n>; Thu, 5 Apr 2001 07:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132852AbRDEL7e>; Thu, 5 Apr 2001 07:59:34 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:33996 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132767AbRDEL7W>; Thu, 5 Apr 2001 07:59:22 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200104050947.LAA08111@sunrise.pg.gda.pl>
Subject: Re: Config printk buffer size
To: ted@cypress.com (Thomas Dodd)
Date: Thu, 5 Apr 2001 11:47:04 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3ACBB9B8.72792AAA@cypress.com> from "Thomas Dodd" at Apr 04, 2001 07:18:00 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Thomas Dodd wrote:"
> diff -u --new-file --recursive linux-2.4.3-ac2.orig/kernel/printk.c linux-2.4.3-ac2/kernel/printk.c
> --- linux-2.4.3-ac2.orig/kernel/printk.c	Wed Apr  4 15:23:31 2001
> +++ linux-2.4.3-ac2/kernel/printk.c	Wed Apr  4 16:01:28 2001
> @@ -27,7 +27,7 @@
>  
>  #include <asm/uaccess.h>
>  
> -#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
> +#define LOG_BUF_LEN (CONFIG_PRINTK_BUF_LEN*1024) /* This must be a power of two */
>  #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
>  

IMO, it would be nice to add a test here whether the CONFIG_PRINTK_BUF_LEN
value is really set as a power of two, eg.:

#if (LOG_BUF_LEN & LOG_BUF_MASK)
#error CONFIG_PRINTK_BUF_LEN must be a power of two
#endif

(above works with egcs-2.91.66)

Andrzej
