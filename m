Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261343AbULZX57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbULZX57 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 26 Dec 2004 18:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbULZX57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 18:57:59 -0500
Received: from smtp.gentoo.org ([156.56.111.197]:41374 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261343AbULZX5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 18:57:54 -0500
From: Stefan Knoblich <stkn@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make libata for 2.4 compile on alpha
Date: Mon, 27 Dec 2004 00:43:48 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2752758.iaLzmWStS9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412270043.52692.stkn@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2752758.iaLzmWStS9
Content-Type: multipart/mixed;
  boundary="Boundary-01=_0y0zBmmvnMfVEsb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_0y0zBmmvnMfVEsb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

linux-2.4.28 + 2.4.28-rc3-libata1 patch won't compile on alpha, attached pa=
tch=20
fixes that.


Error messages:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.28/include -Wall -Wstrict-prototypes=
=20
=2DWno-trigraphs -O2
 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mno-fp-regs=20
=2Dffixed-8 -mcpu=3Dev5 -Wa,-mev6
 -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dlibata_core  -DEXPORT_S=
YMTAB=20
=2Dc libata-core.c
In file included from /usr/src/linux-2.4.28/include/linux/highmem.h:5,
                 from libata-core.c:31:
/usr/src/linux-2.4.28/include/asm/pgalloc.h: In function `flush_tlb_other':
/usr/src/linux-2.4.28/include/asm/pgalloc.h:63: error: dereferencing pointe=
r=20
to incomplete type
/usr/src/linux-2.4.28/include/asm/pgalloc.h:63: warning: implicit declarati=
on=20
of function `smp_processor_id'
/usr/src/linux-2.4.28/include/asm/pgalloc.h: In function=20
`flush_icache_user_range':
/usr/src/linux-2.4.28/include/asm/pgalloc.h:84: error: dereferencing pointe=
r=20
to incomplete type
/usr/src/linux-2.4.28/include/asm/pgalloc.h:84: error: `VM_EXEC' undeclared=
=20
(first use in this function)
/usr/src/linux-2.4.28/include/asm/pgalloc.h:84: error: (Each undeclared=20
identifier is reported only once
/usr/src/linux-2.4.28/include/asm/pgalloc.h:84: error: for each function it=
=20
appears in.)
/usr/src/linux-2.4.28/include/asm/pgalloc.h:85: error: dereferencing pointe=
r=20
to incomplete type
/usr/src/linux-2.4.28/include/asm/pgalloc.h:86: error: `current' undeclared=
=20
(first use in this function)
/usr/src/linux-2.4.28/include/asm/pgalloc.h:89: error: dereferencing pointe=
r=20
to incomplete type
/usr/src/linux-2.4.28/include/asm/pgalloc.h: In function=20
`ev4_flush_tlb_current_page':
<SNIP>

--Boundary-01=_0y0zBmmvnMfVEsb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="libata-2.4.28-rc3-alpha.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="libata-2.4.28-rc3-alpha.patch"

--- linux-2.4.28/drivers/scsi/libata-core.c.orig	2004-12-26 22:19:31.389841557 +0100
+++ linux-2.4.28/drivers/scsi/libata-core.c	2004-12-26 22:19:48.910349155 +0100
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>

--Boundary-01=_0y0zBmmvnMfVEsb--

--nextPart2752758.iaLzmWStS9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBz0y4jiIIAK4rYUoRAowbAJ9ZZPbz3S5pMNUId4hxHIOwpNX3TQCfSllw
AhrDkKS5Cjh/oMgJyC9+0Xg=
=KnHd
-----END PGP SIGNATURE-----

--nextPart2752758.iaLzmWStS9--
