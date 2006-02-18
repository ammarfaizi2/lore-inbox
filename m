Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWBRO6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWBRO6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWBRO6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:58:49 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:41409 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751336AbWBRO6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:58:48 -0500
Date: Sat, 18 Feb 2006 15:58:47 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Bastian Blank <bastian@waldi.eu.org>,
       Arthur Othieno <apgo@patchbomb.org>, Jean Delvare <khali@linux-fr.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH/RFC] remove duplicate #includes, take II, part B
Message-ID: <20060218145847.GC32618@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Bastian Blank <bastian@waldi.eu.org>,
	Arthur Othieno <apgo@patchbomb.org>,
	Jean Delvare <khali@linux-fr.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20060218145525.GA32618@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218145525.GA32618@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


problematic hunks

---

diff -NurpP linux-2.6.16-rc4/arch/h8300/kernel/gpio.c linux-2.6.16-rc4-rmd/arch/h8300/kernel/gpio.c
--- linux-2.6.16-rc4/arch/h8300/kernel/gpio.c	2006-02-18 14:39:42 +0100
+++ linux-2.6.16-rc4-rmd/arch/h8300/kernel/gpio.c	2006-02-18 15:30:15 +0100
@@ -29,7 +29,6 @@ static volatile unsigned char *ddrs[] = 
 
  #if defined(CONFIG_H83002) || defined(CONFIG_H8048)
 /* Fix me!! */
-#include <asm/regs306x.h>
 static volatile unsigned char *ddrs[] = {
 	_(P1DDR),_(P2DDR),_(P3DDR),_(P4DDR),_(P5DDR),_(P6DDR),
 	NULL,    _(P8DDR),_(P9DDR),_(PADDR),_(PBDDR),
diff -NurpP linux-2.6.16-rc4/arch/mips/mips-boards/generic/time.c linux-2.6.16-rc4-rmd/arch/mips/mips-boards/generic/time.c
--- linux-2.6.16-rc4/arch/mips/mips-boards/generic/time.c	2006-02-18 14:39:45 +0100
+++ linux-2.6.16-rc4-rmd/arch/mips/mips-boards/generic/time.c	2006-02-18 15:30:09 +0100
@@ -42,7 +42,6 @@
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/prom.h>
 #include <asm/mips-boards/maltaint.h>
-#include <asm/mc146818-time.h>
 
 unsigned long cpu_khz;
 
diff -NurpP linux-2.6.16-rc4/arch/mips/sibyte/bcm1480/time.c linux-2.6.16-rc4-rmd/arch/mips/sibyte/bcm1480/time.c
--- linux-2.6.16-rc4/arch/mips/sibyte/bcm1480/time.c	2006-01-03 17:29:12 +0100
+++ linux-2.6.16-rc4-rmd/arch/mips/sibyte/bcm1480/time.c	2006-02-18 15:30:16 +0100
@@ -99,7 +99,6 @@ void bcm1480_time_init(void)
 	 */
 }
 
