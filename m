Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSJVGpb>; Tue, 22 Oct 2002 02:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJVGpb>; Tue, 22 Oct 2002 02:45:31 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:20999 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S262248AbSJVGpa>;
	Tue, 22 Oct 2002 02:45:30 -0400
Date: Tue, 22 Oct 2002 10:50:28 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCHSET] PC-9800 architecture (CORE only)
Message-ID: <20021022065028.GA304@pazke.ipt>
Mail-Followup-To: Osamu Tomita <tomita@cinet.co.jp>,
	linux-kernel@vger.kernel.org
References: <20021021224919.A1509@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20021021224919.A1509@precia.cinet.co.jp>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2002 at 10:49:19PM +0900, Osamu Tomita wrote:
> This is a part of big patchset for support PC-9800 architecture, one of i=
386
> sub architectures.
> Core part cleanup has done. (But device drivers are still working.)
> Many "#if" are killed by using "mach-xxx" framework.
> If someone pick up this, we are very happy.
> Comments are always welcome. Please tell me.

Ok, you asked for it :))=20

>  	if (boot_cpu_data.hard_math && !cpu_has_fpu)
> -		setup_irq(13, &irq13);
> +#ifndef CONFIG_PC9800
> +		setup_irq(13, &fpu_irq);
> +#else
> +		setup_irq(8, &fpu_irq);
> +#endif
>  }

May be this should be done this way (with FPU_IRQ_NUMBER hidden in the
arch specific header):

-		setup_irq(13, &irq13);
+		setup_irq(FPU_IRQ_NUMBER, &fpu_irq);


> diff -urN linux/arch/i386/kernel/pc9800_debug.c linux98/arch/i386/kernel/=
pc9800_debug.c

Why this file is not in mach-pc9800 directory ?

And what is IORESOURCE98_SPARSE flag in mach-pc9800/mach_resources.h file ?

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9tPU0Bm4rlNOo3YgRArQpAJ9gn70LIgNFIkm2WzUMgx9hjRhXdQCdGDz4
vSYfXyAHmAQ06KoWNsfv7ls=
=9IRA
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
