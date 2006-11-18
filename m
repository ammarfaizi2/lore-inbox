Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755994AbWKRF6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbWKRF6o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbWKRF62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:58:28 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:57077 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1755992AbWKRF60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:58:26 -0500
Date: Fri, 17 Nov 2006 21:51:34 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rolandd@cisco.com, support@pathscale.com, akpm <akpm@osdl.org>
Subject: [PATCH -mm] ipath needs HT_IRQ
Message-Id: <20061117215134.0399c2c6.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

IPATH needs HT_IRQ to prevent these build errors:
drivers/built-in.o: In function `ipath_ht_free_irq':
ipath_iba6110.c:(.text+0x15c76b): undefined reference to `ht_destroy_irq'
drivers/built-in.o: In function `ipath_setup_ht_config':
ipath_iba6110.c:(.text+0x15cbb1): undefined reference to `__ht_create_irq'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/infiniband/hw/ipath/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc5mm2.orig/drivers/infiniband/hw/ipath/Kconfig
+++ linux-2619-rc5mm2/drivers/infiniband/hw/ipath/Kconfig
@@ -1,6 +1,6 @@
 config INFINIBAND_IPATH
 	tristate "QLogic InfiniPath Driver"
-	depends on PCI_MSI && 64BIT && INFINIBAND
+	depends on PCI_MSI && 64BIT && INFINIBAND && HT_IRQ
 	---help---
 	This is a driver for QLogic InfiniPath host channel adapters,
 	including InfiniBand verbs support.  This driver allows these


---
