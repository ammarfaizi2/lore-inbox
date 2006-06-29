Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWF2TYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWF2TYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWF2TWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:22:51 -0400
Received: from [141.84.69.5] ([141.84.69.5]:34832 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932296AbWF2TWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:22:17 -0400
Date: Thu, 29 Jun 2006 21:21:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/cm206.c: cleanups
Message-ID: <20060629192117.GB19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make __cm206_init() __init (required since it calls
  the __init cm206_init())
- make the needlessly global bcdbin() static
- remove a comment with an obsolete compile command

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Jun 2006

 drivers/cdrom/cm206.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- linux-2.6.17-mm2-full/drivers/cdrom/cm206.c.old	2006-06-26 17:50:03.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/cdrom/cm206.c	2006-06-26 18:04:39.000000000 +0200
@@ -915,7 +915,7 @@
 	cd->dsb = wait_dsb();
 }
 
-uch bcdbin(unsigned char bcd)
+static uch bcdbin(unsigned char bcd)
 {				/* stolen from mcd.c! */
 	return (bcd >> 4) * 10 + (bcd & 0xf);
 }
@@ -1533,7 +1533,7 @@
 	}
 }
 
-static int __cm206_init(void)
+static int __init __cm206_init(void)
 {
 	parse_options();
 #if !defined(AUTO_PROBE_MODULE)
@@ -1594,8 +1594,3 @@
 #endif				/* !MODULE */
 MODULE_ALIAS_BLOCKDEV_MAJOR(CM206_CDROM_MAJOR);
 
-/*
- * Local variables:
- * compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe -fno-strength-reduce -m486 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h  -c -o cm206.o cm206.c"
- * End:
- */

