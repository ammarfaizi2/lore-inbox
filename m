Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbTFEVMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbTFEUqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:46:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:3507 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265129AbTFEUqW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:46:22 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548468774019@kroah.com>
Subject: [PATCH] More PCI fixes for 2.5.70
In-Reply-To: <20030605210013.GA6917@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 14:01:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1311, 2003/06/05 12:03:29-07:00, greg@kroah.com

[PATCH] PCI: remove direct access of pci_devices from arch/m68k/atari/hades-pci.c


 arch/m68k/atari/hades-pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/m68k/atari/hades-pci.c b/arch/m68k/atari/hades-pci.c
--- a/arch/m68k/atari/hades-pci.c	Thu Jun  5 13:53:11 2003
+++ b/arch/m68k/atari/hades-pci.c	Thu Jun  5 13:53:11 2003
@@ -297,14 +297,14 @@
 			    IRQ_TT_MFP_SCC,	/* Slot 2. */
 			    IRQ_TT_MFP_SCSIDMA	/* Slot 3. */
 			  };
-	struct pci_dev *dev;
+	struct pci_dev *dev = NULL;
 	unsigned char slot;
 
 	/*
 	 * Go through all devices, fixing up irqs as we see fit:
 	 */
 
-	for (dev = pci_devices; dev; dev = dev->next)
+	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 	{
 		if (dev->class >> 16 != PCI_BASE_CLASS_BRIDGE)
 		{

