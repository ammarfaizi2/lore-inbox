Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268489AbTBOAdh>; Fri, 14 Feb 2003 19:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268482AbTBOAdh>; Fri, 14 Feb 2003 19:33:37 -0500
Received: from CPE-203-51-32-65.nsw.bigpond.net.au ([203.51.32.65]:37625 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S268489AbTBOAd2>; Fri, 14 Feb 2003 19:33:28 -0500
Message-ID: <3E4D8D26.F7C98E0B@eyal.emu.id.au>
Date: Sat, 15 Feb 2003 11:43:18 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre4-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre4aa2 - build problems (and patches)
References: <20030214182434.GY1499@dualathlon.random>
Content-Type: multipart/mixed;
 boundary="------------560D13F7094A0DA43C4699D1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------560D13F7094A0DA43C4699D1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:
> 
> I released a 2.4.21pre4aa2 but I hadn't time to write a changelog or to
> test it yet, so be careful. I'll write the changelog but not today.

My all-modules build had the following problems.

1) linux/Makefile: bad compiler option?
gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-finline-limit=2000 -fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-DUTS_MACHINE='"i386"' -DKBUILD_BASENAME=version -c -o init/version.o
init/version.c
cc1: Invalid option `-finline-limit=2000'
make: *** [init/version.o] Error 1

On Debian 3.0r1 (which is gcc 2.95.4) I had to remove the offending
option.

2) the old drivers/char/scx200.c compile failure is still there (will
it ever be fixed?)

3) drivers/char/ipmi: same failure as before
gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=ipmi_watchdog 
-DEXPORT_SYMTAB -c ipmi_watchdog.c
In file included from ipmi_watchdog.c:38:
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h:17: parse
error before `__u32'
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h:17:
warning: no semicolon at end of struct or union
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h:18:
warning: type defaults to `int' in declaration of `firmware_version'
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h:18:
warning: data definition has no type or storage class
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h:19: parse
error before `identity'
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h:19:
warning: type defaults to `int' in declaration of `identity'
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h:19:
warning: data definition has no type or storage class
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h:20: parse
error before `}'
ipmi_watchdog.c:452: variable `ident' has initializer but incomplete
type
ipmi_watchdog.c:454: warning: excess elements in struct initializer
ipmi_watchdog.c:454: warning: (near initialization for `ident')
ipmi_watchdog.c:455: warning: excess elements in struct initializer
ipmi_watchdog.c:455: warning: (near initialization for `ident')
ipmi_watchdog.c:457: warning: excess elements in struct initializer
ipmi_watchdog.c:457: warning: (near initialization for `ident')
ipmi_watchdog.c: In function `ipmi_ioctl':
ipmi_watchdog.c:466: sizeof applied to an incomplete type
ipmi_watchdog.c:467: sizeof applied to an incomplete type
ipmi_watchdog.c:467: sizeof applied to an incomplete type
ipmi_watchdog.c:467: sizeof applied to an incomplete type
make[3]: *** [ipmi_watchdog.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/drivers/char/ipmi'

I included types.h in watchdog.h.

4) drivers/ieee1394: same failure as before
gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=sbp2  -c -o sbp2.o
sbp2.c
sbp2.c:1515: conflicting types for `sbp2_handle_physdma_write'
sbp2.h:508: previous declaration of `sbp2_handle_physdma_write'
sbp2.c:1531: conflicting types for `sbp2_handle_physdma_read'
sbp2.h:510: previous declaration of `sbp2_handle_physdma_read'
make[2]: *** [sbp2.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/drivers/ieee1394'

5) Finally, the following unresolved were present. I left it alone.
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre4-aa2/kernel/drivers/char/ipmi/ipmi_msghandler.o
depmod:         panic_notifier_list
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre4-aa2/kernel/drivers/char/ipmi/ipmi_watchdog.o
depmod:         panic_notifier_list
depmod:         panic_timeout
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre4-aa2/kernel/fs/xfs/xfs.o
depmod:         start_aggressive_readahead

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------560D13F7094A0DA43C4699D1
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre4-aa2-Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre4-aa2-Makefile.patch"

--- linux/Makefile.orig	Sat Feb 15 11:01:38 2003
+++ linux/Makefile	Sat Feb 15 10:50:27 2003
@@ -97,7 +97,7 @@
 CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  -fno-strict-aliasing -fno-common -finline-limit=2000
+	  -fno-strict-aliasing -fno-common
 ifndef CONFIG_FRAME_POINTER
 CFLAGS += -fomit-frame-pointer
 endif

--------------560D13F7094A0DA43C4699D1
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre4-aa2-char.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre4-aa2-char.patch"

--- linux/drivers/char/Makefile.orig	Tue Jan  7 20:13:30 2003
+++ linux/drivers/char/Makefile	Tue Jan  7 20:17:16 2003
@@ -24,7 +24,7 @@
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
 			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
-			au1000_gpio.o hp_psaux.o nvram.o
+			au1000_gpio.o hp_psaux.o nvram.o scx200.o
 
 mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
 

--------------560D13F7094A0DA43C4699D1
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre4-aa2-watchdog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre4-aa2-watchdog.patch"

--- /data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h.orig	Sat Feb 15 11:08:18 2003
+++ /data2/usr/local/src/linux-2.4-pre-aa/include/linux/watchdog.h	Sat Feb 15 11:08:30 2003
@@ -10,6 +10,7 @@
 #define _LINUX_WATCHDOG_H
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 

--------------560D13F7094A0DA43C4699D1
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre4-sbp2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre4-sbp2.patch"

--- linux/drivers/ieee1394/sbp2.c.orig	Thu Dec 19 10:22:33 2002
+++ linux/drivers/ieee1394/sbp2.c	Thu Dec 19 10:23:17 2002
@@ -1511,7 +1511,7 @@
  * physical dma in hardware). Mostly just here for debugging...
  */
 static int sbp2_handle_physdma_write(struct hpsb_host *host, int nodeid, int destid, quadlet_t *data,
-                                     u64 addr, unsigned int length)
+                                     u64 addr, unsigned int length, u16 flags)
 {
 
         /*
@@ -1527,7 +1527,7 @@
  * physical dma in hardware). Mostly just here for debugging...
  */
 static int sbp2_handle_physdma_read(struct hpsb_host *host, int nodeid, quadlet_t *data,
-                                    u64 addr, unsigned int length)
+                                    u64 addr, unsigned int length, u16 flags)
 {
 
         /*

--------------560D13F7094A0DA43C4699D1--

