Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbVIINFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVIINFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 09:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVIINFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 09:05:07 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:34870 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751449AbVIINFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 09:05:05 -0400
To: Greg KH <greg@kroah.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, Brett Russ <russb@emc.com>
Subject: [PATCH 2.6.13] PCI/libata INTx bug fix
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com> <20050815192341.6600220FF7@lns1058.lss.emc.com> <1126218402469@kroah.com>
In-Reply-To: <20050815192341.6600220FF7@lns1058.lss.emc.com> <1126218402469@kroah.com>
Message-Id: <20050909130440.4E31E271E6@lns1058.lss.emc.com>
Date: Fri,  9 Sep 2005 09:04:40 -0400 (EDT)
From: russb@emc.com (Brett M Russ)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.9.10
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previous INTx cleanup patch had a bug that was not caught.  I found
this last night during testing and can confirm that it is now 100%
working.

Signed-off-by: Brett Russ <russb@emc.com>


Index: linux-2.6.13/drivers/pci/pci.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/pci.c
+++ linux-2.6.13/drivers/pci/pci.c
@@ -764,7 +764,7 @@ pci_intx(struct pci_dev *pdev, int enabl
 	}
 
 	if (new != pci_command) {
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+		pci_write_config_word(pdev, PCI_COMMAND, new);
 	}
 }
 
