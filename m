Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUHDKWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUHDKWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUHDKWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:22:25 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:18915 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S263770AbUHDKWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:22:21 -0400
Date: Wed, 4 Aug 2004 12:22:13 +0200
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
       tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, olh@suse.de, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040804102213.GA2799@halley.zuhause>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
	tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org, olh@suse.de, akpm@osdl.org
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20040730210318.GS16468@smtp.west.cox.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi alltogether!

On Fri, Jul 30, 2004 at 02:03:18PM -0700, Tom Rini wrote:
>=20
> On Fri, Jul 30, 2004 at 10:48:28PM +0200, Giuliano Pochini wrote:
>=20
> [snip]
> > gcc 3.3.3 + binutils 2.15 fails quite soon here:
> >
> >   AS      arch/ppc/kernel/l2cr.o
> > arch/ppc/kernel/l2cr.S: Assembler messages:
> > arch/ppc/kernel/l2cr.S:110: Error: Unrecognized opcode: `dssall'
> > arch/ppc/kernel/l2cr.S:278: Error: Unrecognized opcode: `dssall'
> > arch/ppc/kernel/l2cr.S:387: Error: Unrecognized opcode: `dssall'
> > make[1]: *** [arch/ppc/kernel/l2cr.o] Error 1
>=20
> Can you try with the following?

I had to apply this patch to get 2.6.8-rc2 compiled on debian unstable
(3.3.4-2 and binutils 2.15-1). I think ths patch should make it into
2.6.8.

With best regards,

Wolfi
>=20
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
>=20
> =3D=3D=3D=3D=3D arch/ppc/Makefile 1.57 vs edited =3D=3D=3D=3D=3D
> --- 1.57/arch/ppc/Makefile	2004-07-28 21:58:36 -07:00
> +++ edited/arch/ppc/Makefile	2004-07-29 12:21:33 -07:00
> @@ -22,7 +22,7 @@
>=20
>  LDFLAGS_vmlinux	:=3D -Ttext $(KERNELLOAD) -Bstatic
>  CPPFLAGS	+=3D -Iarch/$(ARCH)
> -AFLAGS		+=3D -Iarch/$(ARCH)
> +aflags-y	+=3D -Iarch/$(ARCH)
>  cflags-y	+=3D -Iarch/$(ARCH) -msoft-float -pipe \
>  		-ffixed-r2 -Wno-uninitialized -mmultiple
>  CPP		=3D $(CC) -E $(CFLAGS)
> @@ -33,10 +33,16 @@
>  cflags-y	+=3D -mstring
>  endif
>=20
> +aflags-$(CONFIG_4xx)		+=3D -m405
>  cflags-$(CONFIG_4xx)		+=3D -Wa,-m405
> +aflags-$(CONFIG_6xx)		+=3D -maltivec
> +cflags-$(CONFIG_6xx)		+=3D -Wa,-maltivec
> +aflags-$(CONFIG_E500)		+=3D -me500
>  cflags-$(CONFIG_E500)		+=3D -Wa,-me500
> +aflags-$(CONFIG_PPC64BRIDGE)	+=3D -mppc64bridge
>  cflags-$(CONFIG_PPC64BRIDGE)	+=3D -Wa,-mppc64bridge
>=20
> +AFLAGS +=3D $(aflags-y)
>  CFLAGS +=3D $(cflags-y)
>=20
>  head-y				:=3D arch/ppc/kernel/head.o
>=20
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>=20
> ** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBELjVH0o2mefAfsQRAomrAJ46oInQbfdvGgxHF7xqih0LSa0eAQCeKWdo
Nc5+Wm1J/spmcCqUljC6Hmc=
=/J+4
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
