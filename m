Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbTAOImk>; Wed, 15 Jan 2003 03:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbTAOImk>; Wed, 15 Jan 2003 03:42:40 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:5088
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S265987AbTAOIlf>; Wed, 15 Jan 2003 03:41:35 -0500
Date: Wed, 15 Jan 2003 00:50:28 -0800
To: linux-kernel@vger.kernel.org
Subject: [2.5.58-bk] link failure in intel.c
Message-ID: <20030115085028.GA27568@ludicrus.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bad things during the final link process:

arch/i386/kernel/built-in.o(.init.text+0x34e4): In function `P2_enable_L2':
: undefined reference to `read_cr0'
arch/i386/kernel/built-in.o(.init.text+0x34f4): In function `P2_enable_L2':
: undefined reference to `write_cr0'
arch/i386/kernel/built-in.o(.init.text+0x3510): In function `P2_enable_L2':
: undefined reference to `write_cr0'
arch/i386/kernel/built-in.o(.init.text+0x3515): In function `P2_enable_L2':
: undefined reference to `wbinvd'
make[1]: *** [vmlinux] Error 1
make: *** [vmlinux] Error 2

I'm quite sure it is because of this changeset:

davej@codemonkey.org.uk|arch/i386/kernel/cpu/intel.c|20030115022821|46315

=3D=3D=3D=3D=3D=3D=3D=3D intel.c 1.1..1.18 =3D=3D=3D=3D=3D=3D=3D=3D
D 1.18 03/01/15 01:28:21-01:00 davej@codemonkey.org.uk 38 37 29/0/430
P arch/i386/kernel/cpu/intel.c
C Some 'overdrive' boards, such as those from Powerleap don't have
C the L2 cache enabled, and the BIOS doesn't know about it, so we
C introduce a boot option to 'force' it on.

Dave forgot to include system.h in his revised intel.c, so here is a=20
quick patch for it.

--- arch/i386/kernel/cpu/intel.c        2003-01-15 00:48:43.000000000 -0800
+++ arch/i386/kernel/cpu/intel.new.c    2003-01-15 00:41:53.000000000 -0800
@@ -8,6 +8,7 @@
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
+#include <asm/system.h>
=20
 #include "cpu.h"

With this patch the kernel compiles cleanly.

Regards
Josh

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JSDU6TRUxq22Mx4RAmaTAJwNnDlVaBYc7i0qTqo6rAwJZ/5QhACgk+M+
tph1MFeiNUSLGGaKmbF1+Zo=
=NY/W
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
