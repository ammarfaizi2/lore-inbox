Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTFGPSC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 11:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTFGPSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 11:18:02 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25553 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263201AbTFGPR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 11:17:59 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: [PATCH] Re: 2.5.70-mm5: sc1200.c compile error if !CONFIG_PROC_FS
Date: Sat, 7 Jun 2003 17:31:28 +0200
User-Agent: KMail/1.4.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306071731.28130.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixed now.
--
Bartlomiej

[ide] fix compilation of NS SC1x00 driver without procfs

 drivers/ide/pci/sc1200.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff -puN drivers/ide/pci/sc1200.c~ide-sc1200-noprocfs-fix drivers/ide/pci/sc1200.c
--- linux-2.5.70-bk11/drivers/ide/pci/sc1200.c~ide-sc1200-noprocfs-fix	Sat Jun  7 17:15:46 2003
+++ linux-2.5.70-bk11-root/drivers/ide/pci/sc1200.c	Sat Jun  7 17:22:15 2003
@@ -32,17 +32,6 @@
 #include "ide_modes.h"
 #include "sc1200.h"
 
-#define DISPLAY_SC1200_TIMINGS
-
-#if defined(DISPLAY_SC1200_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static int sc1200_get_info(char *, char **, off_t, int);
-extern int (*sc1200_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
-static u8 sc1200_proc = 0;
-
 #define SC1200_REV_A	0x00
 #define SC1200_REV_B1	0x01
 #define SC1200_REV_B3	0x02
@@ -81,6 +70,17 @@ static unsigned short sc1200_get_pci_clo
 	return pci_clock;
 }
 
+#define DISPLAY_SC1200_TIMINGS
+
+#if defined(DISPLAY_SC1200_TIMINGS) && defined(CONFIG_PROC_FS)
+#include <linux/stat.h>
+#include <linux/proc_fs.h>
+
+static int sc1200_get_info(char *, char **, off_t, int);
+extern int (*sc1200_display_info)(char *, char **, off_t, int); /* ide-proc.c */
+extern char *ide_media_verbose(ide_drive_t *);
+static u8 sc1200_proc = 0;
+
 static struct pci_dev *bmide_dev;
 
 static int sc1200_get_info (char *buffer, char **addr, off_t offset, int count)

_

