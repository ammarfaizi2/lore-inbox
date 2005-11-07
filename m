Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVKGJNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVKGJNS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 04:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVKGJNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 04:13:18 -0500
Received: from havoc.gtf.org ([69.61.125.42]:4812 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932463AbVKGJNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 04:13:17 -0500
Date: Mon, 7 Nov 2005 04:13:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] move pm_register/etc. to CONFIG_PM_LEGACY, pm_legacy.h
Message-ID: <20051107091313.GA15128@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since few people need the support anymore, this moves the legacy
pm_xxx functions to CONFIG_PM_LEGACY, and include/linux/pm_legacy.h.

 arch/arm/kernel/apm.c           |    1 
 arch/frv/kernel/pm.c            |    1 
 arch/i386/Kconfig               |    2 -
 arch/i386/kernel/apm.c          |    1 
 arch/mips/au1000/common/power.c |    1 
 drivers/acpi/bus.c              |    3 +-
 drivers/mtd/mtdcore.c           |    9 ++++---
 drivers/net/3c509.c             |   13 +++++-----
 drivers/net/irda/ali-ircc.c     |    1 
 drivers/net/irda/nsc-ircc.c     |    1 
 drivers/serial/68328serial.c    |    7 +++--
 include/linux/pm.h              |   49 ----------------------------------------
 kernel/power/Kconfig            |    9 +++++++
 kernel/power/Makefile           |    3 +-
 kernel/power/pm.c               |    1 
 sound/oss/ad1848.c              |    1 
 sound/oss/cs4281/cs4281m.c      |    1 
 sound/oss/maestro.c             |    1 
 sound/oss/nm256_audio.c         |    1 
 sound/oss/opl3sa2.c             |   18 ++++++++------
 25 files changed, 52 insertions(+), 74 deletions(-)

diff --git a/arch/arm/kernel/apm.c b/arch/arm/kernel/apm.c
index b0bbd1e..a2843be 100644
--- a/arch/arm/kernel/apm.c
+++ b/arch/arm/kernel/apm.c
@@ -20,6 +20,7 @@
 #include <linux/apm_bios.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
index 1a1e8a1..712c3c2 100644
--- a/arch/frv/kernel/pm.c
+++ b/arch/frv/kernel/pm.c
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/sysctl.h>
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index bac0da7..97c8a73 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -699,7 +699,7 @@ depends on PM && !X86_VISWS
 
 config APM
 	tristate "APM (Advanced Power Management) BIOS support"
-	depends on PM
+	depends on PM && PM_LEGACY
 	---help---
 	  APM is a BIOS specification for saving power using several different
 	  techniques. This is mostly useful for battery powered laptops with
diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index d2ef0c2..f6bfbb0 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -218,6 +218,7 @@
 #include <linux/time.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index f85093b..f492631 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -32,6 +32,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/jiffies.h>
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 6a4da41..606f873 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/device.h>
 #include <linux/proc_fs.h>
 #ifdef CONFIG_X86
