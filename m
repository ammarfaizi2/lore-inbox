Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTFUXpc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTFUXpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:45:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37096 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264489AbTFUXp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:45:26 -0400
Date: Sun, 22 Jun 2003 01:59:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
       GOTO Masanori <gotom@debian.or.jp>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] remove an unused function from nsp32.c
Message-ID: <20030621235927.GJ23337@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes an unused function from nsp32.c .

I've tested the compilation with 2.5.72-mm2.

cu
Adrian

--- linux-2.5.72-mm2/drivers/scsi/nsp32.c.old	2003-06-22 01:13:40.000000000 +0200
+++ linux-2.5.72-mm2/drivers/scsi/nsp32.c	2003-06-22 01:14:00.000000000 +0200
@@ -283,7 +283,6 @@
 static int nsp32_eh_abort(Scsi_Cmnd *);
 static int nsp32_eh_bus_reset(Scsi_Cmnd *);
 static int nsp32_eh_host_reset(Scsi_Cmnd *);
-static int nsp32_reset(Scsi_Cmnd *, unsigned int);
 static int nsp32_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
 static int __devinit nsp32_probe(struct pci_dev *, const struct pci_device_id *);
 static void __devexit nsp32_remove(struct pci_dev *);
@@ -1854,18 +1853,6 @@
 }
 
 
-/*
- * error handler
- */
-static int nsp32_reset(Scsi_Cmnd *SCpnt, unsigned int reset_flags)
-{
-	nsp32_dbg(NSP32_DEBUG_BUSRESET, "SCpnt=0x%p why=%d\n", SCpnt, reset_flags);
-
-	nsp32_eh_bus_reset(SCpnt);
-
-	return SCSI_RESET_SUCCESS | SCSI_RESET_BUS_RESET;
-}
-
 static int nsp32_eh_abort(Scsi_Cmnd *SCpnt)
 {
 	nsp32_hw_data *data = (nsp32_hw_data *)SCpnt->device->host->hostdata;
