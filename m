Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSK1KIJ>; Thu, 28 Nov 2002 05:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSK1KIJ>; Thu, 28 Nov 2002 05:08:09 -0500
Received: from turing.fb12.de ([80.76.224.45]:29869 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S265373AbSK1KII>;
	Thu, 28 Nov 2002 05:08:08 -0500
Date: Thu, 28 Nov 2002 11:15:28 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, alan@lxorguk.ukuu.org.uk
Subject: drivers/pci/quirks.c / Re: Linux v2.5.50
Message-ID: <20021128111528.A28437@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>, alan@lxorguk.ukuu.org.uk
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Nov 27, 2002 at 03:07:38PM -0800
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
x-gpg-key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x82AE75E4
x-gpg-keyid: 0x82AE75E4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


with CONFIG_X86_IO_APIC=3Dy I get

  gcc -Wp,-MD,drivers/pci/.quirks.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict=
-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-fram=
e-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 -Iarch/i386/ma=
ch-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3Dquirks -DK=
BUILD_MODNAME=3Dquirks   -c -o drivers/pci/quirks.o drivers/pci/quirks.c
drivers/pci/quirks.c: In function `quirk_ioapic_rmw':
drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this func=
tion)
drivers/pci/quirks.c:354: (Each undeclared identifier is reported only once
drivers/pci/quirks.c:354: for each function it appears in.)
make[2]: *** [drivers/pci/quirks.o] Error 1
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2


fixed by

--- drivers/pci/quirks.c.old	Tue Nov 26 20:40:02 2002
+++ drivers/pci/quirks.c	Tue Nov 26 20:39:54 2002
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <asm/io_apic.h>
=20
 #undef DEBUG
=20

/B.
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj3l7MAACgkQTsThvluiLwBCogCgs6t5kDXp12m7j8PWl6QLEXdR
hqMAn0IilRTWGQ3QMABVcENDKPRzjmZy
=XeHy
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
