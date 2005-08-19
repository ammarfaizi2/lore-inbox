Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVHSPU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVHSPU7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVHSPU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:20:59 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:48577 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751019AbVHSPU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:20:58 -0400
Date: Sat, 20 Aug 2005 00:20:10 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: add pcibios_select_root
Message-Id: <20050820002010.4e81cdcd.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has added pcibios_select_root to MIPS.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/include/asm-mips/pci.h mm1/include/asm-mips/pci.h
--- mm1-orig/include/asm-mips/pci.h	2005-08-20 00:04:18.000000000 +0900
+++ mm1/include/asm-mips/pci.h	2005-08-19 23:53:04.000000000 +0900
@@ -167,4 +167,17 @@
 /* Do platform specific device initialization at pci_enable_device() time */
 extern int pcibios_plat_dev_init(struct pci_dev *dev);
 
+static inline struct resource *
+pcibios_select_root(struct pci_dev *pdev, struct resource *res)
+{
+	struct resource *root = NULL;
+
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
+	return root;
+}
+
 #endif /* _ASM_PCI_H */


