Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTD3Ryk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTD3Ryk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:54:40 -0400
Received: from pointblue.com.pl ([62.89.73.6]:44810 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262273AbTD3Ryh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:54:37 -0400
Subject: [PATCH] 2.5.68-bk10 - usbkbd.c compilation error
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linus <torvalds@transmeta.com>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1051726009.21774.15.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Apr 2003 19:06:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,drivers/usb/input/.usbkbd.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=pentium4
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include -DMODULE   -DKBUILD_BASENAME=usbkbd
-DKBUILD_MODNAME=usbkbd -c -o drivers/usb/input/.tmp_usbkbd.o
drivers/usb/input/usbkbd.c
drivers/usb/input/usbkbd.c:363: unknown field `devclass' specified in
initializer
drivers/usb/input/usbkbd.c:363: `input_devclass' undeclared here (not in
a function)
drivers/usb/input/usbkbd.c:363: initializer element is not constant
drivers/usb/input/usbkbd.c:363: (near initialization for
`usb_kbd_driver.driver.name')
drivers/usb/input/usbkbd.c:364: initializer element is not constant
drivers/usb/input/usbkbd.c:364: (near initialization for
`usb_kbd_driver.driver')
make[3]: *** [drivers/usb/input/usbkbd.o] Error 1
make[2]: *** [drivers/usb/input] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

the same problem exists in usbmouse.c

changes are the same like in :
http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.5%2Fsnapshots%2Fincr%2Fpatch-2.5.68-bk9-bk10.bz2;z=74



This solves problem:

diff -u -r linux-2.5.68-bk10-org/drivers/usb/input/usbkbd.c
linux-2.5.68-bk10-changed/drivers/usb/input/usbkbd.c
--- linux-2.5.68-bk10-org/drivers/usb/input/usbkbd.c    2003-04-30
18:50:43.000000000 +0100
+++ linux-2.5.68-bk10-changed/drivers/usb/input/usbkbd.c       
2003-04-30 18:50:55.000000000 +0100
@@ -359,9 +359,6 @@
        .probe =        usb_kbd_probe,
        .disconnect =   usb_kbd_disconnect,
        .id_table =     usb_kbd_id_table,
-       .driver = {
-               .devclass = &input_devclass,
-       },
 };

 static int __init usb_kbd_init(void)
diff -u -r linux-2.5.68-bk10-org/drivers/usb/input/usbmouse.c
linux-2.5.68-bk10-changed/drivers/usb/input/usbmouse.c
--- linux-2.5.68-bk10-org/drivers/usb/input/usbmouse.c  2003-04-30
18:54:11.000000000 +0100
+++ linux-2.5.68-bk10-changed/drivers/usb/input/usbmouse.c     
2003-04-30 18:54:30.000000000 +0100
@@ -242,9 +242,6 @@
        .probe          = usb_mouse_probe,
        .disconnect     = usb_mouse_disconnect,
        .id_table       = usb_mouse_id_table,
-       .driver = {
-               .devclass = &input_devclass,
-       },
 };

 static int __init usb_mouse_init(void)

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

