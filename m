Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319615AbSIML4T>; Fri, 13 Sep 2002 07:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319616AbSIML4T>; Fri, 13 Sep 2002 07:56:19 -0400
Received: from CPE-203-51-30-83.nsw.bigpond.net.au ([203.51.30.83]:33789 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S319615AbSIML4K>; Fri, 13 Sep 2002 07:56:10 -0400
Message-ID: <3D81D377.9FD9EE75@eyal.emu.id.au>
Date: Fri, 13 Sep 2002 22:00:55 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre7 - compile fixes
References: <Pine.LNX.4.44.0209122313470.30211-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------36995554CA371FADE64D5B04"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------36995554CA371FADE64D5B04
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

drivers/mtd/devices/ms02-nv.c
=============================
gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=ms02_nv  -c -o
ms02-nv.o ms02-nv.c
ms02-nv.c:18: asm/addrspace.h: No such file or directory
ms02-nv.c:19: asm/bootinfo.h: No such file or directory
ms02-nv.c:20: asm/dec/ioasic_addrs.h: No such file or directory
ms02-nv.c:21: asm/dec/kn02.h: No such file or directory
ms02-nv.c:22: asm/dec/kn03.h: No such file or directory
ms02-nv.c:24: asm/paccess.h: No such file or directory
ms02-nv.c: In function `ms02nv_probe_one':
ms02-nv.c:100: warning: implicit declaration of function `KSEG1ADDR'
ms02-nv.c:102: warning: implicit declaration of function `get_dbe'
ms02-nv.c: In function `ms02nv_init_one':
ms02-nv.c:91: warning: `ms02nv_magic' might be used uninitialized in
this function
ms02-nv.c: In function `ms02nv_init':
ms02-nv.c:292: `mips_machtype' undeclared (first use in this function)
ms02-nv.c:292: (Each undeclared identifier is reported only once
ms02-nv.c:292: for each function it appears in.)
ms02-nv.c:293: `MACH_DS5000_200' undeclared (first use in this function)
ms02-nv.c:294: `KN02_CSR_ADDR' undeclared (first use in this function)
ms02-nv.c:295: `KN02_CSR_BNK32M' undeclared (first use in this function)
ms02-nv.c:298: `MACH_DS5000_2X0' undeclared (first use in this function)
ms02-nv.c:299: `KN03_MCR_BASE' undeclared (first use in this function)
ms02-nv.c:300: `KN03_MCR_BNK32M' undeclared (first use in this function)
ms02-nv.c:296: warning: unreachable code at beginning of switch
statement
make[3]: *** [ms02-nv.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/mtd/devices'

This is in i386, this is the wrong arch for this module?
Seems like a bad config.


drivers/net/irda/irtty.c
========================
Same as -pre6, we are missing a generic TIOCM_MODEM_BITS. Needs a
"proper" fix but this gets my build through.


drivers/usb/brlvger.c
=====================
Again, same as -pre6. Old gcc __FUNCTION__ issue.


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------36995554CA371FADE64D5B04
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre7-mtd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre7-mtd.patch"

--- linux/drivers/mtd/devices/Config.in.orig	Fri Sep 13 21:23:07 2002
+++ linux/drivers/mtd/devices/Config.in	Fri Sep 13 21:24:54 2002
@@ -10,7 +10,9 @@
    bool '    PMC551 256M DRAM Bugfix' CONFIG_MTD_PMC551_BUGFIX
    bool '    PMC551 Debugging' CONFIG_MTD_PMC551_DEBUG
 fi
-dep_tristate '  DEC MS02-NV NVRAM module support' CONFIG_MTD_MS02NV $CONFIG_MTD $CONFIG_DECSTATION
+if [ "$CONFIG_DECSTATION" = "y"]; then
+   dep_tristate '  DEC MS02-NV NVRAM module support' CONFIG_MTD_MS02NV $CONFIG_MTD
+fi
 dep_tristate '  Uncached system RAM' CONFIG_MTD_SLRAM $CONFIG_MTD
 if [ "$CONFIG_SA1100_LART" = "y" ]; then
   dep_tristate '  28F160xx flash driver for LART' CONFIG_MTD_LART $CONFIG_MTD

--------------36995554CA371FADE64D5B04
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre7-irtty.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre7-irtty.patch"

--- linux/drivers/net/irda/irtty.c.orig	Wed Sep 11 08:33:21 2002
+++ linux/drivers/net/irda/irtty.c	Wed Sep 11 08:33:59 2002
@@ -758,6 +758,7 @@
 	struct irtty_cb *self;
 	struct tty_struct *tty;
 	mm_segment_t fs;
+#define TIOCM_MODEM_BITS	(TIOCM_OUT2 | TIOCM_OUT1)
 	int arg = TIOCM_MODEM_BITS;
 
 	self = (struct irtty_cb *) dev->priv;

--------------36995554CA371FADE64D5B04
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre7-brlvger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre7-brlvger.patch"

--- linux/drivers/usb/brlvger.c.orig	Thu Aug 29 10:30:50 2002
+++ linux/drivers/usb/brlvger.c	Thu Aug 29 10:31:02 2002
@@ -209,7 +209,7 @@
     ({ printk(KERN_ERR "Voyager: " args); \
        printk("\n"); })
 #define dbgprint(fmt, args...) \
-    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__, ##args); \
+    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__ , ##args); \
        printk("\n"); })
 #define dbg(args...) \
     ({ if(debug >= 1) dbgprint(args); })

--------------36995554CA371FADE64D5B04--