@@ -754,7 +755,7 @@ static int __init acpi_init(void)
 	result = acpi_bus_init();
 
 	if (!result) {
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 		if (!PM_IS_ACTIVE())
 			pm_active = 1;
 		else {
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index dc86df1..f829e5a 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -299,9 +299,10 @@ EXPORT_SYMBOL(default_mtd_readv);
 /*====================================================================*/
 /* Power management code */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 
 static struct pm_dev *mtd_pm_dev = NULL;
 
@@ -327,7 +328,7 @@ static int mtd_pm_callback(struct pm_dev
 	up(&mtd_table_mutex);
 	return ret;
 }
-#endif
+#endif /* CONFIG_PM_LEGACY */
 
 /*====================================================================*/
 /* Support for /proc/mtd */
@@ -389,7 +390,7 @@ static int __init init_mtd(void)
 		proc_mtd->read_proc = mtd_read_proc;
 #endif
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 	mtd_pm_dev = pm_register(PM_UNKNOWN_DEV, 0, mtd_pm_callback);
 #endif
 	return 0;
@@ -397,7 +398,7 @@ static int __init init_mtd(void)
 
 static void __exit cleanup_mtd(void)
 {
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 	if (mtd_pm_dev) {
 		pm_unregister(mtd_pm_dev);
 		mtd_pm_dev = NULL;
diff --git a/drivers/net/3c509.c b/drivers/net/3c509.c
index 977935a..824e430 100644
--- a/drivers/net/3c509.c
+++ b/drivers/net/3c509.c
@@ -84,6 +84,7 @@ static int max_interrupt_work = 10;
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>	/* for udelay() */
 #include <linux/spinlock.h>
@@ -173,7 +174,7 @@ struct el3_private {
 	/* skb send-queue */
 	int head, size;
 	struct sk_buff *queue[SKB_QUEUE_SIZE];
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 	struct pm_dev *pmdev;
 #endif
 	enum {
@@ -200,7 +201,7 @@ static void el3_tx_timeout (struct net_d
 static void el3_down(struct net_device *dev);
 static void el3_up(struct net_device *dev);
 static struct ethtool_ops ethtool_ops;
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 static int el3_suspend(struct pm_dev *pdev);
 static int el3_resume(struct pm_dev *pdev);
 static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data);
@@ -361,7 +362,7 @@ static void el3_common_remove (struct ne
 	struct el3_private *lp = netdev_priv(dev);
 
 	(void) lp;				/* Keep gcc quiet... */
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 	if (lp->pmdev)
 		pm_unregister(lp->pmdev);
 #endif
@@ -571,7 +572,7 @@ no_pnp:
 	if (err)
 		goto out1;
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 	/* register power management */
 	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
 	if (lp->pmdev) {
@@ -1479,7 +1480,7 @@ el3_up(struct net_device *dev)
 }
 
 /* Power Management support functions */
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 
 static int
 el3_suspend(struct pm_dev *pdev)
@@ -1548,7 +1549,7 @@ el3_pm_callback(struct pm_dev *pdev, pm_
 	return 0;
 }
 
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_LEGACY */
 
 /* Parameters that may be passed into the module. */
 static int debug = -1;
diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
diff --git a/drivers/net/irda/ali-ircc.c b/drivers/net/irda/ali-ircc.c
index 9bf3468..2e7882e 100644
--- a/drivers/net/irda/ali-ircc.c
+++ b/drivers/net/irda/ali-ircc.c
@@ -40,6 +40,7 @@
 #include <asm/byteorder.h>
 
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 
 #include <net/irda/wrapper.h>
 #include <net/irda/irda.h>
diff --git a/drivers/net/irda/nsc-ircc.c b/drivers/net/irda/nsc-ircc.c
index 805714e..ee717d0 100644
--- a/drivers/net/irda/nsc-ircc.c
+++ b/drivers/net/irda/nsc-ircc.c
@@ -59,6 +59,7 @@
 #include <asm/byteorder.h>
 
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 
 #include <net/irda/wrapper.h>
 #include <net/irda/irda.h>
diff --git a/drivers/serial/68328serial.c b/drivers/serial/68328serial.c
index 2efb317..67e9afa 100644
--- a/drivers/serial/68328serial.c
+++ b/drivers/serial/68328serial.c
@@ -34,6 +34,7 @@
 #include <linux/keyboard.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
@@ -1343,7 +1344,7 @@ static void show_serial_version(void)
 	printk("MC68328 serial driver version 1.00\n");
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 /* Serial Power management
  *  The console (currently fixed at line 0) is a special case for power
  *  management because the kernel is so chatty. The console will be 
@@ -1393,7 +1394,7 @@ void startup_console(void)
 	struct m68k_serial *info = &m68k_soft[0];
 	startup(info);
 }
-#endif
+#endif /* CONFIG_PM_LEGACY */
 
 
 static struct tty_operations rs_ops = {
@@ -1486,7 +1487,7 @@ rs68328_init(void)
 			    IRQ_FLG_STD,
 			    "M68328_UART", NULL))
                 panic("Unable to attach 68328 serial interrupt\n");
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 	    serial_pm[i] = pm_register(PM_SYS_DEV, PM_SYS_COM, serial_pm_callback);
 	    if (serial_pm[i])
 		    serial_pm[i]->data = info;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1514098..5be87ba 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -94,55 +94,6 @@ struct pm_dev
 	struct list_head entry;
 };
 
-#ifdef CONFIG_PM
-
-extern int pm_active;
-
-#define PM_IS_ACTIVE() (pm_active != 0)
-
-/*
- * Register a device with power management
- */
-struct pm_dev __deprecated *
-pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
-
-/*
- * Unregister a device with power management
- */
-void __deprecated pm_unregister(struct pm_dev *dev);
-
-/*
- * Unregister all devices with matching callback
- */
-void __deprecated pm_unregister_all(pm_callback callback);
-
-/*
- * Send a request to all devices
- */
-int __deprecated pm_send_all(pm_request_t rqst, void *data);
-
-#else /* CONFIG_PM */
-
-#define PM_IS_ACTIVE() 0
-
-static inline struct pm_dev *pm_register(pm_dev_t type,
-					 unsigned long id,
-					 pm_callback callback)
-{
-	return NULL;
-}
-
-static inline void pm_unregister(struct pm_dev *dev) {}
-
-static inline void pm_unregister_all(pm_callback callback) {}
-
-static inline int pm_send_all(pm_request_t rqst, void *data)
-{
-	return 0;
-}
-
-#endif /* CONFIG_PM */
-
 /* Functions above this comment are list-based old-style power
  * managment. Please avoid using them.  */
 
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 46a5e5a..5ec248c 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -19,6 +19,15 @@ config PM
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config PM_LEGACY
+	bool "Legacy Power Management API"
+	depends on PM
+	default y
+	---help---
+	   Support for pm_register() and friends.
+
+	   If unsure, say Y.
+
 config PM_DEBUG
 	bool "Power Management Debug Support"
 	depends on PM
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index c71eb45..04be7d0 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -3,7 +3,8 @@ ifeq ($(CONFIG_PM_DEBUG),y)
 EXTRA_CFLAGS	+=	-DDEBUG
 endif
 
-obj-y				:= main.o process.o console.o pm.o
+obj-y				:= main.o process.o console.o
+obj-$(CONFIG_PM_LEGACY)		+= pm.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
diff --git a/kernel/power/pm.c b/kernel/power/pm.c
index 1591493..33c508e 100644
--- a/kernel/power/pm.c
+++ b/kernel/power/pm.c
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/interrupt.h>
 
 int pm_active;
diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 7c835ab..3f30c57 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -47,6 +47,7 @@
 #include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/isapnp.h>
 #include <linux/pnp.h>
 #include <linux/spinlock.h>
diff --git a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
index d0d3963..adc6896 100644
--- a/sound/oss/cs4281/cs4281m.c
+++ b/sound/oss/cs4281/cs4281m.c
@@ -298,6 +298,7 @@ struct cs4281_state {
 	struct cs4281_pipeline pl[CS4281_NUMBER_OF_PIPELINES];
 };
 
+#include <linux/pm_legacy.h>
 #include "cs4281pm-24.c"
 
 #if CSDEBUG
diff --git a/sound/oss/cs4281/cs4281pm-24.c b/sound/oss/cs4281/cs4281pm-24.c
diff --git a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
diff --git a/sound/oss/maestro.c b/sound/oss/maestro.c
index 3dce504..3abd354 100644
--- a/sound/oss/maestro.c
+++ b/sound/oss/maestro.c
@@ -231,6 +231,7 @@
 #include <asm/uaccess.h>
 
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 static int maestro_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *d);
 
 #include "maestro.h"
diff --git a/sound/oss/nm256_audio.c b/sound/oss/nm256_audio.c
index 6697006..0ce2c40 100644
--- a/sound/oss/nm256_audio.c
+++ b/sound/oss/nm256_audio.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include "sound_config.h"
diff --git a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
index 2efbd86..cd41d0e 100644
--- a/sound/oss/opl3sa2.c
+++ b/sound/oss/opl3sa2.c
@@ -70,6 +70,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/pm_legacy.h>
 #include "sound_config.h"
 
 #include "ad1848.h"
@@ -138,7 +139,7 @@ typedef struct {
 	struct pnp_dev* pdev;
 	int activated;			/* Whether said devices have been activated */
 #endif
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 	unsigned int	in_suspend;
 	struct pm_dev	*pmdev;
 #endif
@@ -341,7 +342,7 @@ static void opl3sa2_mixer_reset(opl3sa2_
 }
 
 /* Currently only used for power management */
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 static void opl3sa2_mixer_restore(opl3sa2_state_t* devc)
 {
 	if (devc) {
@@ -354,7 +355,7 @@ static void opl3sa2_mixer_restore(opl3sa
 		}
 	}
 }
-#endif
+#endif /* CONFIG_PM_LEGACY */
 
 static inline void arg_to_vol_mono(unsigned int vol, int* value)
 {
@@ -831,7 +832,8 @@ static struct pnp_driver opl3sa2_driver 
 
 /* End of component functions */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
+
 static DEFINE_SPINLOCK(opl3sa2_lock);
 
 /* Power Management support functions */
@@ -906,7 +908,7 @@ static int opl3sa2_pm_callback(struct pm
 	}
 	return 0;
 }
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_LEGACY */
 
 /*
  * Install OPL3-SA2 based card(s).
@@ -1019,12 +1021,12 @@ static int __init init_opl3sa2(void)
 
 		/* ewww =) */
 		opl3sa2_state[card].card = card;
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 		/* register our power management capabilities */
 		opl3sa2_state[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);
 		if (opl3sa2_state[card].pmdev)
 			opl3sa2_state[card].pmdev->data = &opl3sa2_state[card];
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_LEGACY */
 
 		/*
 		 * Set the Yamaha 3D enhancement mode (aka Ymersion) if asked to and
@@ -1081,7 +1083,7 @@ static void __exit cleanup_opl3sa2(void)
 	int card;
 
 	for(card = 0; card < opl3sa2_cards_num; card++) {
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_LEGACY
 		if (opl3sa2_state[card].pmdev)
 			pm_unregister(opl3sa2_state[card].pmdev);
 #endif
