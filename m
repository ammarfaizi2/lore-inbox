Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSHXGHh>; Sat, 24 Aug 2002 02:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSHXGHh>; Sat, 24 Aug 2002 02:07:37 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:59876 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S315337AbSHXGHg>; Sat, 24 Aug 2002 02:07:36 -0400
Date: Sat, 24 Aug 2002 09:07:07 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Martin K?bele <martin@mkoebele.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG, trident.c doesn't compile in 2.5.31
Message-ID: <20020824060707.GS7661@alhambra.actcom.co.il>
References: <200208232106.05729.martin@mkoebele.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Er1qpsOqk0l6oMce"
Content-Disposition: inline
In-Reply-To: <200208232106.05729.martin@mkoebele.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Er1qpsOqk0l6oMce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2002 at 09:06:05PM -0400, Martin K?bele wrote:
> hi, couldn't find a bug report in the archive.
> I tried to compile the kernel with the trident-support in OSS.
>=20
> I got this message:
>=20
>=20
> make[2]: Wechsel in das Verzeichnis Verzeichnis=20
> ?/usr/src/linux-2.5.31/sound/oss?
>   gcc -Wp,-MD,./.trident.o.d -D__KERNEL__ -I/usr/src/linux-2.5.31/include=
=20
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer=20
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2=20
> -march=3Di686 -malign-functions=3D4  -nostdinc -iwithprefix include -DMOD=
ULE=20
> -include /usr/src/linux-2.5.31/include/linux/modversions.h  =20
> -DKBUILD_BASENAME=3Dtrident   -c -o trident.o trident.c
> trident.c:2153: macro `synchronize_irq' used without args
> trident.c:2160: macro `synchronize_irq' used without args
> make[2]: *** [trident.o] Fehler 1
> make[2]: Verlassen des Verzeichnisses Verzeichnis=20
> ?/usr/src/linux-2.5.31/sound/oss?
> make[1]: *** [oss] Fehler 2
> make[1]: Verlassen des Verzeichnisses Verzeichnis=20
> ?/usr/src/linux-2.5.31/sound?
> make: *** [sound] Fehler 2

here's a patch to fix it, which I've sent to rusty's trivial patch
monkey and should make it to a kernel near you.=20

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.488   -> 1.489 =20
#	 sound/oss/trident.c	1.25    -> 1.26  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/17	mulix@alhambra.merseine.nu	1.489
# fix synchronize_irq which now takes an 'irq' argument.=20
# --------------------------------------------
#
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Sat Aug 17 11:13:34 2002
+++ b/sound/oss/trident.c	Sat Aug 17 11:13:34 2002
@@ -2150,14 +2150,14 @@
 		/* FIXME: spin_lock ? */
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(state);
-			synchronize_irq();
+			synchronize_irq(card->irq);
 			dmabuf->ready =3D 0;
 			dmabuf->swptr =3D dmabuf->hwptr =3D 0;
 			dmabuf->count =3D dmabuf->total_bytes =3D 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(state);
-			synchronize_irq();
+			synchronize_irq(card->irq);
 			dmabuf->ready =3D 0;
 			dmabuf->swptr =3D dmabuf->hwptr =3D 0;
 			dmabuf->count =3D dmabuf->total_bytes =3D 0;
--=20
calm down, it's *only* ones and zeros.=20

http://syscalltrack.sf.net/
http://vipe.technion.ac.il/~mulix/

--Er1qpsOqk0l6oMce
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9ZyKLKRs727/VN8sRAnVwAJ9GRHwCoA14RmYz7rGiJLxIMl71+gCgl7mR
fikJUX7LMoyNqlgiqrAeAWE=
=xyg5
-----END PGP SIGNATURE-----

--Er1qpsOqk0l6oMce--
