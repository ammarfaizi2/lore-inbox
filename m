Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSKROcO>; Mon, 18 Nov 2002 09:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSKROcO>; Mon, 18 Nov 2002 09:32:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46035 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262712AbSKROcM>; Mon, 18 Nov 2002 09:32:12 -0500
Date: Mon, 18 Nov 2002 15:39:09 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix compile error in usb-serial.c
Message-ID: <20021118143909.GG11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/serial/usb-serial.c in 2.5.48 fails to compile with the
following error:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/usb/serial/.usb-serial.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=usb_serial
-DKBUILD_MODNAME=usbserial   -c -o drivers/usb/serial/usb-serial.o
drivers/usb/serial/usb-serial.c
drivers/usb/serial/usb-serial.c: In function `serial_read_proc':
drivers/usb/serial/usb-serial.c:842: dereferencing pointer to incompletetype
make[3]: *** [drivers/usb/serial/usb-serial.o] Error 1

<--  snip  -->


Is the following patch correct?


--- linux-2.5.48/drivers/usb/serial/usb-serial.c.old	2002-11-18 15:16:57.000000000 +0100
+++ linux-2.5.48/drivers/usb/serial/usb-serial.c	2002-11-18 15:24:39.000000000 +0100
@@ -839,7 +839,7 @@
 
 		length += sprintf (page+length, "%d:", i);
 		if (serial->type->owner)
-			length += sprintf (page+length, " module:%s", serial->type->owner->name);
+			length += sprintf (page+length, " module:%s", module_name(serial->type->owner));
 		length += sprintf (page+length, " name:\"%s\"", serial->type->name);
 		length += sprintf (page+length, " vendor:%04x product:%04x", serial->vendor, serial->product);
 		length += sprintf (page+length, " num_ports:%d", serial->num_ports);




cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


