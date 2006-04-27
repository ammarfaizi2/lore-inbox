Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWD0R50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWD0R50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWD0R50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:57:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64261 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965014AbWD0R5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:57:25 -0400
Date: Thu, 27 Apr 2006 19:57:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/advansys.c: cleanups
Message-ID: <20060427175723.GG3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- remove the unneeded advansys.h
- make needlessly global functions static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/advansys.c |   19 +++++++++----------
 drivers/scsi/advansys.h |   36 ------------------------------------
 2 files changed, 9 insertions(+), 46 deletions(-)

--- linux-2.6.17-rc2-mm1-full/drivers/scsi/advansys.h	2006-04-27 17:41:44.000000000 +0200
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,36 +0,0 @@
-/*
- * advansys.h - Linux Host Driver for AdvanSys SCSI Adapters
- * 
- * Copyright (c) 1995-2000 Advanced System Products, Inc.
- * Copyright (c) 2000-2001 ConnectCom Solutions, Inc.
- * All Rights Reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that redistributions of source
- * code retain the above copyright notice and this comment without
- * modification.
- *
- * As of March 8, 2000 Advanced System Products, Inc. (AdvanSys)
- * changed its name to ConnectCom Solutions, Inc.
- *
- */
-
-#ifndef _ADVANSYS_H
-#define _ADVANSYS_H
-
-/*
- * struct scsi_host_template function prototypes.
- */
-int advansys_detect(struct scsi_host_template *);
-int advansys_release(struct Scsi_Host *);
-const char *advansys_info(struct Scsi_Host *);
-int advansys_queuecommand(struct scsi_cmnd *, void (* done)(struct scsi_cmnd *));
-int advansys_reset(struct scsi_cmnd *);
-int advansys_biosparam(struct scsi_device *, struct block_device *,
-		sector_t, int[]);
-static int advansys_slave_configure(struct scsi_device *);
-
-/* init/main.c setup function */
-void advansys_setup(char *, int *);
-
-#endif /* _ADVANSYS_H */
--- linux-2.6.17-rc2-mm1-full/drivers/scsi/advansys.c.old	2006-04-27 17:42:00.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/drivers/scsi/advansys.c	2006-04-27 17:44:49.000000000 +0200
@@ -799,7 +799,6 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
-#include "advansys.h"
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
 #endif /* CONFIG_PCI */
@@ -2013,7 +2012,7 @@
 STATIC void      AscEnableIsaDma(uchar);
 #endif /* CONFIG_ISA */
 STATIC ASC_DCNT  AscGetMaxDmaCount(ushort);
-
+static const char *advansys_info(struct Scsi_Host *shp);
 
 /*
  * --- Adv Library Constants and Macros
@@ -4093,7 +4092,7 @@
  * if 'prtbuf' is too small it will not be overwritten. Instead the
  * user just won't get all the available statistics.
  */
-int
+static int
 advansys_proc_info(struct Scsi_Host *shost, char *buffer, char **start,
 		off_t offset, int length, int inout)
 {
@@ -4309,7 +4308,7 @@
  * it must not call SCSI mid-level functions including scsi_malloc()
  * and scsi_free().
  */
-int __init
+static int __init
 advansys_detect(struct scsi_host_template *tpnt)
 {
     static int          detect_called = ASC_FALSE;
@@ -5441,7 +5440,7 @@
  *
  * Release resources allocated for a single AdvanSys adapter.
  */
-int
+static int
 advansys_release(struct Scsi_Host *shp)
 {
     asc_board_t    *boardp;
@@ -5488,7 +5487,7 @@
  * Note: The information line should not exceed ASC_INFO_SIZE bytes,
  * otherwise the static 'info' array will be overrun.
  */
-const char *
+static const char *
 advansys_info(struct Scsi_Host *shp)
 {
     static char     info[ASC_INFO_SIZE];
@@ -5581,7 +5580,7 @@
  * This function always returns 0. Command return status is saved
  * in the 'scp' result field.
  */
-int
+static int
 advansys_queuecommand(struct scsi_cmnd *scp, void (*done)(struct scsi_cmnd *))
 {
     struct Scsi_Host    *shp;
@@ -5669,7 +5668,7 @@
  * sleeping is allowed and no locking other than for host structures is
  * required. Returns SUCCESS or FAILED.
  */
-int
+static int
 advansys_reset(struct scsi_cmnd *scp)
 {
     struct Scsi_Host     *shp;
@@ -5854,7 +5853,7 @@
  * ip[1]: sectors
  * ip[2]: cylinders
  */
-int
+static int
 advansys_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 		sector_t capacity, int ip[])
 {
@@ -5921,7 +5920,7 @@
  * ints[2] - second argument
  * ...
  */
-void __init
+static void __init
 advansys_setup(char *str, int *ints)
 {
     int    i;

