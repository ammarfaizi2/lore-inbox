Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVIJUdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVIJUdF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVIJUdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:33:05 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:19842 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932283AbVIJUdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:33:03 -0400
Date: Sat, 10 Sep 2005 22:32:59 +0200
Message-Id: <200509102032.j8AKWxMC006246@localhost.localdomain>
Subject: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

Repost, posted on:
02 Sep 2005

 ide.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/asm-i386/ide.h b/include/asm-i386/ide.h
--- a/include/asm-i386/ide.h
+++ b/include/asm-i386/ide.h
@@ -41,7 +41,12 @@ static __inline__ int ide_default_irq(un
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-	if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
+	struct pci_dev *pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
+	unsigned int a = !pdev;
+
+	pci_dev_put(pdev);
+
+	if (a) {
 		switch(index) {
 			case 2: return 0x1e8;
 			case 3: return 0x168;
