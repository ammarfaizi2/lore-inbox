Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWF0UwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWF0UwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWF0UwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:52:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:61743 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030354AbWF0UwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:52:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ArywJPD1nScVTUJ1KOdH13zKZizSKT5CIfn036QJNS5gf2Rl+H0uz1W2E1uInXzjSvaBot6XWffEChx3pKL0bvpnkcvJV+oXmyyS0uuShPyq+s1fXKNEYJmqCijflNGTBB0dPewmFv8a2e4jt7Vk86/2XjiahJR7XLrDht/yG7s=
Message-ID: <9e4733910606271352y4a9668e0n76536fc84771674@mail.gmail.com>
Date: Tue, 27 Jun 2006 16:52:12 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, adaplas@gmail.com,
       "Randy. Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] remove include of screen_info.h from tty.h
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

screen_info.h doesn't have anything to do with the tty layer and
shouldn't be included by tty.h. This patches removes the include and
modifies all users to directly include screen_info.h. struct
screen_info is mainly used to communicate with the console drivers in
drivers/video/console. Note that this patch touches every arch and I
have no way of testing it. If there is a mistake the worst thing that
will happen is a compile error.

Signed-off-by: Jon Smirl <jonsmir@gmail.com>

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 558b833..22cd405 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -19,7 +19,7 @@ #include <linux/ptrace.h>
  #include <linux/slab.h>
  #include <linux/user.h>
  #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/delay.h>
  #include <linux/config.h>	/* CONFIG_ALPHA_LCA etc */
  #include <linux/mc146818rtc.h>
diff --git a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
index 131a2d9..bfe8650 100644
--- a/arch/alpha/kernel/sys_sio.c
+++ b/arch/alpha/kernel/sys_sio.c
@@ -17,7 +17,7 @@ #include <linux/mm.h>
  #include <linux/sched.h>
  #include <linux/pci.h>
  #include <linux/init.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>

 #include <asm/compiler.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 9fc9af8..0e96453 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -18,7 +18,7 @@ #include <linux/initrd.h>
  #include <linux/console.h>
  #include <linux/bootmem.h>
  #include <linux/seq_file.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/init.h>
  #include <linux/root_dev.h>
  #include <linux/cpu.h>
diff --git a/arch/arm26/kernel/setup.c b/arch/arm26/kernel/setup.c
index 4eb329e..365486c 100644
--- a/arch/arm26/kernel/setup.c
+++ b/arch/arm26/kernel/setup.c
@@ -18,7 +18,7 @@ #include <linux/blkdev.h>
  #include <linux/console.h>
  #include <linux/bootmem.h>
  #include <linux/seq_file.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/init.h>
  #include <linux/root_dev.h>

diff --git a/arch/cris/kernel/setup.c b/arch/cris/kernel/setup.c
index 619a6ee..2072752 100644
--- a/arch/cris/kernel/setup.c
+++ b/arch/cris/kernel/setup.c
@@ -16,7 +16,7 @@ #include <linux/mm.h>
  #include <linux/bootmem.h>
 #include <asm/pgtable.h>
  #include <linux/seq_file.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/utsname.h>
  #include <linux/pfn.h>

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 6c16398..b59dcb3 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -27,7 +27,7 @@ #include <linux/config.h>
  #include <linux/sched.h>
  #include <linux/mm.h>
  #include <linux/mmzone.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/ioport.h>
  #include <linux/acpi.h>
  #include <linux/apm_bios.h>
diff --git a/arch/ia64/dig/setup.c b/arch/ia64/dig/setup.c
index 38aa9c1..c4933de 100644
--- a/arch/ia64/dig/setup.c
+++ b/arch/ia64/dig/setup.c
@@ -15,7 +15,7 @@ #include <linux/delay.h>
  #include <linux/kernel.h>
  #include <linux/kdev_t.h>
  #include <linux/string.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/console.h>
  #include <linux/timex.h>
  #include <linux/sched.h>
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 6dba2d6..16b7515 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -36,7 +36,7 @@ #include <linux/sched.h>
  #include <linux/seq_file.h>
  #include <linux/string.h>
  #include <linux/threads.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/dmi.h>
  #include <linux/serial.h>
  #include <linux/serial_core.h>
diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 93577ab..73f1ff0 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -13,7 +13,7 @@ #include <linux/delay.h>
  #include <linux/kernel.h>
  #include <linux/kdev_t.h>
  #include <linux/string.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/console.h>
  #include <linux/timex.h>
  #include <linux/sched.h>
diff --git a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
index 3cd3c29..3ef6c9e 100644
--- a/arch/m32r/kernel/setup.c
+++ b/arch/m32r/kernel/setup.c
@@ -22,7 +22,7 @@ #include <linux/major.h>
  #include <linux/root_dev.h>
  #include <linux/seq_file.h>
  #include <linux/timex.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/cpu.h>
  #include <linux/nodemask.h>
  #include <linux/pfn.h>
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bfcec8d..0437b9a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -25,7 +25,7 @@ #include <linux/slab.h>
  #include <linux/user.h>
  #include <linux/utsname.h>
  #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/bootmem.h>
  #include <linux/initrd.h>
  #include <linux/major.h>
diff --git a/arch/mips/mips-boards/malta/malta_setup.c
b/arch/mips/mips-boards/malta/malta_setup.c
index 0766e43..024bb05 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -20,7 +20,7 @@ #include <linux/init.h>
  #include <linux/sched.h>
  #include <linux/ioport.h>
  #include <linux/pci.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>

  #ifdef CONFIG_MTD
  #include <linux/mtd/partitions.h>
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index f9e6949..79d925b 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -28,7 +28,7 @@ #include <linux/bootmem.h>
  #include <linux/blkdev.h>
  #include <linux/init.h>
  #include <linux/kernel.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/initrd.h>

 #include <asm/irq.h>
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index a050bb6..d21e8a8 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -19,7 +19,7 @@ #include <linux/pm.h>
  #include <linux/pci.h>
  #include <linux/console.h>
  #include <linux/fb.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>

  #ifdef CONFIG_ARC
 #include <asm/arc/types.h>
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 4b052ae..755b69a 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -6,7 +6,7 @@ #include <linux/sched.h>
  #include <linux/elfcore.h>
  #include <linux/string.h>
  #include <linux/interrupt.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/vt_kern.h>
  #include <linux/nvram.h>
  #include <linux/console.h>
diff --git a/arch/powerpc/kernel/setup-common.c
b/arch/powerpc/kernel/setup-common.c
index bd32812..5a17d80 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -27,7 +27,7 @@ #include <linux/seq_file.h>
  #include <linux/ioport.h>
  #include <linux/console.h>
  #include <linux/utsname.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/root_dev.h>
  #include <linux/notifier.h>
  #include <linux/cpu.h>
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index b250b1b..64cf348 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -6,7 +6,7 @@ #include <linux/sched.h>
  #include <linux/elfcore.h>
  #include <linux/string.h>
  #include <linux/interrupt.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/vt_kern.h>
  #include <linux/nvram.h>
  #include <linux/console.h>
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
index 1f79e84..06a349a 100644
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -12,7 +12,7 @@ #include <linux/reboot.h>
  #include <linux/delay.h>
  #include <linux/initrd.h>
  #include <linux/ide.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/bootmem.h>
  #include <linux/seq_file.h>
  #include <linux/root_dev.h>
diff --git a/arch/ppc/platforms/prep_setup.c b/arch/ppc/platforms/prep_setup.c
index e86f615..d810790 100644
--- a/arch/ppc/platforms/prep_setup.c
+++ b/arch/ppc/platforms/prep_setup.c
@@ -24,7 +24,7 @@ #include <linux/ptrace.h>
  #include <linux/slab.h>
  #include <linux/user.h>
  #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/major.h>
  #include <linux/interrupt.h>
  #include <linux/reboot.h>
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index bb229ef..b9e22fb 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -10,7 +10,7 @@
  * This file handles the architecture-dependent parts of initialization
  */

-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/ioport.h>
  #include <linux/init.h>
  #include <linux/initrd.h>
