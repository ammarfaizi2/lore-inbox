Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTFZSZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTFZSZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:25:58 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:8712 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262267AbTFZSZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:25:57 -0400
Date: Thu, 26 Jun 2003 20:40:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Matthew Wilcox <willy@debian.org>
cc: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BINFMT_ZFLAT can't be a module
In-Reply-To: <20030626180909.GP451@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0306262036030.11817-100000@serv>
References: <20030626180909.GP451@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Jun 2003, Matthew Wilcox wrote:

> BINFMT_ZFLAT is an attribute of BINFMT_FLAT not a distinct option in
> its own right.  So the test in lib/Kconfig has to be changed to something
> like this:
> 
> Index: lib/Kconfig
> ===================================================================
> RCS file: /var/cvs/linux-2.5/lib/Kconfig,v
> retrieving revision 1.4
> diff -u -p -r1.4 Kconfig
> --- lib/Kconfig	8 Apr 2003 15:20:57 -0000	1.4
> +++ lib/Kconfig	26 Jun 2003 18:07:41 -0000
> @@ -17,8 +17,8 @@ config CRC32
>  #
>  config ZLIB_INFLATE
>  	tristate
> -	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || BINFMT_ZFLAT=y || CRYPTO_DEFLATE=y
> -	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || BINFMT_ZFLAT=m || CRYPTO_DEFLATE=m
> +	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || CRYPTO_DEFLATE=y || (BINFMT_FLAT=y && BINFMT_ZFLAT=y)
> +	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || CRYPTO_DEFLATE=m || (BINFMT_FLAT=m && BINFMT_ZFLAT=y)

This can be simplified now to:

config ZLIB_INFLATE
	def_tristate CRAMFS || PPP_DEFLATE || JFFS2_FS || \
		     ZISOFS_FS || CRYPTO_DEFLATE || \
		     (BINFMT_FLAT && BINFMT_ZFLAT)

bye, Roman

