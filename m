Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSESWdG>; Sun, 19 May 2002 18:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315469AbSESWdF>; Sun, 19 May 2002 18:33:05 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:57860 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S315456AbSESWdD>; Sun, 19 May 2002 18:33:03 -0400
Date: Mon, 20 May 2002 00:33:02 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Dave Jones <davej@suse.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move jiffies from sched.h to it's own jiffies.h
In-Reply-To: <Pine.LNX.4.33.0205181407370.21904-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0205200025120.787-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As a start I made a patch that moves 'jiffies' from sched.h to their
> own header.
> That allowed me to pull the sched.h dependency from 40 files that
> included sched.h for no apparent reason other than the jiffies 
> declaration (though I might have missed obscure dependencies for 
> drivers/architectures I didn't compile).
> 

In the meantime I've identified 27 more files that #include sched.h only 
for the sake of jiffies. Patch applies on top of the previous one.

Many more sched.h dependencies can be pulled if capable(), request_irq()
and free_irq() are moved out of sched.h.
Any reasons why capable() isn't in <linux/capability.h> ?

Tim


--- linux-2.5.16/arch/ia64/sn/kernel/mca.c	Fri May 10 00:22:37 2002
+++ linux-2.5.16-jc/arch/ia64/sn/kernel/mca.c	Sun May 19 23:48:24 2002
@@ -35,7 +35,7 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/threads.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>

--- linux-2.5.16/arch/m68k/apollo/dn_ints.c	Fri May 10 00:25:16 2002
+++ linux-2.5.16-jc/arch/m68k/apollo/dn_ints.c	Sun May 19 23:49:10 2002
@@ -1,6 +1,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/kernel_stat.h>
 
 #include <asm/system.h>

--- linux-2.5.16/arch/ppc/kernel/temp.c	Fri May 10 00:21:30 2002
+++ linux-2.5.16-jc/arch/ppc/kernel/temp.c	Sun May 19 23:49:50 2002
@@ -13,7 +13,7 @@
 
 #include <linux/config.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/param.h>
 #include <linux/string.h>

--- linux-2.5.16/drivers/char/drm/drmP.h	Fri May 10 00:25:24 2002
+++ linux-2.5.16-jc/drivers/char/drm/drmP.h	Mon May 20 00:00:47 2002
@@ -50,7 +50,7 @@
 #include <linux/pci.h>
 #include <linux/wrapper.h>
 #include <linux/version.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/smp_lock.h>	/* For (un)lock_kernel */
 #include <linux/mm.h>
 #if defined(__alpha__) || defined(__powerpc__)

--- linux-2.5.16/drivers/char/machzwd.c	Fri May 10 00:22:39 2002
+++ linux-2.5.16-jc/drivers/char/machzwd.c	Sun May 19 23:32:59 2002
@@ -35,7 +35,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/timer.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/slab.h>

--- linux-2.5.16/drivers/char/sbc60xxwdt.c	Fri May 10 00:22:03 2002
+++ linux-2.5.16-jc/drivers/char/sbc60xxwdt.c	Sun May 19 23:33:31 2002
@@ -61,7 +61,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/timer.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/slab.h>

--- linux-2.5.16/drivers/char/w83877f_wdt.c	Fri May 10 00:21:48 2002
+++ linux-2.5.16-jc/drivers/char/w83877f_wdt.c	Sun May 19 23:34:04 2002
@@ -46,7 +46,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/timer.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/slab.h>

--- linux-2.5.16/drivers/fc4/fc.c	Fri May 10 00:24:58 2002
+++ linux-2.5.16-jc/drivers/fc4/fc.c	Sun May 19 23:50:39 2002
@@ -23,7 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>

--- linux-2.5.16/drivers/ide/ide-pmac.c	Mon May 20 00:07:27 2002
+++ linux-2.5.16-jc/drivers/ide/ide-pmac.c	Sun May 19 23:34:59 2002
@@ -33,7 +33,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/ide.h>

--- linux-2.5.16/drivers/message/i2o/i2o_scsi.c	Fri May 10 00:22:52 2002
+++ linux-2.5.16-jc/drivers/message/i2o/i2o_scsi.c	Sun May 19 23:36:19 2002
@@ -38,7 +38,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/delay.h>

--- linux-2.5.16/drivers/mtd/ftl.c	Fri May 10 00:23:06 2002
+++ linux-2.5.16-jc/drivers/mtd/ftl.c	Sun May 19 23:51:25 2002
@@ -61,7 +61,7 @@
 /*#define PSYCHO_DEBUG */
 
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/string.h>

--- linux-2.5.16/drivers/net/8390.c	Fri May 10 00:21:56 2002
+++ linux-2.5.16-jc/drivers/net/8390.c	Sun May 19 23:36:56 2002
@@ -52,7 +52,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>

--- linux-2.5.16/drivers/net/atari_pamsnet.c	Fri May 10 00:23:33 2002
+++ linux-2.5.16-jc/drivers/net/atari_pamsnet.c	Sun May 19 23:37:27 2002
@@ -80,7 +80,7 @@
 #include <linux/module.h>
 
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>

--- linux-2.5.16/drivers/net/wan/hd6457x.c	Fri May 10 00:22:46 2002
+++ linux-2.5.16-jc/drivers/net/wan/hd6457x.c	Sun May 19 23:39:09 2002
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>

--- linux-2.5.16/drivers/usb/host/usb-uhci-hcd.c	Mon May 20 00:07:28 2002
+++ linux-2.5.16-jc/drivers/usb/host/usb-uhci-hcd.c	Sun May 19 23:41:25 2002
@@ -22,7 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/errno.h>

--- linux-2.5.16/drivers/usb/storage/sddr55.c	Mon May 20 00:07:28 2002
+++ linux-2.5.16-jc/drivers/usb/storage/sddr55.c	Sun May 19 23:43:19 2002
@@ -30,7 +30,7 @@
 #include "debug.h"
 #include "sddr55.h"
 
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 

--- linux-2.5.16/net/ipv4/fib_semantics.c	Fri May 10 00:22:36 2002
+++ linux-2.5.16-jc/net/ipv4/fib_semantics.c	Sun May 19 23:56:14 2002
@@ -21,7 +21,7 @@
 #include <asm/bitops.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/socket.h>

--- linux-2.5.16/net/ipv4/igmp.c	Fri May 10 00:25:41 2002
+++ linux-2.5.16-jc/net/ipv4/igmp.c	Mon May 20 00:04:12 2002
@@ -76,7 +76,7 @@
 #include <asm/system.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/socket.h>
 #include <linux/sockios.h>

--- linux-2.5.16/net/ipv4/ipconfig.c	Fri May 10 00:21:43 2002
+++ linux-2.5.16-jc/net/ipv4/ipconfig.c	Sun May 19 23:45:06 2002
@@ -32,7 +32,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/random.h>
 #include <linux/init.h>
 #include <linux/utsname.h>

--- linux-2.5.16/net/ipv6/mcast.c	Fri May 10 00:23:21 2002
+++ linux-2.5.16-jc/net/ipv6/mcast.c	Sun May 19 23:56:40 2002
@@ -28,7 +28,7 @@
 #include <linux/string.h>
 #include <linux/socket.h>
 #include <linux/sockios.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/net.h>
 #include <linux/in6.h>
 #include <linux/netdevice.h>

--- linux-2.5.16/net/ipv6/tcp_ipv6.c	Fri May 10 00:24:57 2002
+++ linux-2.5.16-jc/net/ipv6/tcp_ipv6.c	Sun May 19 23:57:10 2002
@@ -29,7 +29,7 @@
 #include <linux/socket.h>
 #include <linux/sockios.h>
 #include <linux/net.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/netdevice.h>

--- linux-2.5.16/net/sched/estimator.c	Fri May 10 00:21:55 2002
+++ linux-2.5.16-jc/net/sched/estimator.c	Sun May 19 23:45:47 2002
@@ -14,7 +14,7 @@
 #include <asm/bitops.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/socket.h>

--- linux-2.5.16/net/sched/sch_csz.c	Fri May 10 00:24:58 2002
+++ linux-2.5.16-jc/net/sched/sch_csz.c	Mon May 20 00:05:03 2002
@@ -17,7 +17,7 @@
 #include <asm/bitops.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/socket.h>

--- linux-2.5.16/net/sched/sch_sfq.c	Fri May 10 00:23:52 2002
+++ linux-2.5.16-jc/net/sched/sch_sfq.c	Sun May 19 23:46:11 2002
@@ -16,7 +16,7 @@
 #include <asm/bitops.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/socket.h>

--- linux-2.5.16/net/sched/sch_tbf.c	Fri May 10 00:21:45 2002
+++ linux-2.5.16-jc/net/sched/sch_tbf.c	Sun May 19 23:46:32 2002
@@ -17,7 +17,7 @@
 #include <asm/bitops.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/socket.h>

--- linux-2.5.16/net/x25/x25_timer.c	Fri May 10 00:21:50 2002
+++ linux-2.5.16-jc/net/x25/x25_timer.c	Sun May 19 23:57:39 2002
@@ -23,7 +23,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/sound/oss/emu10k1/cardmi.c	Fri May 10 00:24:51 2002
+++ linux-2.5.16-jc/sound/oss/emu10k1/cardmi.c	Sun May 19 23:47:25 2002
@@ -31,7 +31,7 @@
  */
 
 #include <linux/slab.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 
 #include "hwaccess.h"
 #include "8010.h"