diff --git a/arch/sh64/kernel/setup.c b/arch/sh64/kernel/setup.c
index d2711c9..3bb02a0 100644
--- a/arch/sh64/kernel/setup.c
+++ b/arch/sh64/kernel/setup.c
@@ -36,7 +36,7 @@ #include <linux/ptrace.h>
  #include <linux/slab.h>
  #include <linux/user.h>
  #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/ioport.h>
  #include <linux/delay.h>
  #include <linux/config.h>
diff --git a/arch/sh64/kernel/sh_ksyms.c b/arch/sh64/kernel/sh_ksyms.c
index 6f3a1c9..b9d8468 100644
--- a/arch/sh64/kernel/sh_ksyms.c
+++ b/arch/sh64/kernel/sh_ksyms.c
@@ -19,7 +19,7 @@ #include <linux/sched.h>
  #include <linux/in6.h>
  #include <linux/interrupt.h>
  #include <linux/smp_lock.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>

 #include <asm/semaphore.h>
 #include <asm/processor.h>
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index a893a9c..fb5c5d6 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -17,7 +17,7 @@ #include <linux/initrd.h>
 #include <asm/smp.h>
  #include <linux/user.h>
  #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/delay.h>
  #include <linux/config.h>
  #include <linux/fs.h>
diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index a6a7d81..b9b80e6 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -16,7 +16,7 @@ #include <linux/slab.h>
 #include <asm/smp.h>
  #include <linux/user.h>
  #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/delay.h>
  #include <linux/config.h>
  #include <linux/fs.h>
diff --git a/arch/x86_64/kernel/early_printk.c
b/arch/x86_64/kernel/early_printk.c
index b93ef5b..140051e 100644
--- a/arch/x86_64/kernel/early_printk.c
+++ b/arch/x86_64/kernel/early_printk.c
@@ -2,7 +2,7 @@ #include <linux/console.h>
  #include <linux/kernel.h>
  #include <linux/init.h>
  #include <linux/string.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/fcntl.h>
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index fdb8265..d81ea5a 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -23,7 +23,7 @@ #include <linux/ptrace.h>
  #include <linux/slab.h>
  #include <linux/user.h>
  #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/ioport.h>
  #include <linux/delay.h>
  #include <linux/config.h>
diff --git a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
index 1def21c..7bd60d5 100644
--- a/arch/x86_64/kernel/x8664_ksyms.c
+++ b/arch/x86_64/kernel/x8664_ksyms.c
@@ -12,7 +12,7 @@ #include <linux/apm_bios.h>
  #include <linux/kernel.h>
  #include <linux/string.h>
  #include <linux/syscalls.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>

 #include <asm/semaphore.h>
 #include <asm/processor.h>
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 513ed8d..ef7e920 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -18,7 +18,7 @@ #include <linux/config.h>
  #include <linux/errno.h>
  #include <linux/init.h>
  #include <linux/proc_fs.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/bootmem.h>
  #include <linux/kernel.h>

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index e64d42e..978d8dd 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -40,6 +40,7 @@ #include <linux/sched.h>
  #include <linux/fs.h>
  #include <linux/kernel.h>
  #include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/console.h>
  #include <linux/string.h>
  #include <linux/kd.h>
diff --git a/drivers/video/intelfb/intelfbdrv.c
b/drivers/video/intelfb/intelfbdrv.c
index 0a0a8b1..e9bc26c 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -114,7 +114,7 @@ #include <linux/kernel.h>
  #include <linux/errno.h>
  #include <linux/string.h>
  #include <linux/mm.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/slab.h>
  #include <linux/delay.h>
  #include <linux/fb.h>
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 4fd2a27..25bd664 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -15,7 +15,7 @@ #include <linux/kernel.h>
  #include <linux/errno.h>
  #include <linux/string.h>
  #include <linux/mm.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
  #include <linux/slab.h>
  #include <linux/delay.h>
  #include <linux/fb.h>
diff --git a/include/linux/tty.h b/include/linux/tty.h
index cb35ca5..0047ac3 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -22,7 +22,6 @@ #include <linux/termios.h>
  #include <linux/workqueue.h>
  #include <linux/tty_driver.h>
  #include <linux/tty_ldisc.h>
-#include <linux/screen_info.h>
  #include <linux/mutex.h>

 #include <asm/system.h>
