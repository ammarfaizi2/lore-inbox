Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVCXBOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVCXBOU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVCXBOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:14:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37392 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262296AbVCXBOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:14:17 -0500
Date: Thu, 24 Mar 2005 02:14:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dmo@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/DAC960.c: fix a use after free
Message-ID: <20050324011414.GJ1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a use after free found by the Coverity checker.

Controller is used in the Failure path.

In the Failure patch, Controller will be freed in the end, so this kfree 
can simply be deleted.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/block/DAC960.c.old	2005-03-23 03:35:40.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/block/DAC960.c	2005-03-23 03:38:10.000000000 +0100
@@ -2700,10 +2700,8 @@
   Controller->PCIDevice = PCI_Device;
   strcpy(Controller->FullModelName, "DAC960");
 
-  if (pci_enable_device(PCI_Device))  {
-        kfree(Controller);
+  if (pci_enable_device(PCI_Device))
 	goto Failure;
-  }
 
   switch (Controller->HardwareType)
   {

