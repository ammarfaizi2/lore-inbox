Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbTBLP0d>; Wed, 12 Feb 2003 10:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTBLP0d>; Wed, 12 Feb 2003 10:26:33 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:21007 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267229AbTBLP03>; Wed, 12 Feb 2003 10:26:29 -0500
Date: Wed, 12 Feb 2003 15:36:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>, jsimmons@infradead.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (12/34) console
Message-ID: <20030212153617.A10171@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>, jsimmons@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp> <20030212134233.GM1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030212134233.GM1551@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Wed, Feb 12, 2003 at 10:42:33PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 10:42:33PM +0900, Osamu Tomita wrote:
> +ifneq ($(CONFIG_X86_PC9800),y)
>  FONTMAPFILE = cp437.uni
> +else
> +FONTMAPFILE = pc9800.uni
> +endif

This should be

ifeq ($(CONFIG_X86_PC9800),y)
FONTMAPFILE = pc9800.uni
else
FONTMAPFILE = cp437.uni
endif

but I really wonder whether there's something nicer possible


> diff -Nru linux/drivers/char/console_macros.h linux98/drivers/char/console_macros.h
> --- linux/drivers/char/console_macros.h	Sat Oct 19 13:01:17 2002
> +++ linux98/drivers/char/console_macros.h	Mon Oct 28 16:53:39 2002
> @@ -55,6 +55,10 @@
>  #define	s_reverse	(vc_cons[currcons].d->vc_s_reverse)
>  #define	ulcolor		(vc_cons[currcons].d->vc_ulcolor)
>  #define	halfcolor	(vc_cons[currcons].d->vc_halfcolor)
> +#define def_attr	(vc_cons[currcons].d->vc_def_attr)
> +#define ul_attr		(vc_cons[currcons].d->vc_ul_attr)
> +#define half_attr	(vc_cons[currcons].d->vc_half_attr)
> +#define bold_attr	(vc_cons[currcons].d->vc_bold_attr)

Bah, console_macros.h should just die.

> diff -Nru linux/drivers/char/console_pc9800.h linux98/drivers/char/console_pc9800.h
> --- linux/drivers/char/console_pc9800.h	Thu Jan  1 09:00:00 1970
> +++ linux98/drivers/char/console_pc9800.h	Mon Oct 28 11:48:10 2002

I think this should all be in include/linux/console.h.

> --- linux/drivers/char/vt.c	2002-12-16 11:08:16.000000000 +0900
> +++ linux98/drivers/char/vt.c	2002-12-20 14:52:06.000000000 +0900
> @@ -75,6 +75,9 @@
>   */
>  
>  #include <linux/module.h>
> +#ifdef CONFIG_X86_PC9800
> +#define CONFIG_KANJI
> +#endif

Please set CONFIG_KANJI in the Kconfig file and in general
the CONFIG_KANJI usere look really messy.  I don't think it's
easy to get them cleaned up before 2.6, you might get in contact
with James who works on the console layer to properly integrate them.

