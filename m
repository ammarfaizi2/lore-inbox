Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUGWQuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUGWQuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUGWQuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 12:50:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:37037 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267839AbUGWQtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 12:49:55 -0400
Date: Fri, 23 Jul 2004 18:49:53 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.de>
Cc: linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>,
       linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] reenable pc speaker driver for ppc and ppc64
Message-ID: <20040723164953.GB3836@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ppc PReP and CHRP boards have PC speaker hardware. A recent patch
disabled that for many archs, also for ppc. But the driver works fine
here. An asm header was missing, I just copied another version.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.7/drivers/input/misc/Kconfig linux-2.6.8-rc2/drivers/input/misc/Kconfig
--- linux-2.6.7/drivers/input/misc/Kconfig	2004-07-23 18:30:34.845608638 +0200
+++ linux-2.6.8-rc2/drivers/input/misc/Kconfig	2004-07-23 17:45:16.519034884 +0200
@@ -14,7 +14,7 @@ config INPUT_MISC
 
 config INPUT_PCSPKR
 	tristate "PC Speaker support"
-	depends on (ALPHA || X86 || X86_64 || MIPS) && INPUT && INPUT_MISC
+	depends on (ALPHA || X86 || X86_64 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES) && INPUT && INPUT_MISC
 	help
 	  Say Y here if you want the standard PC Speaker to be used for
 	  bells and whistles.
diff -purN linux-2.6.7/include/asm-ppc/8253pit.h linux-2.6.8-rc2/include/asm-ppc/8253pit.h
--- linux-2.6.7/include/asm-ppc/8253pit.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8-rc2/include/asm-ppc/8253pit.h	2004-07-23 17:11:19.069707446 +0200
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -purN linux-2.6.7/include/asm-ppc64/8253pit.h linux-2.6.8-rc2/include/asm-ppc64/8253pit.h
--- linux-2.6.7/include/asm-ppc64/8253pit.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8-rc2/include/asm-ppc64/8253pit.h	2004-07-23 17:45:23.459974244 +0200
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
