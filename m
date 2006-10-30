Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbWJ3Kpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbWJ3Kpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWJ3Kpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:45:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60058 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161237AbWJ3Kpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:45:34 -0500
To: linux-arch@vger.kernel.org
Subject: [PATCH 1/7] severing module.h->sched.h
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-Id: <E1GeUe5-0002nt-63@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 30 Oct 2006 10:45:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/i386/kernel/alternative.c            |    1 +
 arch/i386/kernel/cpu/mcheck/therm_throt.c |    1 +
 drivers/base/cpu.c                        |    1 +
 drivers/hwmon/abituguru.c                 |    1 +
 drivers/leds/ledtrig-ide-disk.c           |    1 +
 drivers/leds/ledtrig-timer.c              |    1 +
 drivers/scsi/scsi_transport_sas.c         |    1 +
 drivers/w1/slaves/w1_therm.c              |    1 +
 include/asm-x86_64/elf.h                  |    1 -
 include/linux/acct.h                      |    1 +
 include/linux/module.h                    |   13 +------------
 include/linux/phy.h                       |    2 ++
 include/scsi/libiscsi.h                   |    2 ++
 kernel/latency.c                          |    1 +
 kernel/module.c                           |   15 ++++++++++++++-
 lib/random32.c                            |    1 +
 16 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/i386/kernel/alternative.c b/arch/i386/kernel/alternative.c
index 583c238..535f979 100644
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -1,4 +1,5 @@
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <asm/alternative.h>
diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
index 2d8703b..bad8b44 100644
--- a/arch/i386/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -20,6 +20,7 @@ #include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <linux/notifier.h>
+#include <linux/jiffies.h>
 #include <asm/therm_throt.h>
 
 /* How long to wait between reporting thermal events */
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4bef76a..1f745f1 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -5,6 +5,7 @@
 #include <linux/sysdev.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/cpu.h>
 #include <linux/topology.h>
 #include <linux/device.h>
diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index e5cb0fd..b1dc63e 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -21,6 +21,7 @@
     etc voltage & frequency control is not supported!
 */
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
diff --git a/drivers/leds/ledtrig-ide-disk.c b/drivers/leds/ledtrig-ide-disk.c
index fa65188..54b155c 100644
--- a/drivers/leds/ledtrig-ide-disk.c
+++ b/drivers/leds/ledtrig-ide-disk.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/timer.h>
diff --git a/drivers/leds/ledtrig-timer.c b/drivers/leds/ledtrig-timer.c
index 29a8818..d756bdb 100644
--- a/drivers/leds/ledtrig-timer.c
+++ b/drivers/leds/ledtrig-timer.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/list.h>
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index b5b0c2c..5c0b75b 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -25,6 +25,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 5372cfc..b022fff 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -24,6 +24,7 @@ #include <asm/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/delay.h>
diff --git a/include/asm-x86_64/elf.h b/include/asm-x86_64/elf.h
index a406fcb..6d24ea7 100644
--- a/include/asm-x86_64/elf.h
+++ b/include/asm-x86_64/elf.h
@@ -45,7 +45,6 @@ #define ELF_ARCH	EM_X86_64
 
 #ifdef __KERNEL__
 #include <asm/processor.h>
-#include <asm/compat.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/include/linux/acct.h b/include/linux/acct.h
index 0496d1f..302eb72 100644
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -119,6 +119,7 @@ #ifdef __KERNEL__
 #ifdef CONFIG_BSD_PROCESS_ACCT
 struct vfsmount;
 struct super_block;
+struct pacct_struct;
 extern void acct_auto_close_mnt(struct vfsmount *m);
 extern void acct_auto_close(struct super_block *sb);
 extern void acct_init_pacct(struct pacct_struct *pacct);
diff --git a/include/linux/module.h b/include/linux/module.h
index d1d00ce..ea993ea 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -6,7 +6,6 @@ #define _LINUX_MODULE_H
  * Rewritten by Richard Henderson <rth@tamu.edu> Dec 1996
  * Rewritten again by Rusty Russell, 2002
  */
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/stat.h>
@@ -410,17 +409,7 @@ static inline int try_module_get(struct 
 	return ret;
 }
 
-static inline void module_put(struct module *module)
-{
-	if (module) {
-		unsigned int cpu = get_cpu();
-		local_dec(&module->ref[cpu].count);
-		/* Maybe they're waiting for us to drop reference? */
-		if (unlikely(!module_is_live(module)))
-			wake_up_process(module->waiter);
-		put_cpu();
-	}
-}
+extern void module_put(struct module *module);
 
 #else /*!CONFIG_MODULE_UNLOAD*/
 static inline int try_module_get(struct module *module)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 9447a57..f7c2dca 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -20,6 +20,8 @@ #define __PHY_H
 
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/workqueue.h>
+#include <linux/timer.h>
 
 #define PHY_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
 				 SUPPORTED_10baseT_Full | \
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index 61eebec..ea0816d 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -25,6 +25,8 @@ #define LIBISCSI_H
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <scsi/iscsi_proto.h>
 #include <scsi/iscsi_if.h>
 
diff --git a/kernel/latency.c b/kernel/latency.c
index 258f255..e63fcac 100644
--- a/kernel/latency.c
+++ b/kernel/latency.c
@@ -36,6 +36,7 @@ #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/jiffies.h>
 #include <asm/atomic.h>
 
 struct latency_info {
diff --git a/kernel/module.c b/kernel/module.c
index 5072a94..e3eb11c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -34,10 +34,10 @@ #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/vermagic.h>
 #include <linux/notifier.h>
+#include <linux/sched.h>
 #include <linux/stop_machine.h>
 #include <linux/device.h>
 #include <linux/string.h>
-#include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/unwind.h>
 #include <asm/uaccess.h>
@@ -790,6 +790,19 @@ static struct module_attribute refcnt = 
 	.show = show_refcnt,
 };
 
+void module_put(struct module *module)
+{
+	if (module) {
+		unsigned int cpu = get_cpu();
+		local_dec(&module->ref[cpu].count);
+		/* Maybe they're waiting for us to drop reference? */
+		if (unlikely(!module_is_live(module)))
+			wake_up_process(module->waiter);
+		put_cpu();
+	}
+}
+EXPORT_SYMBOL(module_put);
+
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
diff --git a/lib/random32.c b/lib/random32.c
index 4a15ce5..ec7f81d 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <linux/percpu.h>
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
1.4.2.GIT


