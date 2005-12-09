Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVLIOLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVLIOLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVLIOLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:11:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:62691 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751336AbVLIOLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:11:02 -0500
Date: Fri, 9 Dec 2005 15:10:59 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Mouse button swapping
Message-ID: <Pine.LNX.4.61.0512091508250.8080@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I produced a small patch that allows one to flip the mouse buttons at the 
kernel level. This is useful for changing it on a per-system basis, i.e. it 
will affect gpm, X and VMware all at once. It is changeable through
/sys/module/mousedev/swap_buttons at runtime. Is this something mainline would
be interested in?

diff -dpru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2005-10-22 20:59:22.000000000 +0200
+++ b/drivers/input/mousedev.c	2005-11-22 19:32:01.000000000 +0100
@@ -40,6 +40,10 @@ MODULE_LICENSE("GPL");
 #define CONFIG_INPUT_MOUSEDEV_SCREEN_Y	768
 #endif
 
+static unsigned int swap_buttons = 0;
+module_param(swap_buttons, uint, 0644);
+MODULE_PARM_DESC(swap_buttons, "Swap left and right mouse buttons");
+
 static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
 module_param(xres, uint, 0);
 MODULE_PARM_DESC(xres, "Horizontal screen resolution");
@@ -191,10 +195,10 @@ static void mousedev_key_event(struct mo
 		case BTN_TOUCH:
 		case BTN_0:
 		case BTN_FORWARD:
-		case BTN_LEFT:		index = 0; break;
+		case BTN_LEFT:		index = !!swap_buttons; break;
 		case BTN_STYLUS:
 		case BTN_1:
-		case BTN_RIGHT:		index = 1; break;
+		case BTN_RIGHT:		index = !swap_buttons; break;
 		case BTN_2:
 		case BTN_STYLUS2:
 		case BTN_MIDDLE:	index = 2; break;
# eof


Jan Engelhardt
-- 
