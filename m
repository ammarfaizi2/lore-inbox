Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUHDKnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUHDKnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUHDKnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:43:14 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:39651 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S264113AbUHDKnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:43:09 -0400
Date: Wed, 4 Aug 2004 12:41:57 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
       tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, olh@suse.de, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040804104157.GB3554@bogon.ms20.nix>
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20040730210318.GS16468@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: multipart/mixed; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
Doesn't apply against 2.6.8-rc3. For what it's worth, I've attached a versi=
on that does.
Cheers,
 -- Guido

--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="introduce-aflags.diff"
Content-Transfer-Encoding: quoted-printable

--- ../linux-2.6.8-rc3.orig/arch/ppc/Makefile	2004-06-16 07:18:57.000000000=
 +0200
+++ arch/ppc/Makefile	2004-08-04 11:39:26.518867808 +0200
@@ -15,14 +15,20 @@
=20
 LDFLAGS_vmlinux	:=3D -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+=3D -Iarch/$(ARCH)
-AFLAGS		+=3D -Iarch/$(ARCH)
+aflags-y	+=3D -Iarch/$(ARCH)
 cflags-y	+=3D -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -Wno-uninitialized -mmultiple -mstring
 CPP		=3D $(CC) -E $(CFLAGS)
=20
+aflags-$(CONFIG_4xx)		+=3D -m405
 cflags-$(CONFIG_4xx)		+=3D -Wa,-m405
+aflags-$(CONFIG_6xx)		+=3D -maltivec
+cflags-$(CONFIG_6xx)		+=3D -Wa,-maltivec
+aflags-$(CONFIG_E500)		+=3D -me500
+aflags-$(CONFIG_PPC64BRIDGE)	+=3D -mppc64bridge
 cflags-$(CONFIG_PPC64BRIDGE)	+=3D -Wa,-mppc64bridge
=20
+AFLAGS +=3D $(aflags-y)
 CFLAGS +=3D $(cflags-y)
=20
=20

--Sr1nOIr3CvdE5hEN--

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBEL11n88szT8+ZCYRApKzAJ4irNRMQSVg9O9SyFa4VAgPmP5JiQCbB6ct
86GhkNT7PzQrgQMNrJ/5RIc=
=xoAq
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
