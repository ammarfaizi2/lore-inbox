Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163638AbWLGW6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163638AbWLGW6V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163642AbWLGW6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:58:21 -0500
Received: from havoc.gtf.org ([69.61.125.42]:39767 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163634AbWLGW6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:58:17 -0500
Date: Thu, 7 Dec 2006 17:58:12 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de, barkalow@iabervon.org
Subject: [git patch] improve INTx toggle for PCI MSI
Message-ID: <20061207225812.GA13917@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"it boots" on ICH7 at least.

Please pull from 'intx' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git intx

to receive the following updates:

 drivers/pci/msi.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

Jeff Garzik:
      PCI MSI: always toggle legacy-INTx-enable bit upon MSI entry/exit

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9fc9a34..c2828a3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -255,10 +255,8 @@ static void enable_msi_mode(struct pci_d
 		pci_write_config_word(dev, msi_control_reg(pos), control);
 		dev->msix_enabled = 1;
 	}
-    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
-		/* PCI Express Endpoint device detected */
-		pci_intx(dev, 0);  /* disable intx */
-	}
+
+	pci_intx(dev, 0);  /* disable intx */
 }
 
 void disable_msi_mode(struct pci_dev *dev, int pos, int type)
@@ -276,10 +274,8 @@ void disable_msi_mode(struct pci_dev *de
 		pci_write_config_word(dev, msi_control_reg(pos), control);
 		dev->msix_enabled = 0;
 	}
-    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
-		/* PCI Express Endpoint device detected */
-		pci_intx(dev, 1);  /* enable intx */
-	}
+
+	pci_intx(dev, 1);  /* enable intx */
 }
 
 static int msi_lookup_irq(struct pci_dev *dev, int type)
