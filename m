Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUFFQSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUFFQSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUFFQSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:18:17 -0400
Received: from may.priocom.com ([213.156.65.50]:65410 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263788AbUFFQRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:17:41 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in acpi_get__hpp()
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086538689.2793.86.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:18:10 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds memory checks in acpi_get__hpp()

 ./linux-2.6.6-modified/drivers/pci/hotplug/pciehprm_acpi.c |    2 ++
 1 files changed, 2 insertions(+)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/drivers/pci/hotplug/pciehprm_acpi.c
./linux-2.6.6-modified/drivers/pci/hotplug/pciehprm_acpi.c
--- ./linux-2.6.6/drivers/pci/hotplug/pciehprm_acpi.c	Mon May 10
05:33:19 2004
+++ ./linux-2.6.6-modified/drivers/pci/hotplug/pciehprm_acpi.c	Wed Jun 
2 14:27:54 2004
@@ -218,6 +218,8 @@ static void acpi_get__hpp ( struct acpi_
 	}
 
 	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
+	if (!ab->_hpp)
+		goto free_and_return;
 	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
 
 	ab->_hpp->cache_line_size	= nui[0];

-- 
umka

