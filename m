Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVKTXI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVKTXI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVKTXI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:08:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29968 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932108AbVKTXI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:08:27 -0500
Date: Mon, 21 Nov 2005 00:08:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: markus.lidel@shadowconnect.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [2.6 patch] drivers/message/i2o/pci.c: fix a NULL pointer dereference
Message-ID: <20051120230826.GD16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this obvious NULL pointer dereference.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/drivers/message/i2o/pci.c.old	2005-11-20 21:50:45.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/message/i2o/pci.c	2005-11-20 21:51:08.000000000 +0100
@@ -421,8 +421,8 @@
 	i2o_pci_free(c);
 
       free_controller:
-	i2o_iop_free(c);
 	put_device(c->device.parent);
+	i2o_iop_free(c);
 
       disable:
 	pci_disable_device(pdev);

