Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271107AbTHCJO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbTHCJOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:14:25 -0400
Received: from [66.212.224.118] ([66.212.224.118]:23558 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271107AbTHCJNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:13:48 -0400
Date: Sun, 3 Aug 2003 05:02:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: maz@wild-wind.fr.eu.org
Subject: [PATCH][2.6] sprinkle __init* in drivers/eisa
Message-ID: <Pine.LNX.4.53.0308030441530.3473@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch applies on top of previous virtual eisa bridge ->release() patch. 
Otherwise one line reject.

Index: linux-2.6.0-test2-mm2/drivers/eisa/eisa-bus.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/drivers/eisa/eisa-bus.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 eisa-bus.c
--- linux-2.6.0-test2-mm2/drivers/eisa/eisa-bus.c	30 Jul 2003 00:06:12 -0000	1.1.1.1
+++ linux-2.6.0-test2-mm2/drivers/eisa/eisa-bus.c	3 Aug 2003 08:57:10 -0000
@@ -36,10 +36,10 @@ static struct eisa_device_info __initdat
 #define EISA_MAX_FORCED_DEV 16
 #define EISA_FORCED_OFFSET  2
 
-static int enable_dev[EISA_MAX_FORCED_DEV + EISA_FORCED_OFFSET]  = { 1, EISA_MAX_FORCED_DEV, };
-static int disable_dev[EISA_MAX_FORCED_DEV + EISA_FORCED_OFFSET] = { 1, EISA_MAX_FORCED_DEV, };
+static int __initdata enable_dev[EISA_MAX_FORCED_DEV + EISA_FORCED_OFFSET]  = { 1, EISA_MAX_FORCED_DEV, };
+static int __initdata disable_dev[EISA_MAX_FORCED_DEV + EISA_FORCED_OFFSET] = { 1, EISA_MAX_FORCED_DEV, };
 
-static int is_forced_dev (int *forced_tab,
+static int __init is_forced_dev (int *forced_tab,
 			  struct eisa_root_device *root,
 			  struct eisa_device *edev)
 {
@@ -375,7 +375,7 @@ static struct resource eisa_root_res = {
 	.flags = IORESOURCE_IO,
 };
 
-static int eisa_bus_count;
+static int __initdata eisa_bus_count;
 
 int __init eisa_root_register (struct eisa_root_device *root)
 {
Index: linux-2.6.0-test2-mm2/drivers/eisa/virtual_root.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/drivers/eisa/virtual_root.c,v
retrieving revision 1.2
diff -u -p -B -r1.2 virtual_root.c
--- linux-2.6.0-test2-mm2/drivers/eisa/virtual_root.c	3 Aug 2003 08:57:03 -0000	1.2
+++ linux-2.6.0-test2-mm2/drivers/eisa/virtual_root.c	3 Aug 2003 08:57:58 -0000
@@ -21,7 +21,7 @@
 #define EISA_FORCE_PROBE_DEFAULT 0
 #endif
 
-static int force_probe = EISA_FORCE_PROBE_DEFAULT;
+static int __initdata force_probe = EISA_FORCE_PROBE_DEFAULT;
 static void virtual_eisa_release(struct device *);
 
 /* The default EISA device parent (virtual root device).
@@ -50,7 +50,7 @@ static void virtual_eisa_release (struct
 	return;
 }
 
-static int virtual_eisa_root_init (void)
+static int __init virtual_eisa_root_init (void)
 {
 	int r;
 	
