Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTFJVPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTFJVCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:02:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5295 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263866AbTFJShN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:13 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709662961@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709663662@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1339, 2003/06/09 15:50:05-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/hp100.c


 drivers/net/hp100.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c	Tue Jun 10 11:20:54 2003
+++ b/drivers/net/hp100.c	Tue Jun 10 11:20:54 2003
@@ -405,7 +405,7 @@
 	/* First: scan PCI bus(es) */
 
 #ifdef CONFIG_PCI
-	if (pci_present()) {
+	{
 		int pci_index;
 		struct pci_dev *pci_dev = NULL;
 		int pci_id_index;
@@ -2973,8 +2973,10 @@
 {
 	int i, cards;
 
-	if (hp100_port == 0 && !EISA_bus && !pci_present())
+#ifndef CONFIG_PCI
+	if (hp100_port == 0 && !EISA_bus)
 		printk("hp100: You should not use auto-probing with insmod!\n");
+#endif
 
 	/* Loop on all possible base addresses */
 	i = -1;

