Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVDBANH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVDBANH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVDBAMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:12:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:42716 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262955AbVDAXsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:20 -0500
Cc: eike-kernel@sf-tec.de
Subject: [PATCH] PCI: shrink drivers/pci/proc.c::pci_seq_start()
In-Reply-To: <11123992731314@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:53 -0800
Message-Id: <11123992732759@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.21, 2005/03/28 15:10:34-08:00, eike-kernel@sf-tec.de

[PATCH] PCI: shrink drivers/pci/proc.c::pci_seq_start()

this patch shrinks pci_seq_start by using for_each_pci_dev() macro instead
of explicitely using a loop and avoiding a goto.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/proc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)


diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	2005-04-01 15:32:36 -08:00
+++ b/drivers/pci/proc.c	2005-04-01 15:32:36 -08:00
@@ -313,13 +313,10 @@
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
 

