Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266331AbTGEK54 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 06:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266315AbTGEK5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 06:57:55 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:30215 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266331AbTGEK50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 06:57:26 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 2.5.74, 2.5.74-mjb1] i2o compile fix
Date: Sat, 5 Jul 2003 13:11:08 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307051311.19491.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Martin, Alan,
lk-list.

I need this patch to compile i2o support. Otherwise I get this error:

mb@lfs:~/linux-2.5/linux-2.5.74-mjb1> make bzImage
make[1]: »arch/i386/kernel/asm-offsets.s« ist bereits aktualisiert.
  CHK     include/linux/compile.h
  CC      drivers/message/i2o/i2o_scsi.o
i2o_scsi.c: In function `i2o_scsi_reply':
i2o_scsi.c:328: Warnung: implicit declaration of function `pci_unmap_sg'
i2o_scsi.c:330: Warnung: implicit declaration of function `pci_unmap_single'
i2o_scsi.c: In function `i2o_scsi_queuecommand':
i2o_scsi.c:764: Warnung: implicit declaration of function `pci_map_sg'
i2o_scsi.c:834: Warnung: implicit declaration of function `pci_map_single'
  LD      drivers/message/i2o/built-in.o
  LD      drivers/message/built-in.o
  LD      drivers/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xcb8a8): In function `i2o_scsi_reply':
: undefined reference to `pci_unmap_single'
drivers/built-in.o(.text+0xcb8d5): In function `i2o_scsi_reply':
: undefined reference to `pci_unmap_sg'
drivers/built-in.o(.text+0xcc1b3): In function `i2o_scsi_queuecommand':
: undefined reference to `pci_map_single'
drivers/built-in.o(.text+0xcc212): In function `i2o_scsi_queuecommand':
: undefined reference to `pci_map_sg'
make: *** [.tmp_vmlinux1] Fehler 1


This patch is tested to apply to 2.5.74 and 2.5.74-mjb1

- --- drivers/message/i2o/i2o_scsi.c.orig	2003-07-05 13:00:07.000000000 +0200
+++ drivers/message/i2o/i2o_scsi.c	2003-07-05 13:02:59.000000000 +0200
@@ -53,6 +53,7 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/atomic.h>
+#include <linux/pci.h>
 #include <linux/blk.h>
 #include <linux/i2o.h>
 #include "../../scsi/scsi.h"

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 13:03:37 up  1:43,  3 users,  load average: 1.84, 2.19, 1.85

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BrJXoxoigfggmSgRAingAJ9x0WNlzzi70kclnbMr15DxuaIqvwCfaGeK
7ONfRL6a9w0FTJeJmtu4Btg=
=bj3c
-----END PGP SIGNATURE-----

