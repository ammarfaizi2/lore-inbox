Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268110AbTB1Tml>; Fri, 28 Feb 2003 14:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268111AbTB1Tmk>; Fri, 28 Feb 2003 14:42:40 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:27914 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S268110AbTB1Tmi>; Fri, 28 Feb 2003 14:42:38 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix scsi_probe_and_add_lun
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 28 Feb 2003 20:48:07 +0100
Message-ID: <wrp3cm8gpag.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Christoph,

The following patch fixes a bug introduced in the recent scsi_scan.c
reorganisation.

Without this patch, my Alpha Jensen was crashing just after detecting
its first SCSI disk. It is now working fine.

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=jensen.patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1092  -> 1.1093 
#	drivers/scsi/scsi_scan.c	1.62    -> 1.63   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/28	maz@hina.wild-wind.fr.eu.org	1.1093
# Fix scsi_probe_and_add_lun typo.
# The ol'Jensen wouldn't boot without it...
# --------------------------------------------
#
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Fri Feb 28 20:45:00 2003
+++ b/drivers/scsi/scsi_scan.c	Fri Feb 28 20:45:00 2003
@@ -1338,7 +1338,7 @@
 	scsi_release_request(sreq);
  out_free_sdev:
 	if (res == SCSI_SCAN_LUN_PRESENT) {
-		if (*sdevp)
+		if (sdevp)
 			*sdevp = sdev;
 	} else {
 		if (q) {

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
