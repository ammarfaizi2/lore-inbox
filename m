Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVIJMVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVIJMVl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVIJMVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:40 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:51591 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750785AbVIJMVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:17 -0400
Date: Sat, 10 Sep 2005 14:21:09 +0200
Message-Id: <200509101221.j8ACL9b5017238@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 3/10] drivers/char: pci_find_device remove (drivers/char/mxser.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 mxser.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -511,6 +511,7 @@ static void __exit mxser_module_exit(voi
 			if (pdev != NULL) {	//PCI
 				release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
 				release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
+				pci_dev_put(pdev);
 			} else {
 				release_region(mxsercfg[i].ioaddr[0], 8 * mxsercfg[i].ports);
 				release_region(mxsercfg[i].vector, 1);
@@ -831,7 +832,7 @@ static int mxser_init(void)
 	index = 0;
 	b = 0;
 	while (b < n) {
-		pdev = pci_find_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev);
+		pdev = pci_get_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev);
 			if (pdev == NULL) {
 			b++;
 			continue;
