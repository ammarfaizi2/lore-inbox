Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUGAI0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUGAI0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 04:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUGAI0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 04:26:24 -0400
Received: from alsvidh.mathematik.uni-muenchen.de ([129.187.111.42]:33738 "EHLO
	alsvidh.mathematik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S264298AbUGAI0S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 04:26:18 -0400
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: [patch, 2.6, ppc] some modular framebuffer support
Organization: Lehrstuhl fuer vergleichende Astrozoologie
X-Mahlzeit: Das ist per Saldo Gemuetlichkeit
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 01 Jul 2004 10:26:18 +0200
Message-ID: <hh4qosi15h.fsf@alsvidh.mathematik.uni-muenchen.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch allows some accelerated framebuffers (aty128fb,
atyfb, radeonfb, and rivafb) and framebuffer console support itself to
be built as modules on ppc.  Tested on a Powerbook Pismo, works very
well including XFree86 and DRI.

The first hunk suppresses a warning only, not sure about it.

Regards, Jens.

--- linux-2.6.7/drivers/video/fbmem.c.orig	2004-06-16 08:40:18.190362000 +0200
+++ linux-2.6.7/drivers/video/fbmem.c	2004-06-30 20:29:01.118531467 +0200
@@ -930,7 +930,7 @@
 			return -ENOMEM;
 		}
 		
-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user((void*)cursor.image.data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) { 
 			kfree(cursor.image.data);
 			kfree(cursor.mask);
--- linux-2.6.7/arch/ppc/kernel/ppc_ksyms.c.orig	2004-06-16 08:40:08.536549000 +0200
+++ linux-2.6.7/arch/ppc/kernel/ppc_ksyms.c	2004-06-30 21:54:32.018107682 +0200
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/pm.h>
+#include <linux/fb.h>
 
 #include <asm/page.h>
 #include <asm/semaphore.h>
@@ -351,3 +352,11 @@
 extern unsigned long agp_special_page;
 EXPORT_SYMBOL(agp_special_page);
 #endif
+#ifdef CONFIG_FB
+extern int __init mac_find_mode(struct fb_var_screeninfo *,
+				struct fb_info *, const char *,
+				unsigned int);
+extern int mac_vmode_to_var(int, int, struct fb_var_screeninfo *);
+EXPORT_SYMBOL(mac_find_mode);
+EXPORT_SYMBOL(mac_vmode_to_var);
+#endif


-- 
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!
