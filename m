Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269207AbUI3AHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbUI3AHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUI3AHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:07:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:29170 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269207AbUI3AHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:07:17 -0400
Date: Wed, 29 Sep 2004 17:08:17 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, sailer@ife.ee.ethz.ch,
       perex@suse.cz
Subject: [PATCH 2.6.9-rc2-mm4 cmipci.c] [8/8] Replace pci_find_device with pci_dev_present
Message-ID: <28440000.1096502897@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The pci_find_device function is going away so I have replace it with pci_dev_present.
I also just used the macros it should have been using in the first place. I have compile tested it.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc2-mm4cln/sound/pci/cmipci.c linux-2.6.9-rc2-mm4patch2/sound/pci/cmipci.c
--- linux-2.6.9-rc2-mm4cln/sound/pci/cmipci.c	2004-09-12 22:32:55.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch2/sound/pci/cmipci.c	2004-09-29 16:32:30.000000000 -0700
@@ -2573,6 +2573,10 @@ static int __devinit snd_cmipci_create(s
 	long iomidi = mpu_port[dev];
 	long iosynth = fm_port[dev];
 	int pcm_index, pcm_spdif_index;
+	static struct pci_device_id intel_82437vx[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437VX) },
+		{ },
+	};
 
 	*rcmipci = NULL;
 
@@ -2648,8 +2652,7 @@ static int __devinit snd_cmipci_create(s
 	switch (pci->device) {
 	case PCI_DEVICE_ID_CMEDIA_CM8738:
 	case PCI_DEVICE_ID_CMEDIA_CM8738B:
-		/* PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437VX */
-		if (! pci_find_device(0x8086, 0x7030, NULL))
+		if (!pci_dev_present(intel_82437vx)) 
 			snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_TXVX);
 		break;
 	default:


