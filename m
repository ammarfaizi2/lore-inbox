Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVC0TJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVC0TJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVC0TJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:09:48 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:43704 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261462AbVC0TJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:09:17 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] shrink drivers/pci/proc.c::pci_seq_start()
Date: Sun, 27 Mar 2005 15:05:43 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503271605.43967.eike-kernel@sf-tec.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch shrinks pci_seq_start by using for_each_pci_dev() macro instead
of explicitely using a loop and avoiding a goto.

Eike

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.11/drivers/pci/proc.c	2005-03-21 11:41:56.000000000 +0100
+++ linux-2.6.12-rc1/drivers/pci/proc.c	2005-03-27 16:03:10.000000000 +0200
@@ -313,13 +313,10 @@ static void *pci_seq_start(struct seq_fi
 	struct pci_dev *dev = NULL;
 	loff_t n = *pos;
 
-	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
-	while (n--) {
-		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
-		if (dev == NULL)
-			goto exit;
+	for_each_pci_dev(dev) {
+		if (!n--)
+			break;
 	}
-exit:
 	return dev;
 }
 
