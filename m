Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265940AbUKATyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUKATyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S292015AbUKATcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:32:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35526 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291910AbUKATaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:30 -0500
Date: Mon, 1 Nov 2004 19:30:21 GMT
Message-Id: <200411011930.iA1JULRt023195@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 6/14] FRV: IDE fixes
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes the IDE driver to initialise correctly in the case
that IDE_ARCH_OBSOLETE_INIT is not defined.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-ide-2610rc1bk10.diff
 setup-pci.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/drivers/ide/setup-pci.c linux-2.6.10-rc1-bk10-frv/drivers/ide/setup-pci.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/drivers/ide/setup-pci.c	2004-11-01 11:45:23.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/drivers/ide/setup-pci.c	2004-11-01 11:47:04.826660626 +0000
@@ -425,7 +425,12 @@
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
