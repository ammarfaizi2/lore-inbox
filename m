Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTFJSgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFJSgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:36:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60827 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261960AbTFJSgs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:48 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270967446@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709672859@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1348, 2003/06/09 15:54:51-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/pci/proc.c


 drivers/pci/proc.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)


diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Tue Jun 10 11:20:02 2003
+++ b/drivers/pci/proc.c	Tue Jun 10 11:20:02 2003
@@ -579,19 +579,17 @@
 
 static int __init pci_proc_init(void)
 {
-	if (pci_present()) {
-		struct proc_dir_entry *entry;
-		struct pci_dev *dev = NULL;
-		proc_bus_pci_dir = proc_mkdir("pci", proc_bus);
-		entry = create_proc_entry("devices", 0, proc_bus_pci_dir);
-		if (entry)
-			entry->proc_fops = &proc_bus_pci_dev_operations;
-		proc_initialized = 1;
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-			pci_proc_attach_device(dev);
-		}
-		legacy_proc_init();
+	struct proc_dir_entry *entry;
+	struct pci_dev *dev = NULL;
+	proc_bus_pci_dir = proc_mkdir("pci", proc_bus);
+	entry = create_proc_entry("devices", 0, proc_bus_pci_dir);
+	if (entry)
+		entry->proc_fops = &proc_bus_pci_dev_operations;
+	proc_initialized = 1;
+	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		pci_proc_attach_device(dev);
 	}
+	legacy_proc_init();
 	return 0;
 }
 

