Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVC0VPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVC0VPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVC0VPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:15:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49168 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261556AbVC0VP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:15:26 -0500
Date: Sun, 27 Mar 2005 23:15:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: tom.l.nguyen@intel.com
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] drivers/pci/msi.c: fix a check after use
Message-ID: <20050327211524.GE4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/pci/msi.c.old	2005-03-23 04:46:30.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/pci/msi.c	2005-03-23 04:47:03.000000000 +0100
@@ -703,12 +703,14 @@
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
-	int pos, temp = dev->irq, status = -EINVAL;
+	int pos, temp, status = -EINVAL;
 	u16 control;
 
 	if (!pci_msi_enable || !dev)
  		return status;
 
+	temp = dev->irq;
+
 	if ((status = msi_init()) < 0)
 		return status;
 

