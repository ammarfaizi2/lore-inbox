Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWJQKid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWJQKid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 06:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWJQKid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 06:38:33 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:28603 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161206AbWJQKic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 06:38:32 -0400
Message-ID: <4534B2CA.1000108@cn.ibm.com>
Date: Tue, 17 Oct 2006 18:39:06 +0800
From: Yi CDL Yang <yyangcdl@cn.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [PATCH 2.6.19-rc2]: Fix protdrv_pci.c compile error
X-MIMETrack: Itemize by SMTP Server on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 10/17/2006 18:41:45,
	Serialize by Router on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 10/17/2006 18:41:47,
	Serialize complete at 10/17/2006 18:41:47
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=GB2312
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM isn't set, the compiler will report the following error:

drivers/built-in.o: In function `.pcie_portdrv_slot_reset':
portdrv_pci.c:(.text+0xa80c): undefined reference to `.pcie_portdrv_restore_config'
make: *** [.tmp_vmlinux1] Error 1

The problem is that pcie_portdrv_restore_config isn't defiend when PM is disabled.


This patch fixes this problem, please consider to apply, thanks.

Signed-off by Yi Yang <yyangcdl@cn.ibm.com>

--- a/drivers/pci/pcie/portdrv_pci.c	2006-10-13 12:25:04.000000000 -0400
+++ b/drivers/pci/pcie/portdrv_pci.c	2006-10-16 18:49:43.000000000 -0400
@@ -37,7 +37,6 @@ static int pcie_portdrv_save_config(stru
 	return pci_save_state(dev);
 }
 
-#ifdef CONFIG_PM
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
 	int retval;
@@ -50,6 +49,7 @@ static int pcie_portdrv_restore_config(s
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int pcie_portdrv_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	int ret = pcie_port_device_suspend(dev, state);
 


