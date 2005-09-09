Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVIIRDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVIIRDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVIIRDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:03:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:6276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030254AbVIIRDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:03:20 -0400
Date: Fri, 9 Sep 2005 10:02:22 -0700
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org
Cc: Brett M Russ <russb@emc.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] PCI: PCI/libata INTx bug fix
Message-ID: <20050909170222.GA24894@kroah.com>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com> <20050815192341.6600220FF7@lns1058.lss.emc.com> <1126218402469@kroah.com> <20050909130440.4E31E271E6@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909130440.4E31E271E6@lns1058.lss.emc.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brett M Russ <russb@emc.com>

Previous INTx cleanup patch had a bug that was not caught.  I found
this last night during testing and can confirm that it is now 100%
working.

Signed-off-by: Brett Russ <russb@emc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -819,7 +819,7 @@ pci_intx(struct pci_dev *pdev, int enabl
 	}
 
 	if (new != pci_command) {
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+		pci_write_config_word(pdev, PCI_COMMAND, new);
 	}
 }
 
