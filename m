Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbRAERTa>; Fri, 5 Jan 2001 12:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRAERTV>; Fri, 5 Jan 2001 12:19:21 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:22779 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S131051AbRAERTR>; Fri, 5 Jan 2001 12:19:17 -0500
Date: Fri, 5 Jan 2001 17:19:13 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0: parport device IDs
Message-ID: <20010105171913.O5253@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, here is a patch from Adam J. Richter to add the tiny kernel
hook for device-id based parport device driver module loading, as well
as an example usage in lp.c. (The code for making use of it is already
in modutils.)

Tim.
*/

2001-01-05  Adam J. Richter  <adam@yggdrasil.com>

	* include/linux/parport.h: Declare parport_device_id.
	* drivers/char/lp.c: Use it as MODULE_DEVICE_TABLE.

--- linux-2.4.0/include/linux/parport.h.devid	Tue Aug  8 13:39:21 2000
+++ linux-2.4.0/include/linux/parport.h	Fri Jan  5 10:58:18 2001
@@ -91,6 +91,10 @@
 /* Flags for block transfer operations. */
 #define PARPORT_EPP_FAST		(1<<0) /* Unreliable counts. */
 
+struct parport_device_id {
+	const char *pattern;
+};
+
 /* The rest is for the kernel only */
 #ifdef __KERNEL__
 
--- linux-2.4.0/drivers/char/lp.c.devid	Fri Jan  5 10:58:18 2001
+++ linux-2.4.0/drivers/char/lp.c	Fri Jan  5 10:58:18 2001
@@ -141,6 +141,17 @@
 /* ROUND_UP macro from fs/select.c */
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
 
+/* printer_ieee1284_id is declared as its own variable so that it
+   can be in the __initdata section. */
+static __initdata char printer_ieee1284_id[] = "CLS:PRINTER";
+
+static __initdata struct parport_device_id printer_id_tbl[] = {
+  	{ printer_ieee1284_id },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(parport, printer_id_tbl);
+
 static devfs_handle_t devfs_handle = NULL;
 
 struct lp_struct lp_table[LP_NO];
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