-#include <asm/sibyte/sb1250.h>
 
 void bcm1480_timer_interrupt(struct pt_regs *regs)
 {
diff -NurpP linux-2.6.16-rc4/arch/powerpc/kernel/signal_32.c linux-2.6.16-rc4-rmd/arch/powerpc/kernel/signal_32.c
--- linux-2.6.16-rc4/arch/powerpc/kernel/signal_32.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/kernel/signal_32.c	2006-02-18 15:30:10 +0100
@@ -32,7 +32,6 @@
 #include <linux/ptrace.h>
 #else
 #include <linux/wait.h>
-#include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/platforms/powermac/setup.c linux-2.6.16-rc4-rmd/arch/powerpc/platforms/powermac/setup.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/powermac/setup.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/platforms/powermac/setup.c	2006-02-18 15:30:15 +0100
@@ -96,7 +96,6 @@ extern struct machdep_calls pmac_md;
 #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
 
 #ifdef CONFIG_PPC64
-#include <asm/udbg.h>
 int sccdbg;
 #endif
 
diff -NurpP linux-2.6.16-rc4/arch/ppc/syslib/ppc83xx_setup.c linux-2.6.16-rc4-rmd/arch/ppc/syslib/ppc83xx_setup.c
--- linux-2.6.16-rc4/arch/ppc/syslib/ppc83xx_setup.c	2006-02-18 14:39:47 +0100
+++ linux-2.6.16-rc4-rmd/arch/ppc/syslib/ppc83xx_setup.c	2006-02-18 15:30:09 +0100
@@ -44,7 +44,6 @@
 
 #include <syslib/ppc83xx_setup.h>
 #if defined(CONFIG_PCI)
-#include <asm/delay.h>
 #include <syslib/ppc83xx_pci.h>
 #endif
 
diff -NurpP linux-2.6.16-rc4/arch/sh64/kernel/process.c linux-2.6.16-rc4-rmd/arch/sh64/kernel/process.c
--- linux-2.6.16-rc4/arch/sh64/kernel/process.c	2006-02-18 14:39:48 +0100
+++ linux-2.6.16-rc4-rmd/arch/sh64/kernel/process.c	2006-02-18 15:30:09 +0100
@@ -897,7 +897,6 @@ unsigned long get_wchan(struct task_stru
    */
 
 #if defined(CONFIG_SH64_PROC_ASIDS)
-#include <linux/init.h>
 #include <linux/proc_fs.h>
 
 static int
diff -NurpP linux-2.6.16-rc4/arch/sh64/kernel/setup.c linux-2.6.16-rc4-rmd/arch/sh64/kernel/setup.c
--- linux-2.6.16-rc4/arch/sh64/kernel/setup.c	2005-06-22 02:37:59 +0200
+++ linux-2.6.16-rc4-rmd/arch/sh64/kernel/setup.c	2006-02-18 15:30:09 +0100
@@ -60,7 +60,6 @@
 #include <asm/smp.h>
 
 #ifdef CONFIG_VT
-#include <linux/console.h>
 #endif
 
 struct screen_info screen_info;
diff -NurpP linux-2.6.16-rc4/drivers/char/drm/drm.h linux-2.6.16-rc4-rmd/drivers/char/drm/drm.h
--- linux-2.6.16-rc4/drivers/char/drm/drm.h	2006-02-18 14:39:53 +0100
+++ linux-2.6.16-rc4-rmd/drivers/char/drm/drm.h	2006-02-18 15:30:15 +0100
@@ -54,7 +54,6 @@
 #include <sys/ioccom.h>
 #define ioctl(a,b,c)		xf86ioctl(a,b,c)
 #else
-#include <sys/ioccom.h>
 #endif				/* __FreeBSD__ && xf86ioctl */
 #define DRM_IOCTL_NR(n)		((n) & 0xff)
 #define DRM_IOC_VOID		IOC_VOID
diff -NurpP linux-2.6.16-rc4/drivers/input/serio/i8042-io.h linux-2.6.16-rc4-rmd/drivers/input/serio/i8042-io.h
--- linux-2.6.16-rc4/drivers/input/serio/i8042-io.h	2005-10-28 20:49:23 +0200
+++ linux-2.6.16-rc4-rmd/drivers/input/serio/i8042-io.h	2006-02-18 15:30:10 +0100
@@ -26,7 +26,6 @@
 /* defined in include/asm-arm/arch-xxx/irqs.h */
 #include <asm/irq.h>
 #elif defined(CONFIG_SUPERH64)
-#include <asm/irq.h>
 #else
 # define I8042_KBD_IRQ	1
 # define I8042_AUX_IRQ	12
diff -NurpP linux-2.6.16-rc4/drivers/media/video/zr36016.c linux-2.6.16-rc4-rmd/drivers/media/video/zr36016.c
--- linux-2.6.16-rc4/drivers/media/video/zr36016.c	2006-02-18 14:40:01 +0100
+++ linux-2.6.16-rc4-rmd/drivers/media/video/zr36016.c	2006-02-18 15:30:09 +0100
@@ -42,7 +42,6 @@
 //#include<errno.h>
 
 /* v4l  API */
-#include<linux/videodev.h>
 
 /* headerfile of this module */
 #include"zr36016.h"
diff -NurpP linux-2.6.16-rc4/drivers/net/cs89x0.c linux-2.6.16-rc4-rmd/drivers/net/cs89x0.c
--- linux-2.6.16-rc4/drivers/net/cs89x0.c	2006-02-18 14:40:02 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/cs89x0.c	2006-02-18 15:30:09 +0100
@@ -189,7 +189,6 @@ static unsigned int cs8900_irq_map[] = {
 static unsigned int netcard_portlist[] __initdata = {IXDP2X01_CS8900_VIRT_BASE, 0};
 static unsigned int cs8900_irq_map[] = {IRQ_IXDP2X01_CS8900, 0, 0, 0};
 #elif defined(CONFIG_ARCH_PNX010X)
-#include <asm/irq.h>
 #include <asm/arch/gpio.h>
 #define CIRRUS_DEFAULT_BASE	IO_ADDRESS(EXT_STATIC2_s0_BASE + 0x200000)	/* = Physical address 0x48200000 */
 #define CIRRUS_DEFAULT_IRQ	VH_INTC_INT_NUM_CASCADED_INTERRUPT_1 /* Event inputs bank 1 - ID 35/bit 3 */
diff -NurpP linux-2.6.16-rc4/drivers/video/fbmon.c linux-2.6.16-rc4-rmd/drivers/video/fbmon.c
--- linux-2.6.16-rc4/drivers/video/fbmon.c	2006-02-18 14:40:20 +0100
+++ linux-2.6.16-rc4-rmd/drivers/video/fbmon.c	2006-02-18 15:30:09 +0100
@@ -1282,7 +1282,6 @@ int fb_validate_mode(const struct fb_var
 }
 
 #if defined(__i386__)
-#include <linux/pci.h>
 
 /*
  * We need to ensure that the EDID block is only returned for
diff -NurpP linux-2.6.16-rc4/include/asm-arm/arch-clps711x/hardware.h linux-2.6.16-rc4-rmd/include/asm-arm/arch-clps711x/hardware.h
--- linux-2.6.16-rc4/include/asm-arm/arch-clps711x/hardware.h	2004-08-14 12:55:32 +0200
+++ linux-2.6.16-rc4-rmd/include/asm-arm/arch-clps711x/hardware.h	2006-02-18 15:30:15 +0100
@@ -180,7 +180,6 @@
 #define  CEIVA_BASE		CLPS7111_VIRT_BASE
 
 #include <asm/hardware/clps7111.h>
-#include <asm/hardware/ep7212.h>
 
 
 /*
diff -NurpP linux-2.6.16-rc4/include/asm-arm26/signal.h linux-2.6.16-rc4-rmd/include/asm-arm26/signal.h
--- linux-2.6.16-rc4/include/asm-arm26/signal.h	2005-06-22 02:38:42 +0200
+++ linux-2.6.16-rc4-rmd/include/asm-arm26/signal.h	2006-02-18 15:30:15 +0100
@@ -170,7 +170,6 @@ typedef struct sigaltstack {
 
 
 #ifdef __KERNEL__
-#include <asm/sigcontext.h>
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
 #endif
 
diff -NurpP linux-2.6.16-rc4/include/asm-m32r/m32r.h linux-2.6.16-rc4-rmd/include/asm-m32r/m32r.h
--- linux-2.6.16-rc4/include/asm-m32r/m32r.h	2006-02-18 14:40:30 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-m32r/m32r.h	2006-02-18 15:30:09 +0100
@@ -40,7 +40,6 @@
 #endif	/* CONFIG_PLAT_MAPPI3 */
 
 #if defined(CONFIG_PLAT_USRV)
-#include <asm/m32700ut/m32700ut_pld.h>
 #endif
 
 #if defined(CONFIG_PLAT_M32104UT)
diff -NurpP linux-2.6.16-rc4/include/asm-ia64/unistd.h linux-2.6.16-rc4-rmd/include/asm-ia64/unistd.h
--- linux-2.6.16-rc4/include/asm-ia64/unistd.h	2006-02-18 14:40:29 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-ia64/unistd.h	2006-02-18 15:30:15 +0100
@@ -316,7 +316,6 @@ extern long __ia64_syscall (long a0, lon
 
 #ifdef __KERNEL_SYSCALLS__
 
-#include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/signal.h>
 #include <asm/ptrace.h>
diff -NurpP linux-2.6.16-rc4/include/asm-m32r/mmu_context.h linux-2.6.16-rc4-rmd/include/asm-m32r/mmu_context.h
--- linux-2.6.16-rc4/include/asm-m32r/mmu_context.h	2005-03-02 12:38:50 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-m32r/mmu_context.h	2006-02-18 15:30:16 +0100
@@ -15,7 +15,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/config.h>
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu.h>
diff -NurpP linux-2.6.16-rc4/include/asm-mips/serial.h linux-2.6.16-rc4-rmd/include/asm-mips/serial.h
--- linux-2.6.16-rc4/include/asm-mips/serial.h	2006-01-03 17:30:06 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-mips/serial.h	2006-02-18 15:30:09 +0100
@@ -91,7 +91,6 @@
 #endif
 
 #ifdef CONFIG_MIPS_IVR
-#include <asm/it8172/it8172.h>
 #include <asm/it8172/it8172_int.h>
 #define IVR_SERIAL_PORT_DEFNS                                  \
     { .baud_base = BASE_BAUD, .port = (IT8172_PCI_IO_BASE + IT_UART_BASE), \
diff -NurpP linux-2.6.16-rc4/include/asm-x86_64/smp.h linux-2.6.16-rc4-rmd/include/asm-x86_64/smp.h
--- linux-2.6.16-rc4/include/asm-x86_64/smp.h	2006-02-18 14:40:32 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-x86_64/smp.h	2006-02-18 15:30:09 +0100
@@ -120,7 +120,6 @@ static inline int cpu_present_to_apicid(
 #define safe_smp_processor_id() 0
 #define cpu_logical_map(x) (x)
 #else
-#include <asm/thread_info.h>
 #define stack_smp_processor_id() \
 ({ 								\
 	struct thread_info *ti;					\
diff -NurpP linux-2.6.16-rc4/include/linux/aio.h linux-2.6.16-rc4-rmd/include/linux/aio.h
--- linux-2.6.16-rc4/include/linux/aio.h	2006-02-18 14:40:32 +0100
+++ linux-2.6.16-rc4-rmd/include/linux/aio.h	2006-02-18 15:30:09 +0100
@@ -236,7 +236,6 @@ do {									\
 #define io_wait_to_kiocb(wait) container_of(wait, struct kiocb, ki_wait)
 #define is_retried_kiocb(iocb) ((iocb)->ki_retried > 1)
 
-#include <linux/aio_abi.h>
 
 static inline struct kiocb *list_kiocb(struct list_head *h)
 {
diff -NurpP linux-2.6.16-rc4/include/linux/udp.h linux-2.6.16-rc4-rmd/include/linux/udp.h
--- linux-2.6.16-rc4/include/linux/udp.h	2006-02-18 14:40:35 +0100
+++ linux-2.6.16-rc4-rmd/include/linux/udp.h	2006-02-18 15:30:10 +0100
@@ -36,7 +36,6 @@ struct udphdr {
 
 #ifdef __KERNEL__
 #include <linux/config.h>
-#include <linux/types.h>
 
 #include <net/inet_sock.h>
 

