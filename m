Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130828AbRBIMzA>; Fri, 9 Feb 2001 07:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130858AbRBIMyt>; Fri, 9 Feb 2001 07:54:49 -0500
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:44018 "EHLO
	csl3.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S130828AbRBIMyi>; Fri, 9 Feb 2001 07:54:38 -0500
Date: Fri, 9 Feb 2001 07:54:36 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac8 build glitch
Message-ID: <20010209075436.A883@athame.dynamicro.on.ca>
Reply-To: glouis@dynamicro.on.ca
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To get 2.4.1-ac8 to build with newly-installed binutils-2.10.1.0.7, I=20
had to do this to the Makefile in arch/i386/boot:

--- Makefile~	Mon Dec 20 17:43:39 1999
+++ Makefile	Fri Feb  9 07:21:42 2001
@@ -43,7 +43,7 @@
 	$(HOSTCC) $(HOSTCFLAGS) -o $@ $< -I$(TOPDIR)/include
=20
 bootsect: bootsect.o
-	$(LD) -Ttext 0x0 -s -oformat binary -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -o $@ $<
=20
 bootsect.o: bootsect.s
 	$(AS) -o $@ $<
@@ -52,7 +52,7 @@
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
=20
 bbootsect: bbootsect.o
-	$(LD) -Ttext 0x0 -s -oformat binary $< -o $@
+	$(LD) -Ttext 0x0 -s --oformat binary $< -o $@
=20
 bbootsect.o: bbootsect.s
 	$(AS) -o $@ $<
@@ -61,7 +61,7 @@
 	$(CPP) $(CPPFLAGS) -D__BIG_KERNEL__ -traditional $(SVGA_MODE) $(RAMDISK) =
$< -o $@
=20
 setup: setup.o
-	$(LD) -Ttext 0x0 -s -oformat binary -e begtext -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
=20
 setup.o: setup.s
 	$(AS) -o $@ $<
@@ -70,7 +70,7 @@
 	$(CPP) $(CPPFLAGS) -traditional $(SVGA_MODE) $(RAMDISK) $< -o $@
=20
 bsetup: bsetup.o
-	$(LD) -Ttext 0x0 -s -oformat binary -e begtext -o $@ $<
+	$(LD) -Ttext 0x0 -s --oformat binary -e begtext -o $@ $<
=20
 bsetup.o: bsetup.s
 	$(AS) -o $@ $<

--=20
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Comment: finger greg@bgl.nu for public key

iEYEARECAAYFAjqD6IwACgkQDlwut6d6Rj1NVACcDYpSSFAGmUxdpLWocT0rQk2f
xM4An3Mb4jOt6PqDwfnQG9OKsA1F1XJx
=oOZK
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
