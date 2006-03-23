Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWCWVP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWCWVP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWCWVP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:15:28 -0500
Received: from smtp04.auna.com ([62.81.186.14]:23996 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S964947AbWCWVP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:15:27 -0500
Date: Thu, 23 Mar 2006 22:15:25 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: [PATCH] Dont build altivec raid on x86
Message-ID: <20060323221525.52346ef7@werewolf.auna.net>
In-Reply-To: <20060323220711.28fcb82f@werewolf.auna.net>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323220711.28fcb82f@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.0.0cvs160 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_G+9xJX5Ye6mr3Q95sxgh5vj;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Thu, 23 Mar 2006 22:15:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_G+9xJX5Ye6mr3Q95sxgh5vj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2006 22:07:11 +0100, "J.A. Magallon" <jamagallon@able.es> wr=
ote:

> On Thu, 23 Mar 2006 01:40:46 -0800, Andrew Morton <akpm@osdl.org> wrote:
>=20
> >=20
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.=
6.16-mm1/
> >=20
>=20

gcc just compiles files emptied with #ifdefs, but it looks incorrect
anyways

--- linux/drivers/md/Makefile.orig	2005-11-13 23:14:48.000000000 +0100
+++ linux/drivers/md/Makefile	2005-11-13 23:28:05.000000000 +0100
@@ -8,12 +8,21 @@
 dm-snapshot-objs :=3D dm-snap.o dm-exception-store.o
 dm-mirror-objs	:=3D dm-log.o dm-raid1.o
 md-mod-objs     :=3D md.o bitmap.o
+
+
+ifeq ($(CONFIG_ALTIVEC),y)
+raid6-vec-objs :=3D \
+		   raid6altivec1.o raid6altivec2.o \
+		   raid6altivec4.o raid6altivec8.o
+endif
+ifeq ($(CONFIG_X86),y)
+raid6-vec-objs :=3D \
+		   raid6mmx.o raid6sse1.o raid6sse2.o
+endif
 raid6-objs	:=3D raid6main.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
-		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
-		   raid6altivec8.o \
-		   raid6mmx.o raid6sse1.o raid6sse2.o
+		   $(raid6-vec-objs)
 hostprogs-y	:=3D mktables
=20
 # Note: link order is important.  All raid personalities


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam20 (gcc 4.0.3 (4.0.3-1mdk for Mandriva Linux release 2006.1=
))

--Sig_G+9xJX5Ye6mr3Q95sxgh5vj
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIw/tRlIHNEGnKMMRAiY4AJ4xmJlrQybexrAY5dxh2gPXTAsrOACcDzHy
SgX1Oy9Y4ltV7QihOBTbwk8=
=laSo
-----END PGP SIGNATURE-----

--Sig_G+9xJX5Ye6mr3Q95sxgh5vj--
