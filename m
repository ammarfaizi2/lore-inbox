Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVHPWQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVHPWQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVHPWQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:16:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:9873 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750974AbVHPWQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:16:19 -0400
Date: Tue, 16 Aug 2005 15:16:05 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/7] PCI: fix quirk-6700-fix.patch
Message-ID: <20050816221605.GD28619@kroah.com>
References: <20050816220001.699316000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-quirk-6700-fix.patch"
In-Reply-To: <20050816221527.GA28619@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

drivers/built-in.o(.text+0x32c3): In function `quirk_pcie_pxh':
/usr/src/25/drivers/pci/quirks.c:1312: undefined reference to `disable_msi_mode'

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/pci.h |    6 ++++++
 1 files changed, 6 insertions(+)

--- gregkh-2.6.orig/drivers/pci/pci.h	2005-08-16 14:57:46.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci.h	2005-08-16 14:57:47.000000000 -0700
@@ -46,7 +46,13 @@ extern int pci_msi_quirk;
 #else
 #define pci_msi_quirk 0
 #endif
+
+#ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
+#else
+static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
+#endif
+
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;

--
