Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbVIBVpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbVIBVpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbVIBVpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:45:39 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:55685 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1161065AbVIBVpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:45:31 -0400
Date: Fri, 2 Sep 2005 23:45:27 +0200
Message-Id: <200509022145.j82LjRC0031385@wscnet.wsc.cz>
In-reply-to: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Subject: [PATCH 1/6] include, sound: pci_find_device remove (include/asm-i386/ide.h)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

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
