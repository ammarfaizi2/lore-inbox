Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWAJRIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWAJRIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWAJRIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:08:12 -0500
Received: from mivlgu.ru ([81.18.140.87]:51664 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S932262AbWAJRIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:08:11 -0500
Date: Tue, 10 Jan 2006 20:07:55 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-Id: <20060110200755.55ee8215.vsu@altlinux.ru>
In-Reply-To: <20060110143931.GM3389@suse.de>
References: <20060110125852.GA3389@suse.de>
	<20060110132957.GA28666@elte.hu>
	<20060110133728.GB3389@suse.de>
	<Pine.LNX.4.63.0601100840400.9511@winds.org>
	<20060110143931.GM3389@suse.de>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__10_Jan_2006_20_07_55_+0300_CoTgJf0JgqHuFgZs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__10_Jan_2006_20_07_55_+0300_CoTgJf0JgqHuFgZs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 10 Jan 2006 15:39:31 +0100 Jens Axboe wrote:

> --- a/include/asm-i386/page.h
> +++ b/include/asm-i386/page.h
> @@ -109,11 +109,23 @@ extern int page_is_ram(unsigned long pag
>  
>  #endif /* __ASSEMBLY__ */
>  
> +#if defined(CONFIG_DEFAULT_3G)
> +#define __PAGE_OFFSET_RAW	(0xC0000000)
> +#elif defined(CONFIG_DEFAULT_3G_OPT)
> +#define	__PAGE_OFFSET_RAW	(0xB0000000)
> +#elif defined(CONFIG_DEFAULT_2G)
> +#define __PAGE_OFFSET_RAW	(0x78000000)
> +#elif defined(CONFIG_DEFAULT_1G)
> +#define __PAGE_OFFSET_RAW	(0x40000000)
> +#else
> +#error "Bad user/kernel offset"
> +#endif
> +
>  #ifdef __ASSEMBLY__
> -#define __PAGE_OFFSET		(0xC0000000)
> +#define __PAGE_OFFSET		__PAGE_OFFSET_RAW
>  #define __PHYSICAL_START	CONFIG_PHYSICAL_START
>  #else
> -#define __PAGE_OFFSET		(0xC0000000UL)
> +#define __PAGE_OFFSET		((unsigned long)__PAGE_OFFSET_RAW)
>  #define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
>  #endif
>  #define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)

Changing PAGE_OFFSET this way would break at least Valgrind (the latest
release 3.1.0 by default is statically linked at address 0xb0000000, and
PIE support does not seem to be present in that release).  I remember
that similar changes were also breaking Lisp implementations (cmucl,
sbcl), however, I am not really sure about this.

--Signature=_Tue__10_Jan_2006_20_07_55_+0300_CoTgJf0JgqHuFgZs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDw+nvW82GfkQfsqIRAoz8AJ9ehVlr0D0Dt+bRSdytGNM3N2hnyACfVLQc
ssTtZYzjMGvIePnIyS0NHfY=
=U27k
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Jan_2006_20_07_55_+0300_CoTgJf0JgqHuFgZs--
