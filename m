Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270712AbTHJVO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270713AbTHJVO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:14:56 -0400
Received: from [66.212.224.118] ([66.212.224.118]:47117 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270712AbTHJVOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:14:53 -0400
Date: Sun, 10 Aug 2003 17:03:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>
Subject: [PATCH][2.6] Add release() function for virtual_eisa_root
Message-ID: <Pine.LNX.4.53.0308101654350.31799@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of the following warning. Will the warning get removed later 
on or should we fix these?

EISA: Probing bus 0 at 
EISA: Mainboard INT3190 detected.
EISA: Detected 0 cards.
Device 'eisa0' does not have a release() function, it is broken and must 
be fixed.
Badness in device_release at drivers/base/core.c:84
Call Trace:
 [<c02d4054>] kobject_cleanup+0x64/0x70
 [<c044d5e1>] virtual_eisa_root_init+0x41/0x50
 [<c06d085b>] do_initcalls+0x2b/0xa0
 [<c01070f6>] init+0x56/0x210
 [<c01070a0>] init+0x0/0x210
 [<c0109125>] kernel_thread_helper+0x5/0x10

Index: linux-2.6.0-test2-mm2/drivers/eisa/virtual_root.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/drivers/eisa/virtual_root.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 virtual_root.c
--- linux-2.6.0-test2-mm2/drivers/eisa/virtual_root.c	30 Jul 2003 00:06:12 -0000	1.1.1.1
+++ linux-2.6.0-test2-mm2/drivers/eisa/virtual_root.c	3 Aug 2003 07:39:47 -0000
@@ -22,6 +22,7 @@
 #endif
 
 static int force_probe = EISA_FORCE_PROBE_DEFAULT;
+static void virtual_eisa_release(struct device *);
 
 /* The default EISA device parent (virtual root device).
  * Now use a platform device, since that's the obvious choice. */
@@ -31,6 +32,7 @@ static struct platform_device eisa_root_
 	.id   = 0,
 	.dev  = {
 		.name = "Virtual EISA Bridge",
+		.release = virtual_eisa_release,
 	},
 };
 
@@ -41,6 +43,12 @@ static struct eisa_root_device eisa_bus_
 	.slots	       = EISA_MAX_SLOTS,
 	.dma_mask      = 0xffffffff,
 };
+
+static void virtual_eisa_release (struct device *dev)
+{
+	/* nothing really to do here */
+	return;
+}
 
 static int virtual_eisa_root_init (void)
 {
