Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbVDAXzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVDAXzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVDAXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:48:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:25308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262806AbVDAXsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:08 -0500
Cc: bunk@stusta.de
Subject: [PATCH] drivers/pci/msi.c: fix a check after use
In-Reply-To: <11123992741846@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:54 -0800
Message-Id: <11123992742611@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.24, 2005/03/28 15:20:34-08:00, bunk@stusta.de

[PATCH] drivers/pci/msi.c: fix a check after use

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/msi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c	2005-04-01 15:31:25 -08:00
+++ b/drivers/pci/msi.c	2005-04-01 15:31:25 -08:00
@@ -703,11 +703,13 @@
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
-	int pos, temp = dev->irq, status = -EINVAL;
+	int pos, temp, status = -EINVAL;
 	u16 control;
 
 	if (!pci_msi_enable || !dev)
  		return status;
+
+	temp = dev->irq;
 
 	if ((status = msi_init()) < 0)
 		return status;

