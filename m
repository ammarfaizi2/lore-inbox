Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUFFQV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUFFQV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUFFQV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:21:28 -0400
Received: from may.priocom.com ([213.156.65.50]:16773 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263775AbUFFQUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:20:23 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in
	drivers/pci/hotplug/shpchprm_acpi.c
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086538851.2793.90.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:20:51 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds memory allocation checks in acpi_get__hpp()

 ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c |    2 ++
 1 files changed, 2 insertions(+)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c
./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c
--- ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c	Mon May 10
05:32:28 2004
+++ ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c	Wed Jun 
2 14:28:07 2004
@@ -218,6 +218,8 @@ static void acpi_get__hpp ( struct acpi_
 	}
 
 	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
+	if (!ab->_hpp)
+		goto free_and_return;
 	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
 
 	ab->_hpp->cache_line_size	= nui[0];

-- 
umka

