Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTJMPwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbTJMPwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:52:14 -0400
Received: from imladris.surriel.com ([66.92.77.98]:50366 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261775AbTJMPwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:52:13 -0400
Date: Mon, 13 Oct 2003 11:52:02 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] advansys compile fixes
Message-ID: <Pine.LNX.4.55L.0310131151130.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- initialise req_cnt variable in advansys_detect()
- DvcAdvWritePCIConfigByte() is a void function

diff -urNp linux-5110/drivers/scsi/advansys.c linux-10010/drivers/scsi/advansys.c
--- linux-5110/drivers/scsi/advansys.c
+++ linux-10010/drivers/scsi/advansys.c
@@ -5551,7 +5551,7 @@ advansys_detect(Scsi_Host_Template *tpnt
                 }
             } else {
                 ADV_CARR_T      *carrp;
-                int             req_cnt;
+                int             req_cnt=0;
                 adv_req_t       *reqp = NULL;
                 int             sg_cnt = 0;

@@ -9258,7 +9258,6 @@ DvcAdvWritePCIConfigByte(
             ASC_PCI_ID2FUNC(asc_dvc->cfg->pci_slot_info)),
         offset, byte_data);
 #else /* CONFIG_PCI */
-    return 0;
 #endif /* CONFIG_PCI */
 }

