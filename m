Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWJHXQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWJHXQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWJHXQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:16:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54033 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932103AbWJHXQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:16:32 -0400
Date: Mon, 9 Oct 2006 01:16:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/dpt_i2o.c: remove dead code
Message-ID: <20061008231627.GO6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this dead code introduced by
commit a07f353701acae77e023f6270e8af353b37af7c4.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/scsi/dpt_i2o.c.old	2006-10-09 00:28:41.000000000 +0200
+++ linux-2.6/drivers/scsi/dpt_i2o.c	2006-10-09 00:29:10.000000000 +0200
@@ -185,28 +185,26 @@
 
         /* search for all Adatpec I2O RAID cards */
 	while ((pDev = pci_get_device( PCI_DPT_VENDOR_ID, PCI_ANY_ID, pDev))) {
 		if(pDev->device == PCI_DPT_DEVICE_ID ||
 		   pDev->device == PCI_DPT_RAPTOR_DEVICE_ID){
 			if(adpt_install_hba(sht, pDev) ){
 				PERROR("Could not Init an I2O RAID device\n");
 				PERROR("Will not try to detect others.\n");
 				return hba_count-1;
 			}
 			pci_dev_get(pDev);
 		}
 	}
-	if (pDev)
-		pci_dev_put(pDev);
 
 	/* In INIT state, Activate IOPs */
 	for (pHba = hba_chain; pHba; pHba = pHba->next) {
 		// Activate does get status , init outbound, and get hrt
 		if (adpt_i2o_activate_hba(pHba) < 0) {
 			adpt_i2o_delete_hba(pHba);
 		}
 	}
 
 
 	/* Active IOPs in HOLD state */
 
 rebuild_sys_tab:

