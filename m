Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSG1Jvc>; Sun, 28 Jul 2002 05:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSG1Jvc>; Sun, 28 Jul 2002 05:51:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11019 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315463AbSG1Jv3>; Sun, 28 Jul 2002 05:51:29 -0400
Date: Sun, 28 Jul 2002 10:54:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Serial driver include cleanup
Message-ID: <20020728105445.D12389@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can folk please test the following patch on their favourite architectures
to make sure core.c and 8250*.c still build?  I've ripped out a fair
number of includes which aren't needed or are included via some other
path (thanks, Al).  I'm planning to push this to Linus in the next
couple of days.

Thanks.

Index: linux/drivers/serial/21285.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/21285.c,v
retrieving revision 1.36
diff -u -r1.36 21285.c
--- linux/drivers/serial/21285.c	27 Jul 2002 12:45:43 -0000	1.36
+++ linux/drivers/serial/21285.c	28 Jul 2002 09:51:20 -0000
@@ -9,25 +9,15 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial.h>
-#include <linux/major.h>
-#include <linux/ptrace.h>
 #include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/serial_core.h>
+#include <linux/serial.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
 #include <asm/hardware/dec21285.h>
 #include <asm/hardware.h>
 
Index: linux/drivers/serial/8250.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/8250.c,v
retrieving revision 1.89
diff -u -r1.89 8250.c
--- linux/drivers/serial/8250.c	27 Jul 2002 12:47:59 -0000	1.89
+++ linux/drivers/serial/8250.c	28 Jul 2002 09:51:20 -0000
@@ -25,29 +25,17 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/major.h>
-#include <linux/slab.h>
-#include <linux/ptrace.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
-#include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
 #include <linux/serialP.h>
 #include <linux/delay.h>
-#include <linux/kmod.h>
 
-#include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/bitops.h>
 
 #if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
Index: linux/drivers/serial/8250_pci.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/8250_pci.c,v
retrieving revision 1.20
diff -u -r1.20 8250_pci.c
--- linux/drivers/serial/8250_pci.c	26 Jul 2002 10:27:35 -0000	1.20
+++ linux/drivers/serial/8250_pci.c	28 Jul 2002 09:51:20 -0000
@@ -30,6 +30,7 @@
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/serial.h>
+#include <asm/io.h>
 
 #include "8250.h"
 
Index: linux/drivers/serial/amba.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/amba.c,v
retrieving revision 1.40
diff -u -r1.40 amba.c
--- linux/drivers/serial/amba.c	27 Jul 2002 12:47:59 -0000	1.40
+++ linux/drivers/serial/amba.c	28 Jul 2002 09:51:20 -0000
@@ -33,30 +33,15 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
 #include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/circ_buf.h>
 #include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 
-#include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/bitops.h>
 
 #if defined(CONFIG_SERIAL_AMBA_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
Index: linux/drivers/serial/anakin.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/anakin.c,v
retrieving revision 1.31
diff -u -r1.31 anakin.c
--- linux/drivers/serial/anakin.c	27 Jul 2002 12:45:44 -0000	1.31
+++ linux/drivers/serial/anakin.c	28 Jul 2002 09:51:20 -0000
@@ -24,30 +24,15 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
 #include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/circ_buf.h>
 #include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 
-#include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/bitops.h>
 
 #include <linux/serial_core.h>
 
Index: linux/drivers/serial/clps711x.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/clps711x.c,v
retrieving revision 1.41
diff -u -r1.41 clps711x.c
--- linux/drivers/serial/clps711x.c	26 Jul 2002 10:27:35 -0000	1.41
+++ linux/drivers/serial/clps711x.c	28 Jul 2002 09:51:20 -0000
@@ -27,32 +27,17 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
 #include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/circ_buf.h>
 #include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/spinlock.h>
 
-#include <asm/bitops.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
 
 #if defined(CONFIG_SERIAL_CLPS711X_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
Index: linux/drivers/serial/core.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/core.c,v
retrieving revision 1.99
diff -u -r1.99 core.c
--- linux/drivers/serial/core.c	27 Jul 2002 12:47:59 -0000	1.99
+++ linux/drivers/serial/core.c	28 Jul 2002 09:51:20 -0000
@@ -27,33 +27,17 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/circ_buf.h>
 #include <linux/console.h>
-#include <linux/sysrq.h>
 #include <linux/pm.h>
 #include <linux/serial_core.h>
 #include <linux/smp_lock.h>
 #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
 
-#include <asm/system.h>
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
-#include <asm/bitops.h>
 
 #undef	DEBUG
 #ifdef DEBUG
Index: linux/drivers/serial/sa1100.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/sa1100.c,v
retrieving revision 1.48
diff -u -r1.48 sa1100.c
--- linux/drivers/serial/sa1100.c	27 Jul 2002 12:49:30 -0000	1.48
+++ linux/drivers/serial/sa1100.c	28 Jul 2002 09:51:20 -0000
@@ -26,30 +26,15 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
 #include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/circ_buf.h>
 #include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 
-#include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/bitops.h>
 #include <asm/hardware.h>
 #include <asm/mach/serial_sa1100.h>
 
Index: linux/drivers/serial/uart00.c
===================================================================
RCS file: /mnt/src/cvsroot/serial/linux/drivers/serial/uart00.c,v
retrieving revision 1.34
diff -u -r1.34 uart00.c
--- linux/drivers/serial/uart00.c	26 Jul 2002 10:27:35 -0000	1.34
+++ linux/drivers/serial/uart00.c	28 Jul 2002 09:51:20 -0000
@@ -26,31 +26,16 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
 #include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/circ_buf.h>
 #include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/pld/pld_hotswap.h>
 
-#include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/bitops.h>
 #include <asm/sizes.h>
 
 #if defined(CONFIG_SERIAL_UART00_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

