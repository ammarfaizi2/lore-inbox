Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbUKHOls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUKHOls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUKHOj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:39:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6593 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261847AbUKHOdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:33:04 -0500
Date: Mon, 8 Nov 2004 14:32:40 GMT
Message-Id: <200411081432.iA8EWeuu023386@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com, alan@redhat.com,
       bzolnier@gmail.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] IDE fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes the IDE driver to initialise correctly in the case
that IDE_ARCH_OBSOLETE_INIT is not defined. Not defining this macro would seem
to be the correct thing to do since it includes the word "obsolete" in its
name.

Signed-Off-By: dhowells@redhat.com
---
diffstat ide-2610rc1mm3.diff
 setup-pci.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/drivers/ide/setup-pci.c linux-2.6.10-rc1-mm3-frv/drivers/ide/setup-pci.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/drivers/ide/setup-pci.c	2004-11-05 13:15:28.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/drivers/ide/setup-pci.c	2004-11-05 14:13:03.714511735 +0000
@@ -425,7 +425,12 @@ static ide_hwif_t *ide_hwif_configure(st
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base ||
 	    hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
 		memset(&hwif->hw, 0, sizeof(hwif->hw));
+#ifndef IDE_ARCH_OBSOLETE_INIT
+		ide_std_init_ports(&hwif->hw, base, (ctl | 2));
+		hwif->hw.io_ports[IDE_IRQ_OFFSET] = 0;
+#else
 		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
+#endif
 		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
 	}
