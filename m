Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTDMMzu (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTDMMzu (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:55:50 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:546 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S263494AbTDMMzq (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:55:46 -0400
Date: Sun, 13 Apr 2003 15:04:48 +0200
Message-Id: <200304131304.h3DD4mEZ001257@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Duplicate PROC_CONSOLE()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate PROC_CONSOLE():
  - Remove local copy of PROC_CONSOLE() in drivers/video/modedb.c. A global one
    is already provided by drivers/video/fbcon.c
  - Add missing multiple include protectors to <linux/console_struct.h>

--- linux-2.4.x/drivers/video/modedb.c	Sun Dec 23 11:25:09 2001
+++ linux-m68k-2.4.x/drivers/video/modedb.c	Wed Apr  9 13:47:05 2003
@@ -16,6 +16,7 @@
 #include <linux/fb.h>
 #include <linux/console_struct.h>
 #include <linux/sched.h>
+#include <video/fbcon.h>
 
 
 #undef DEBUG
@@ -255,28 +256,6 @@
 		return val;
 	}
     }
-}
-
-static int PROC_CONSOLE(const struct fb_info *info)
-{
-	int fgc;
-	
-	if (info->display_fg != NULL)
-		fgc = info->display_fg->vc_num;
-	else
-		return -1;
-		
-	if (!current->tty)
-		return fgc;
-
-	if (current->tty->driver.type != TTY_DRIVER_TYPE_CONSOLE)
-		/* XXX Should report error here? */
-		return fgc;
-
-	if (MINOR(current->tty->device) < 1)
-		return fgc;
-
-	return MINOR(current->tty->device) - 1;
 }
 
 
--- linux-2.4.x/include/linux/console_struct.h	Thu Sep 20 10:51:46 2001
+++ linux-m68k-2.4.x/include/linux/console_struct.h	Wed Apr  9 13:54:58 2003
@@ -9,6 +9,9 @@
  * to achieve effects such as fast scrolling by changing the origin.
  */
 
+#ifndef _LINUX_CONSOLE_STRUCT_H_
+#define _LINUX_CONSOLE_STRUCT_H_
+
 #define NPAR 16
 
 struct vc_data {
@@ -107,3 +110,5 @@
 #define CUR_DEFAULT CUR_UNDERLINE
 
 #define CON_IS_VISIBLE(conp) (*conp->vc_display_fg == conp)
+
+#endif /* _LINUX_CONSOLE_STRUCT_H_ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
