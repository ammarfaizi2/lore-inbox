Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266682AbUHSQyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUHSQyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUHSQyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:54:15 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:10698 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266682AbUHSQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:52:22 -0400
Date: Thu, 19 Aug 2004 17:50:14 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: includes cleanup.
Message-ID: <20040819165014.GE4148@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819154900.A10013@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819154900.A10013@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 03:49:00PM +0100, Christoph Hellwig wrote:
 > On Thu, Aug 19, 2004 at 03:39:07PM +0100, Dave Jones wrote:
 > > - split out the wake_up_* stuff to linux/wakeup.h
 > 
 > linux/wait.h sounds like a better choice because the other half of the
 > waitqueue operations are over there..

here's the fixed up version.  Still x86 only.

		Dave


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c sched/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- bk-linus/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-06-15 15:51:50.000000000 +0100
+++ sched/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-08-19 15:08:22.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/cpumask.h>
+#include <linux/sched.h>	/* current / set_cpus_allowed() */
 
 #include <asm/processor.h> 
 #include <asm/msr.h>
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/cpufreq/powernow-k8.c sched/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- bk-linus/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-06-15 15:51:50.000000000 +0100
+++ sched/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-08-19 15:08:22.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/sched.h>	/* for current / set_cpus_allowed() */
 
 #include <asm/msr.h>
 #include <asm/io.h>
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mtrr/if.c sched/arch/i386/kernel/cpu/mtrr/if.c
--- bk-linus/arch/i386/kernel/cpu/mtrr/if.c	2004-08-09 13:12:15.000000000 +0100
+++ sched/arch/i386/kernel/cpu/mtrr/if.c	2004-08-19 15:08:22.000000000 +0100
@@ -3,6 +3,7 @@
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/capability.h>
 #include <asm/uaccess.h>
 
 #define LINE_SIZE 80
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/paride/paride.c sched/drivers/block/paride/paride.c
--- bk-linus/drivers/block/paride/paride.c	2004-07-13 00:00:46.000000000 +0100
+++ sched/drivers/block/paride/paride.c	2004-08-19 15:08:36.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/sched.h>	/* TASK_* */
 
 #ifdef CONFIG_PARPORT_MODULE
 #define CONFIG_PARPORT
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/paride/pg.c sched/drivers/block/paride/pg.c
--- bk-linus/drivers/block/paride/pg.c	2004-06-04 12:08:32.000000000 +0100
+++ sched/drivers/block/paride/pg.c	2004-08-19 15:08:36.000000000 +0100
@@ -162,6 +162,8 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_SLV,
 #include <linux/mtio.h>
 #include <linux/pg.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* current, TASK_* */
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/paride/pt.c sched/drivers/block/paride/pt.c
--- bk-linus/drivers/block/paride/pt.c	2004-06-04 12:08:32.000000000 +0100
+++ sched/drivers/block/paride/pt.c	2004-08-19 15:08:36.000000000 +0100
@@ -146,6 +146,7 @@ static int (*drives[4])[6] = {&drive0, &
 #include <linux/slab.h>
 #include <linux/mtio.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* current, TASK_*, schedule_timeout() */
 
 #include <asm/uaccess.h>
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/i8k.c sched/drivers/char/i8k.c
--- bk-linus/drivers/char/i8k.c	2004-06-05 00:00:30.000000000 +0100
+++ sched/drivers/char/i8k.c	2004-08-19 15:08:38.000000000 +0100
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/apm_bios.h>
+#include <linux/capability.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/watchdog/cpu5wdt.c sched/drivers/char/watchdog/cpu5wdt.c
--- bk-linus/drivers/char/watchdog/cpu5wdt.c	2004-06-19 00:01:32.000000000 +0100
+++ sched/drivers/char/watchdog/cpu5wdt.c	2004-08-19 15:08:39.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/watchdog/mixcomwd.c sched/drivers/char/watchdog/mixcomwd.c
--- bk-linus/drivers/char/watchdog/mixcomwd.c	2004-08-09 13:12:17.000000000 +0100
+++ sched/drivers/char/watchdog/mixcomwd.c	2004-08-19 15:08:39.000000000 +0100
@@ -45,6 +45,8 @@
 #include <linux/fs.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/watchdog/pcwd.c sched/drivers/char/watchdog/pcwd.c
--- bk-linus/drivers/char/watchdog/pcwd.c	2004-08-09 13:12:17.000000000 +0100
+++ sched/drivers/char/watchdog/pcwd.c	2004-08-19 15:08:39.000000000 +0100
@@ -66,7 +66,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
-
+#include <linux/sched.h>	/* TASK_INTERRUPTIBLE, set_current_state() and friends */
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/watchdog/sc520_wdt.c sched/drivers/char/watchdog/sc520_wdt.c
--- bk-linus/drivers/char/watchdog/sc520_wdt.c	2004-08-09 13:12:17.000000000 +0100
+++ sched/drivers/char/watchdog/sc520_wdt.c	2004-08-19 15:08:40.000000000 +0100
@@ -63,6 +63,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/watchdog/softdog.c sched/drivers/char/watchdog/softdog.c
--- bk-linus/drivers/char/watchdog/softdog.c	2004-08-09 13:12:17.000000000 +0100
+++ sched/drivers/char/watchdog/softdog.c	2004-08-19 15:08:40.000000000 +0100
@@ -47,6 +47,8 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+
 #include <asm/uaccess.h>
 
 #define PFX "SoftDog: "
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/a3d.c sched/drivers/input/joystick/a3d.c
--- bk-linus/drivers/input/joystick/a3d.c	2004-06-07 21:13:15.000000000 +0100
+++ sched/drivers/input/joystick/a3d.c	2004-08-19 15:08:43.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("FP-Gaming Assasin 3D joystick driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/adi.c sched/drivers/input/joystick/adi.c
--- bk-linus/drivers/input/joystick/adi.c	2004-06-07 21:13:15.000000000 +0100
+++ sched/drivers/input/joystick/adi.c	2004-08-19 15:08:43.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Logitech ADI joystick family driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/analog.c sched/drivers/input/joystick/analog.c
--- bk-linus/drivers/input/joystick/analog.c	2004-07-28 00:02:33.000000000 +0100
+++ sched/drivers/input/joystick/analog.c	2004-08-19 15:08:43.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 #include <asm/timex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/cobra.c sched/drivers/input/joystick/cobra.c
--- bk-linus/drivers/input/joystick/cobra.c	2004-06-07 21:13:15.000000000 +0100
+++ sched/drivers/input/joystick/cobra.c	2004-08-19 15:08:43.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Creative Labs Blaster GamePad Cobra driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/gf2k.c sched/drivers/input/joystick/gf2k.c
--- bk-linus/drivers/input/joystick/gf2k.c	2004-06-07 21:13:15.000000000 +0100
+++ sched/drivers/input/joystick/gf2k.c	2004-08-19 15:08:43.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Genius Flight 2000 joystick driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/grip.c sched/drivers/input/joystick/grip.c
--- bk-linus/drivers/input/joystick/grip.c	2004-07-13 00:00:46.000000000 +0100
+++ sched/drivers/input/joystick/grip.c	2004-08-19 15:08:43.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Gravis GrIP protocol joystick driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/grip_mp.c sched/drivers/input/joystick/grip_mp.c
--- bk-linus/drivers/input/joystick/grip_mp.c	2004-07-13 00:00:46.000000000 +0100
+++ sched/drivers/input/joystick/grip_mp.c	2004-08-19 15:08:43.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Brian Bonnlander");
 MODULE_DESCRIPTION("Gravis Grip Multiport driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/guillemot.c sched/drivers/input/joystick/guillemot.c
--- bk-linus/drivers/input/joystick/guillemot.c	2004-06-07 21:13:15.000000000 +0100
+++ sched/drivers/input/joystick/guillemot.c	2004-08-19 15:08:43.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Guillemot Digital joystick driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/interact.c sched/drivers/input/joystick/interact.c
--- bk-linus/drivers/input/joystick/interact.c	2004-06-07 21:13:15.000000000 +0100
+++ sched/drivers/input/joystick/interact.c	2004-08-19 15:08:43.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("InterAct digital joystick driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/sidewinder.c sched/drivers/input/joystick/sidewinder.c
--- bk-linus/drivers/input/joystick/sidewinder.c	2004-06-07 21:13:15.000000000 +0100
+++ sched/drivers/input/joystick/sidewinder.c	2004-08-19 15:08:43.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Microsoft SideWinder joystick family driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/joystick/tmdc.c sched/drivers/input/joystick/tmdc.c
--- bk-linus/drivers/input/joystick/tmdc.c	2004-06-07 21:13:15.000000000 +0100
+++ sched/drivers/input/joystick/tmdc.c	2004-08-19 15:08:43.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("ThrustMaster DirectConnect joystick driver");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/isdn/capi/capifs.c sched/drivers/isdn/capi/capifs.c
--- bk-linus/drivers/isdn/capi/capifs.c	2004-06-03 13:39:56.000000000 +0100
+++ sched/drivers/isdn/capi/capifs.c	2004-08-19 15:08:44.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ctype.h>
+#include <linux/sched.h>	/* current */
 
 MODULE_DESCRIPTION("CAPI4Linux: /dev/capi/ filesystem");
 MODULE_AUTHOR("Carsten Paeth");
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/media/radio/miropcm20-rds.c sched/drivers/media/radio/miropcm20-rds.c
--- bk-linus/drivers/media/radio/miropcm20-rds.c	2004-07-13 00:00:46.000000000 +0100
+++ sched/drivers/media/radio/miropcm20-rds.c	2004-08-19 15:08:45.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/sched.h>	/* current, TASK_*, schedule_timeout() */
 #include <asm/uaccess.h>
 #include "miropcm20-rds-core.h"
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/mtdblock.c sched/drivers/mtd/mtdblock.c
--- bk-linus/drivers/mtd/mtdblock.c	2004-07-16 00:00:59.000000000 +0100
+++ sched/drivers/mtd/mtdblock.c	2004-08-19 15:08:46.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/sched.h>	/* TASK_* */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/blktrans.h>
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/mtdchar.c sched/drivers/mtd/mtdchar.c
--- bk-linus/drivers/mtd/mtdchar.c	2004-08-12 00:00:26.000000000 +0100
+++ sched/drivers/mtd/mtdchar.c	2004-08-19 15:08:46.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/sched.h>	/* TASK_* */
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_DEVFS_FS
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/mtdconcat.c sched/drivers/mtd/mtdconcat.c
--- bk-linus/drivers/mtd/mtdconcat.c	2004-07-16 00:00:59.000000000 +0100
+++ sched/drivers/mtd/mtdconcat.c	2004-08-19 15:08:46.000000000 +0100
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-
+#include <linux/sched.h>	/* TASK_* */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/concat.h>
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/w1/w1_family.c sched/drivers/w1/w1_family.c
--- bk-linus/drivers/w1/w1_family.c	2004-07-16 00:03:44.000000000 +0100
+++ sched/drivers/w1/w1_family.c	2004-08-19 15:08:55.000000000 +0100
@@ -21,6 +21,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/sched.h>	/* schedule_timeout() */
 
 #include "w1_family.h"
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/filesystems.c sched/fs/filesystems.c
--- bk-linus/fs/filesystems.c	2004-06-03 13:40:11.000000000 +0100
+++ sched/fs/filesystems.c	2004-08-19 15:08:55.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/sched.h>	/* for 'current' */
 #include <asm/uaccess.h>
 
 /*
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/jffs2/wbuf.c sched/fs/jffs2/wbuf.c
--- bk-linus/fs/jffs2/wbuf.c	2004-07-16 00:00:59.000000000 +0100
+++ sched/fs/jffs2/wbuf.c	2004-08-19 15:08:56.000000000 +0100
@@ -18,6 +18,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/crc32.h>
 #include <linux/mtd/nand.h>
+#include <linux/jiffies.h>
+
 #include "nodelist.h"
 
 /* For testing write failures */
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/capability.h sched/include/linux/capability.h
--- bk-linus/include/linux/capability.h	2004-06-03 13:40:23.000000000 +0100
+++ sched/include/linux/capability.h	2004-08-19 15:09:05.000000000 +0100
@@ -353,6 +353,21 @@ static inline kernel_cap_t cap_invert(ke
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
 
+#ifdef CONFIG_SECURITY
+/* code is in security.c */
+extern int capable(int cap);
+#else
+static inline int capable(int cap)
+{
+	if (cap_raised(current->cap_effective, cap)) {
+		current->flags |= PF_SUPERPRIV;
+		return 1;
+	}
+	return 0;
+}
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* !_LINUX_CAPABILITY_H */
+
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/i2c.h sched/include/linux/i2c.h
--- bk-linus/include/linux/i2c.h	2004-06-03 13:40:24.000000000 +0100
+++ sched/include/linux/i2c.h	2004-08-19 15:09:05.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
+#include <linux/sched.h>	/* for completion */
 #include <asm/semaphore.h>
 
 /* --- General options ------------------------------------------------	*/
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/module.h sched/include/linux/module.h
--- bk-linus/include/linux/module.h	2004-06-28 00:00:52.000000000 +0100
+++ sched/include/linux/module.h	2004-08-19 16:31:02.000000000 +0100
@@ -7,7 +7,6 @@
  * Rewritten again by Rusty Russell, 2002
  */
 #include <linux/config.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/stat.h>
@@ -18,8 +17,9 @@
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
-#include <asm/local.h>
+#include <linux/wait.h>
 
+#include <asm/local.h>
 #include <asm/module.h>
 
 /* Not Yet Implemented */
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/sched.h sched/include/linux/sched.h
--- bk-linus/include/linux/sched.h	2004-07-30 22:46:12.000000000 +0100
+++ sched/include/linux/sched.h	2004-08-19 16:31:02.000000000 +0100
@@ -747,19 +747,8 @@ extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
 
-extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
-extern int FASTCALL(wake_up_process(struct task_struct * tsk));
-extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
-#ifdef CONFIG_SMP
- extern void kick_process(struct task_struct *tsk);
- extern void FASTCALL(wake_up_forked_thread(struct task_struct * tsk));
-#else
- static inline void kick_process(struct task_struct *tsk) { }
- static inline void wake_up_forked_thread(struct task_struct * tsk)
- {
-	wake_up_forked_process(tsk);
- }
-#endif
+#include <linux/wait.h>
+
 extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
 
@@ -828,21 +817,6 @@ static inline int sas_ss_flags(unsigned 
 		: on_sig_stack(sp) ? SS_ONSTACK : 0);
 }
 
-
-#ifdef CONFIG_SECURITY
-/* code is in security.c */
-extern int capable(int cap);
-#else
-static inline int capable(int cap)
-{
-	if (cap_raised(current->cap_effective, cap)) {
-		current->flags |= PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
-#endif
-
 /*
  * Routines for handling mm_structs
  */
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/wait.h sched/include/linux/wait.h
--- bk-linus/include/linux/wait.h	2004-06-25 00:01:14.000000000 +0100
+++ sched/include/linux/wait.h	2004-08-19 16:31:02.000000000 +0100
@@ -107,6 +107,19 @@ static inline void __remove_wait_queue(w
 void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr, void *key));
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
+extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
+extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
+#ifdef CONFIG_SMP
+ extern void kick_process(struct task_struct *tsk);
+ extern void FASTCALL(wake_up_forked_thread(struct task_struct * tsk));
+#else
+ static inline void kick_process(struct task_struct *tsk) { }
+ static inline void wake_up_forked_thread(struct task_struct * tsk)
+ {
+	wake_up_forked_process(tsk);
+ }
+#endif
 
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/kernel/kallsyms.c sched/kernel/kallsyms.c
--- bk-linus/kernel/kallsyms.c	2004-07-03 00:00:39.000000000 +0100
+++ sched/kernel/kallsyms.c	2004-08-19 15:09:08.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/sched.h>	/* for cond_resched */
 
 /* These will be re-linked against their real values during the second link stage */
 extern unsigned long kallsyms_addresses[] __attribute__((weak));
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/ac97_codec.c sched/sound/oss/ac97_codec.c
--- bk-linus/sound/oss/ac97_codec.c	2004-06-03 13:40:30.000000000 +0100
+++ sched/sound/oss/ac97_codec.c	2004-08-19 15:09:13.000000000 +0100
@@ -54,6 +54,7 @@
 #include <linux/delay.h>
 #include <linux/ac97_codec.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
 #define CODEC_ID_BUFSZ 14
 
