Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbUKLXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUKLXor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUKLXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:44:06 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:6787 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262704AbUKLXWw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:52 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017192982@kroah.com>
Date: Fri, 12 Nov 2004 15:21:59 -0800
Message-Id: <11003017191521@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.10, 2004/11/12 14:07:13-08:00, hannal@us.ibm.com

[PATCH] cmipci.c: convert pci_find_device to pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 sound/pci/cmipci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/sound/pci/cmipci.c b/sound/pci/cmipci.c
--- a/sound/pci/cmipci.c	2004-11-12 15:10:49 -08:00
+++ b/sound/pci/cmipci.c	2004-11-12 15:10:49 -08:00
@@ -2572,6 +2572,10 @@
 	long iomidi = mpu_port[dev];
 	long iosynth = fm_port[dev];
 	int pcm_index, pcm_spdif_index;
+	static struct pci_device_id intel_82437vx[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437VX) },
+		{ },
+	};
 
 	*rcmipci = NULL;
 
@@ -2647,8 +2651,7 @@
 	switch (pci->device) {
 	case PCI_DEVICE_ID_CMEDIA_CM8738:
 	case PCI_DEVICE_ID_CMEDIA_CM8738B:
-		/* PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437VX */
-		if (! pci_find_device(0x8086, 0x7030, NULL))
+		if (!pci_dev_present(intel_82437vx)) 
 			snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_TXVX);
 		break;
 	default:

