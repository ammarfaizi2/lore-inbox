Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262695AbTCUBgh>; Thu, 20 Mar 2003 20:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbTCUBgg>; Thu, 20 Mar 2003 20:36:36 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:32128 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262695AbTCUBga>; Thu, 20 Mar 2003 20:36:30 -0500
Date: Fri, 21 Mar 2003 10:46:37 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: vt.c in 2.5.65-ac1
Message-ID: <20030321014637.GA1520@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a aquestion about patch in patch-2.5.65-ac1 for vt.c.
Here is a extracted patch from patch-2.5.65-ac1.
I think it's no need for 2.5.65.

Regards,
Osamu Tomita

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/vt.c linux-2.5.65-ac1/drivers/char/vt.c
--- linux-2.5.65/drivers/char/vt.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac1/drivers/char/vt.c	2003-03-18 16:58:38.000000000 +0000
@@ -732,6 +732,12 @@
 	if (new_cols == video_num_columns && new_rows == video_num_lines)
 		return 0;
 
+	err = resize_screen(currcons, new_cols, new_rows);
+	if (err) {
+		kfree(newscreen);
+		return err;
+	}
+
 	newscreen = (unsigned short *) kmalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
 		return -ENOMEM;
@@ -746,12 +752,6 @@
 	video_size_row = new_row_size;
 	screenbuf_size = new_screen_size;
 
-	err = resize_screen(currcons, new_cols, new_rows);
-	if (err) {
-		kfree(newscreen);
-		return err;
-	}
-
 	rlth = min(old_row_size, new_row_size);
 	rrem = new_row_size - rlth;
 	old_origin = origin;
@@ -2445,7 +2445,7 @@
 struct tty_driver console_driver;
 static int console_refcount;
 
-static int __init con_init(void)
+static void __init con_init(void)
 {
 	const char *display_desc = NULL;
 	unsigned int currcons = 0;
@@ -2493,7 +2493,6 @@
 #ifdef CONFIG_VT_CONSOLE
 	register_console(&vt_console_driver);
 #endif
-	return 0;
 }
 console_initcall(con_init);
 
