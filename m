Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261497AbSJHTkz>; Tue, 8 Oct 2002 15:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbSJHTMe>; Tue, 8 Oct 2002 15:12:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263246AbSJHTGE>; Tue, 8 Oct 2002 15:06:04 -0400
Subject: PATCH: fix imm compile
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:03:07 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzdM-0004u9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/imm.c linux.2.5.41-ac1/drivers/scsi/imm.c
--- linux.2.5.41/drivers/scsi/imm.c	2002-10-07 22:12:25.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/imm.c	2002-10-08 00:53:06.000000000 +0100
@@ -27,8 +27,10 @@
 #include <linux/blk.h>
 #include <asm/io.h>
 #include <linux/parport.h>
+#include <linux/workqueue.h>
 #include "sd.h"
 #include "hosts.h"
+
 typedef struct {
     struct pardevice *dev;	/* Parport device entry         */
     int base;			/* Actual port address          */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/imm.h linux.2.5.41-ac1/drivers/scsi/imm.h
--- linux.2.5.41/drivers/scsi/imm.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/imm.h	2002-10-08 00:53:12.000000000 +0100
@@ -71,7 +71,6 @@
 #include  <linux/stddef.h>
 #include  <linux/module.h>
 #include  <linux/kernel.h>
-#include  <linux/tqueue.h>
 #include  <linux/ioport.h>
 #include  <linux/delay.h>
 #include  <linux/proc_fs.h>
