Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261932AbSIPL73>; Mon, 16 Sep 2002 07:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbSIPL73>; Mon, 16 Sep 2002 07:59:29 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:49597 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261932AbSIPL71>; Mon, 16 Sep 2002 07:59:27 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.35-vanilla compile error with NTFS - FIX
Date: Mon, 16 Sep 2002 14:04:00 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Message-Id: <200209161319.42557.m.c.p@gmx.net>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_OI5JJ8LGPSG9ERCDKYSZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_OI5JJ8LGPSG9ERCDKYSZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

root@codeman:[/usr/src/linux-2.5.35] # make modules_install
=2E..
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.35; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.35/kernel/fs/ntfs/ntfs=
=2Eo
depmod:         unmap_underlying_metadata
root@codeman:[/usr/src/linux-2.5.35] #

This also was true for 2.5.34.

=2E..
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy
=2E..

The attached patch fixes it. Please apply.


--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
--------------Boundary-00=_OI5JJ8LGPSG9ERCDKYSZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ntfs-module-build-unresolved-symbols-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ntfs-module-build-unresolved-symbols-fix.patch"

diff -ruN linux-2.5.35-vanilla/fs/buffer.c linux-2.5.35-mcp1-fullkernel/fs/buffer.c
--- linux-2.5.35-vanilla/fs/buffer.c		2002-09-16 10:47:01.000000000 +0200
+++ linux-2.5.35-mcp1-fullkernel/fs/buffer.c	2002-09-16 13:54:24.000000000 +0200
@@ -1628,6 +1628,7 @@
 		__brelse(old_bh);
 	}
 }
+EXPORT_SYMBOL(unmap_underlying_metadata);
 
 /*
  * NOTE! All mapped/uptodate combinations are valid:

--------------Boundary-00=_OI5JJ8LGPSG9ERCDKYSZ--

