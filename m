Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVLLXrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVLLXrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVLLXrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:47:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932265AbVLLXqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:43 -0500
Date: Mon, 12 Dec 2005 23:45:47 GMT
Message-Id: <200512122345.jBCNjlcb009037@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 6/19] MUTEX: Drivers A-E changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the files of the drivers/a* thru drivers/e* to use
the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-AtoE-2615rc5.diff
 drivers/acpi/ec.c                   |    2 +-
 drivers/acpi/osl.c                  |   10 +++++-----
 drivers/acpi/video.c                |    2 +-
 drivers/atm/ambassador.h            |    2 +-
 drivers/atm/fore200e.h              |    2 +-
 drivers/atm/idt77252.c              |    2 +-
 drivers/atm/idt77252.h              |    2 +-
 drivers/base/core.c                 |    2 +-
 drivers/base/firmware_class.c       |    2 +-
 drivers/base/map.c                  |    6 +++---
 drivers/base/power/power.h          |    4 ++--
 drivers/base/power/shutdown.c       |    2 +-
 drivers/base/sys.c                  |    2 +-
 drivers/block/aoe/aoechr.c          |    4 ++--
 drivers/block/cryptoloop.c          |    2 +-
 drivers/block/pktcdvd.c             |    2 +-
 drivers/block/sx8.c                 |    4 ++--
 drivers/char/agp/frontend.c         |    2 +-
 drivers/char/drm/drmP.h             |    4 ++--
 drivers/char/drm/drm_stub.c         |    4 ++--
 drivers/char/generic_serial.c       |    2 +-
 drivers/char/ipmi/ipmi_devintf.c    |    6 +++---
 drivers/char/ipmi/ipmi_msghandler.c |    2 +-
 drivers/char/mbcs.h                 |    6 +++---
 drivers/char/moxa.c                 |    2 +-
 drivers/char/rio/rioboot.c          |    2 +-
 drivers/char/rio/riocmd.c           |    2 +-
 drivers/char/rio/rioctrl.c          |    2 +-
 drivers/char/rio/rioinit.c          |    2 +-
 drivers/char/rio/riointr.c          |    2 +-
 drivers/char/rio/rioparam.c         |    2 +-
 drivers/char/rio/rioroute.c         |    2 +-
 drivers/char/rio/riotable.c         |    2 +-
 drivers/char/rio/riotty.c           |    2 +-
 drivers/char/rocket.c               |    4 ++--
 drivers/char/rocket_int.h           |    2 +-
 drivers/char/ser_a2232.c            |    2 +-
 drivers/char/snsc.c                 |    4 ++--
 drivers/char/snsc.h                 |    6 +++---
 drivers/char/sonypi.c               |    2 +-
 drivers/char/tpm/tpm.h              |    4 ++--
 drivers/char/tty_io.c               |    4 ++--
 drivers/char/viotape.c              |   20 ++++++++++----------
 drivers/char/watchdog/cpu5wdt.c     |    2 +-
 drivers/char/watchdog/pcwd_usb.c    |    2 +-
 drivers/char/watchdog/sc1200wdt.c   |    6 +++---
 drivers/char/watchdog/scx200_wdt.c  |    4 ++--
 drivers/char/watchdog/wdt_pci.c     |    4 ++--
 48 files changed, 82 insertions(+), 82 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/acpi/ec.c linux-2.6.15-rc5-mutex/drivers/acpi/ec.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/acpi/ec.c	2005-11-01 13:19:04.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/acpi/ec.c	2005-12-12 17:40:34.000000000 +0000
@@ -103,7 +103,7 @@ union acpi_ec {
 		unsigned int expect_event;
 		atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
 		atomic_t pending_gpe;
-		struct semaphore sem;
+		struct mutex sem;
 		wait_queue_head_t wait;
 	} burst;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/acpi/osl.c linux-2.6.15-rc5-mutex/drivers/acpi/osl.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/acpi/osl.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/acpi/osl.c	2005-12-12 17:49:01.000000000 +0000
@@ -813,7 +813,7 @@ acpi_status acpi_os_wait_semaphore(acpi_
 		 * (a.k.a. 'would block').
 		 */
 	case 0:
-		if (down_trylock(sem))
+		if (down_sem_trylock(sem))
 			status = AE_TIME;
 		break;
 
@@ -822,7 +822,7 @@ acpi_status acpi_os_wait_semaphore(acpi_
 		 * ------------------
 		 */
 	case ACPI_WAIT_FOREVER:
-		down(sem);
+		down_sem(sem);
 		break;
 
 		/*
@@ -835,10 +835,10 @@ acpi_status acpi_os_wait_semaphore(acpi_
 			int i = 0;
 			static const int quantum_ms = 1000 / HZ;
 
-			ret = down_trylock(sem);
+			ret = down_sem_trylock(sem);
 			for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {
 				schedule_timeout_interruptible(1);
-				ret = down_trylock(sem);
+				ret = down_sem_trylock(sem);
 			}
 
 			if (ret != 0)
@@ -881,7 +881,7 @@ acpi_status acpi_os_signal_semaphore(acp
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Signaling semaphore[%p|%d]\n", handle,
 			  units));
 
-	up(sem);
+	up_sem(sem);
 
 	return_ACPI_STATUS(AE_OK);
 }
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/acpi/video.c linux-2.6.15-rc5-mutex/drivers/acpi/video.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/acpi/video.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/acpi/video.c	2005-12-12 21:13:16.000000000 +0000
@@ -123,7 +123,7 @@ struct acpi_video_bus {
 	u8 attached_count;
 	struct acpi_video_bus_cap cap;
 	struct acpi_video_bus_flags flags;
-	struct semaphore sem;
+	struct mutex sem;
 	struct list_head video_device_list;
 	struct proc_dir_entry *dir;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/atm/ambassador.h linux-2.6.15-rc5-mutex/drivers/atm/ambassador.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/atm/ambassador.h	2005-06-22 13:51:45.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/atm/ambassador.h	2005-12-12 20:59:29.000000000 +0000
@@ -639,7 +639,7 @@ struct amb_dev {
   amb_txq          txq;
   amb_rxq          rxq[NUM_RX_POOLS];
   
-  struct semaphore vcc_sf;
+  struct mutex     vcc_sf;
   amb_tx_info      txer[NUM_VCS];
   struct atm_vcc * rxer[NUM_VCS];
   unsigned int     tx_avail;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/atm/fore200e.h linux-2.6.15-rc5-mutex/drivers/atm/fore200e.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/atm/fore200e.h	2005-06-22 13:51:45.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/atm/fore200e.h	2005-12-12 20:59:38.000000000 +0000
@@ -870,7 +870,7 @@ typedef struct fore200e {
 
     struct stats*              stats;                  /* last snapshot of the stats         */
     
-    struct semaphore           rate_sf;                /* protects rate reservation ops      */
+    struct mutex               rate_sf;                /* protects rate reservation ops      */
     spinlock_t                 q_lock;                 /* protects queue ops                 */
 #ifdef FORE200E_USE_TASKLET
     struct tasklet_struct      tx_tasklet;             /* performs tx interrupt work         */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/atm/idt77252.c linux-2.6.15-rc5-mutex/drivers/atm/idt77252.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/atm/idt77252.c	2005-11-01 13:19:04.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/atm/idt77252.c	2005-12-12 22:12:50.000000000 +0000
@@ -47,7 +47,7 @@ static char const rcsid[] =
 #include <linux/bitops.h>
 #include <linux/wait.h>
 #include <linux/jiffies.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/atm/idt77252.h linux-2.6.15-rc5-mutex/drivers/atm/idt77252.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/atm/idt77252.h	2005-03-02 12:08:03.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/atm/idt77252.h	2005-12-12 20:59:11.000000000 +0000
@@ -359,7 +359,7 @@ struct idt77252_dev
 	unsigned long		srambase;	/* SAR's sram  base address */
 	void __iomem		*fbq[4];	/* FBQ fill addresses */
 
-	struct semaphore	mutex;
+	struct mutex		mutex;
 	spinlock_t		cmd_lock;	/* for r/w utility/sram */
 
 	unsigned long		softstat;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/base/core.c linux-2.6.15-rc5-mutex/drivers/base/core.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/base/core.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/core.c	2005-12-12 22:12:49.000000000 +0000
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "base.h"
 #include "power/power.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/base/firmware_class.c linux-2.6.15-rc5-mutex/drivers/base/firmware_class.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/base/firmware_class.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/firmware_class.c	2005-12-12 22:12:49.000000000 +0000
@@ -14,7 +14,7 @@
 #include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <linux/firmware.h>
 #include "base.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/base/map.c linux-2.6.15-rc5-mutex/drivers/base/map.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/base/map.c	2005-11-01 13:19:05.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/map.c	2005-12-12 17:42:33.000000000 +0000
@@ -25,7 +25,7 @@ struct kobj_map {
 		int (*lock)(dev_t, void *);
 		void *data;
 	} *probes[255];
-	struct semaphore *sem;
+	struct mutex *sem;
 };
 
 int kobj_map(struct kobj_map *domain, dev_t dev, unsigned long range,
@@ -132,7 +132,7 @@ retry:
 	return NULL;
 }
 
-struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct semaphore *sem)
+struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct mutex *mutex)
 {
 	struct kobj_map *p = kmalloc(sizeof(struct kobj_map), GFP_KERNEL);
 	struct probe *base = kzalloc(sizeof(*base), GFP_KERNEL);
@@ -149,6 +149,6 @@ struct kobj_map *kobj_map_init(kobj_prob
 	base->get = base_probe;
 	for (i = 0; i < 255; i++)
 		p->probes[i] = base;
-	p->sem = sem;
+	p->sem = mutex;
 	return p;
 }
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/base/power/power.h linux-2.6.15-rc5-mutex/drivers/base/power/power.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/base/power/power.h	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/power/power.h	2005-12-12 17:44:20.000000000 +0000
@@ -14,12 +14,12 @@ extern void device_shutdown(void);
 /*
  * Used to synchronize global power management operations.
  */
-extern struct semaphore dpm_sem;
+extern struct mutex dpm_sem;
 
 /*
  * Used to serialize changes to the dpm_* lists.
  */
-extern struct semaphore dpm_list_sem;
+extern struct mutex dpm_list_sem;
 
 /*
  * The PM lists.
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/base/power/shutdown.c linux-2.6.15-rc5-mutex/drivers/base/power/shutdown.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/base/power/shutdown.c	2005-06-22 13:51:45.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/base/power/shutdown.c	2005-12-12 22:12:49.000000000 +0000
@@ -10,7 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/device.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "power.h"
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/base/sys.c linux-2.6.15-rc5-mutex/drivers/base/sys.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/base/sys.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/sys.c	2005-12-12 22:12:49.000000000 +0000
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pm.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 extern struct subsystem devices_subsys;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/block/aoe/aoechr.c linux-2.6.15-rc5-mutex/drivers/block/aoe/aoechr.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/block/aoe/aoechr.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/block/aoe/aoechr.c	2005-12-12 21:28:14.000000000 +0000
@@ -96,7 +96,7 @@ bail:		spin_unlock_irqrestore(&emsgs_loc
 	spin_unlock_irqrestore(&emsgs_lock, flags);
 
 	if (nblocked_emsgs_readers)
-		up(&emsgs_sema);
+		up_sem(&emsgs_sema);
 }
 
 static ssize_t
@@ -164,7 +164,7 @@ loop:
 
 			spin_unlock_irqrestore(&emsgs_lock, flags);
 
-			n = down_interruptible(&emsgs_sema);
+			n = down_sem_interruptible(&emsgs_sema);
 
 			spin_lock_irqsave(&emsgs_lock, flags);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/block/cryptoloop.c linux-2.6.15-rc5-mutex/drivers/block/cryptoloop.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/block/cryptoloop.c	2005-11-01 13:19:05.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/block/cryptoloop.c	2005-12-12 22:08:48.000000000 +0000
@@ -26,7 +26,7 @@
 #include <linux/crypto.h>
 #include <linux/blkdev.h>
 #include <linux/loop.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 MODULE_LICENSE("GPL");
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/block/pktcdvd.c linux-2.6.15-rc5-mutex/drivers/block/pktcdvd.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/block/pktcdvd.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/block/pktcdvd.c	2005-12-12 21:28:17.000000000 +0000
@@ -82,7 +82,7 @@
 static struct pktcdvd_device *pkt_devs[MAX_WRITERS];
 static struct proc_dir_entry *pkt_proc;
 static int pkt_major;
-static struct semaphore ctl_mutex;	/* Serialize open/close/setup/teardown */
+static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t *psd_pool;
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/block/sx8.c linux-2.6.15-rc5-mutex/drivers/block/sx8.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/block/sx8.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/block/sx8.c	2005-12-12 22:08:48.000000000 +0000
@@ -28,7 +28,7 @@
 #include <linux/hdreg.h>
 #include <linux/dma-mapping.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #if 0
@@ -303,7 +303,7 @@ struct carm_host {
 
 	struct work_struct		fsm_task;
 
-	struct semaphore		probe_sem;
+	struct mutex			probe_sem;
 };
 
 struct carm_response {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/agp/frontend.c linux-2.6.15-rc5-mutex/drivers/char/agp/frontend.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/agp/frontend.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/agp/frontend.c	2005-12-12 20:15:38.000000000 +0000
@@ -1081,7 +1081,7 @@ static struct miscdevice agp_miscdev =
 int agp_frontend_initialize(void)
 {
 	memset(&agp_fe, 0, sizeof(struct agp_front_data));
-	sema_init(&(agp_fe.agp_mutex), 1);
+	init_MUTEX(&(agp_fe.agp_mutex));
 
 	if (misc_register(&agp_miscdev)) {
 		printk(KERN_ERR PFX "unable to get minor: %d\n", AGPGART_MINOR);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/drm/drmP.h linux-2.6.15-rc5-mutex/drivers/char/drm/drmP.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/drm/drmP.h	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/drm/drmP.h	2005-12-12 20:17:29.000000000 +0000
@@ -625,7 +625,7 @@ typedef struct drm_device {
 	/** \name Locks */
 	/*@{ */
 	spinlock_t count_lock;		/**< For inuse, drm_device::open_count, drm_device::buf_use */
-	struct semaphore struct_sem;	/**< For others */
+	struct mutex struct_sem;	/**< For others */
 	/*@} */
 
 	/** \name Usage Counters */
@@ -660,7 +660,7 @@ typedef struct drm_device {
 	/*@{ */
 	drm_ctx_list_t *ctxlist;	/**< Linked list of context handles */
 	int ctx_count;			/**< Number of context handles */
-	struct semaphore ctxlist_sem;	/**< For ctxlist */
+	struct mutex ctxlist_sem;	/**< For ctxlist */
 
 	drm_map_t **context_sareas;	    /**< per-context SAREA's */
 	int max_context;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/drm/drm_stub.c linux-2.6.15-rc5-mutex/drivers/char/drm/drm_stub.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/drm/drm_stub.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/drm/drm_stub.c	2005-12-12 20:24:32.000000000 +0000
@@ -61,8 +61,8 @@ static int drm_fill_in_dev(drm_device_t 
 
 	spin_lock_init(&dev->count_lock);
 	init_timer(&dev->timer);
-	sema_init(&dev->struct_sem, 1);
-	sema_init(&dev->ctxlist_sem, 1);
+	init_MUTEX(&dev->struct_sem);
+	init_MUTEX(&dev->ctxlist_sem);
 
 	dev->pdev = pdev;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/generic_serial.c linux-2.6.15-rc5-mutex/drivers/char/generic_serial.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/generic_serial.c	2005-06-22 13:51:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/generic_serial.c	2005-12-12 22:08:48.000000000 +0000
@@ -28,7 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/tty_flip.h>
 #include <linux/delay.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #define DEBUG 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/ipmi/ipmi_devintf.c linux-2.6.15-rc5-mutex/drivers/char/ipmi/ipmi_devintf.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/ipmi/ipmi_devintf.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/ipmi/ipmi_devintf.c	2005-12-12 22:08:48.000000000 +0000
@@ -42,7 +42,7 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ipmi.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/compat.h>
@@ -55,7 +55,7 @@ struct ipmi_file_private
 	struct file          *file;
 	struct fasync_struct *fasync_queue;
 	wait_queue_head_t    wait;
-	struct semaphore     recv_sem;
+	struct mutex         recv_sem;
 	int                  default_retries;
 	unsigned int         default_retry_time_ms;
 };
@@ -141,7 +141,7 @@ static int ipmi_open(struct inode *inode
 	INIT_LIST_HEAD(&(priv->recv_msgs));
 	init_waitqueue_head(&priv->wait);
 	priv->fasync_queue = NULL;
-	sema_init(&(priv->recv_sem), 1);
+	init_MUTEX(&(priv->recv_sem));
 
 	/* Use the low-level defaults. */
 	priv->default_retries = -1;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/ipmi/ipmi_msghandler.c linux-2.6.15-rc5-mutex/drivers/char/ipmi/ipmi_msghandler.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/ipmi/ipmi_msghandler.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/ipmi/ipmi_msghandler.c	2005-12-12 21:30:10.000000000 +0000
@@ -209,7 +209,7 @@ struct ipmi_smi
 
 	/* The list of command receivers that are registered for commands
 	   on this interface. */
-	struct semaphore cmd_rcvrs_lock;
+	struct mutex     cmd_rcvrs_lock;
 	struct list_head cmd_rcvrs;
 
 	/* Events that were queues because no one was there to receive
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/mbcs.h linux-2.6.15-rc5-mutex/drivers/char/mbcs.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/mbcs.h	2005-06-22 13:51:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/mbcs.h	2005-12-12 21:29:18.000000000 +0000
@@ -537,9 +537,9 @@ struct mbcs_soft {
 	atomic_t dmawrite_done;
 	atomic_t dmaread_done;
 	atomic_t algo_done;
-	struct semaphore dmawritelock;
-	struct semaphore dmareadlock;
-	struct semaphore algolock;
+	struct mutex dmawritelock;
+	struct mutex dmareadlock;
+	struct mutex algolock;
 };
 
 extern int mbcs_open(struct inode *ip, struct file *fp);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/moxa.c linux-2.6.15-rc5-mutex/drivers/char/moxa.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/moxa.c	2005-11-01 13:19:06.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/moxa.c	2005-12-12 21:29:08.000000000 +0000
@@ -216,7 +216,7 @@ static int moxaTimer_on;
 static struct timer_list moxaTimer;
 static int moxaEmptyTimer_on[MAX_PORTS];
 static struct timer_list moxaEmptyTimer[MAX_PORTS];
-static struct semaphore moxaBuffSem;
+static struct mutex moxaBuffSem;
 
 /*
  * static functions:
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioboot.c linux-2.6.15-rc5-mutex/drivers/char/rio/rioboot.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioboot.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/rioboot.c	2005-12-12 22:08:48.000000000 +0000
@@ -41,7 +41,7 @@ static char *_rioboot_c_sccs_ = "@(#)rio
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 
 #include <linux/termios.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/riocmd.c linux-2.6.15-rc5-mutex/drivers/char/rio/riocmd.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/riocmd.c	2005-06-22 13:51:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/riocmd.c	2005-12-12 22:08:48.000000000 +0000
@@ -41,7 +41,7 @@ static char *_riocmd_c_sccs_ = "@(#)rioc
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <linux/termios.h>
 #include <linux/serial.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioctrl.c linux-2.6.15-rc5-mutex/drivers/char/rio/rioctrl.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioctrl.c	2005-03-02 12:08:06.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/rioctrl.c	2005-12-12 22:08:48.000000000 +0000
@@ -40,7 +40,7 @@ static char *_rioctrl_c_sccs_ = "@(#)rio
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include <linux/termios.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioinit.c linux-2.6.15-rc5-mutex/drivers/char/rio/rioinit.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioinit.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/rioinit.c	2005-12-12 22:08:48.000000000 +0000
@@ -41,7 +41,7 @@ static char *_rioinit_c_sccs_ = "@(#)rio
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include <linux/termios.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/riointr.c linux-2.6.15-rc5-mutex/drivers/char/rio/riointr.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/riointr.c	2005-03-02 12:08:06.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/riointr.c	2005-12-12 22:08:48.000000000 +0000
@@ -41,7 +41,7 @@ static char *_riointr_c_sccs_ = "@(#)rio
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include <linux/termios.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioparam.c linux-2.6.15-rc5-mutex/drivers/char/rio/rioparam.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioparam.c	2004-06-18 13:41:42.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/rioparam.c	2005-12-12 22:08:48.000000000 +0000
@@ -41,7 +41,7 @@ static char *_rioparam_c_sccs_ = "@(#)ri
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include <linux/termios.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioroute.c linux-2.6.15-rc5-mutex/drivers/char/rio/rioroute.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/rioroute.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/rioroute.c	2005-12-12 22:08:48.000000000 +0000
@@ -39,7 +39,7 @@ static char *_rioroute_c_sccs_ = "@(#)ri
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include <linux/termios.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/riotable.c linux-2.6.15-rc5-mutex/drivers/char/rio/riotable.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/riotable.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/riotable.c	2005-12-12 22:08:48.000000000 +0000
@@ -42,7 +42,7 @@ static char *_riotable_c_sccs_ = "@(#)ri
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include <linux/termios.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/riotty.c linux-2.6.15-rc5-mutex/drivers/char/rio/riotty.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rio/riotty.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/rio/riotty.c	2005-12-12 22:08:48.000000000 +0000
@@ -44,7 +44,7 @@ static char *_riotty_c_sccs_ = "@(#)riot
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include <linux/termios.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rocket.c linux-2.6.15-rc5-mutex/drivers/char/rocket.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rocket.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/rocket.c	2005-12-12 22:08:48.000000000 +0000
@@ -93,7 +93,7 @@
 #include <asm/atomic.h>
 #include <linux/bitops.h>
 #include <linux/spinlock.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/init.h>
 
 /****** RocketPort includes ******/
@@ -716,7 +716,7 @@ static void init_r_port(int board, int a
 		}
 	}
 	spin_lock_init(&info->slock);
-	sema_init(&info->write_sem, 1);
+	init_MUTEX(&info->write_sem);
 	rp_table[line] = info;
 	if (pci_dev)
 		tty_register_device(rocket_driver, line, &pci_dev->dev);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/rocket_int.h linux-2.6.15-rc5-mutex/drivers/char/rocket_int.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/rocket_int.h	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/rocket_int.h	2005-12-12 20:15:24.000000000 +0000
@@ -1171,7 +1171,7 @@ struct r_port {
 	struct wait_queue *close_wait;
 #endif
 	spinlock_t slock;
-	struct semaphore write_sem;
+	struct mutex write_sem;
 };
 
 #define RPORT_MAGIC 0x525001
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/ser_a2232.c linux-2.6.15-rc5-mutex/drivers/char/ser_a2232.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/ser_a2232.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/ser_a2232.c	2005-12-12 22:08:48.000000000 +0000
@@ -97,7 +97,7 @@
 #include <asm/amigahw.h>
 #include <linux/zorro.h>
 #include <asm/irq.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <linux/delay.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/snsc.c linux-2.6.15-rc5-mutex/drivers/char/snsc.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/snsc.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/snsc.c	2005-12-12 20:16:07.000000000 +0000
@@ -99,8 +99,8 @@ scdrv_open(struct inode *inode, struct f
 	spin_lock_init(&sd->sd_wlock);
 	init_waitqueue_head(&sd->sd_rq);
 	init_waitqueue_head(&sd->sd_wq);
-	sema_init(&sd->sd_rbs, 1);
-	sema_init(&sd->sd_wbs, 1);
+	init_MUTEX(&sd->sd_rbs);
+	init_MUTEX(&sd->sd_wbs);
 
 	file->private_data = sd;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/snsc.h linux-2.6.15-rc5-mutex/drivers/char/snsc.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/snsc.h	2005-06-22 13:51:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/snsc.h	2005-12-12 22:12:49.000000000 +0000
@@ -22,8 +22,8 @@
 #include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/cdev.h>
+#include <linux/semaphore.h>
 #include <asm/sn/types.h>
-#include <asm/semaphore.h>
 
 #define CHUNKSIZE 127
 
@@ -35,8 +35,8 @@ struct subch_data_s {
 	spinlock_t sd_wlock;	/* monitor lock for wsv */
 	wait_queue_head_t sd_rq;	/* wait queue for readers */
 	wait_queue_head_t sd_wq;	/* wait queue for writers */
-	struct semaphore sd_rbs;	/* semaphore for read buffer */
-	struct semaphore sd_wbs;	/* semaphore for write buffer */
+	struct mutex sd_rbs;	/* semaphore for read buffer */
+	struct mutex sd_wbs;	/* semaphore for write buffer */
 
 	char sd_rb[CHUNKSIZE];	/* read buffer */
 	char sd_wb[CHUNKSIZE];	/* write buffer */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/sonypi.c linux-2.6.15-rc5-mutex/drivers/char/sonypi.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/sonypi.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/sonypi.c	2005-12-12 21:28:40.000000000 +0000
@@ -480,7 +480,7 @@ static struct sonypi_device {
 	u16 evtype_offset;
 	int camera_power;
 	int bluetooth_power;
-	struct semaphore lock;
+	struct mutex lock;
 	struct kfifo *fifo;
 	spinlock_t fifo_lock;
 	wait_queue_head_t fifo_proc_list;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/tpm/tpm.h linux-2.6.15-rc5-mutex/drivers/char/tpm/tpm.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/tpm/tpm.h	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/tpm/tpm.h	2005-12-12 21:28:57.000000000 +0000
@@ -74,11 +74,11 @@ struct tpm_chip {
 	/* Data passed to and from the tpm via the read/write calls */
 	u8 *data_buffer;
 	atomic_t data_pending;
-	struct semaphore buffer_mutex;
+	struct mutex buffer_mutex;
 
 	struct timer_list user_read_timer;	/* user needs to claim result */
 	struct work_struct work;
-	struct semaphore tpm_mutex;	/* tpm is processing */
+	struct mutex tpm_mutex;	/* tpm is processing */
 
 	struct tpm_vendor_specific *vendor;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/tty_io.c linux-2.6.15-rc5-mutex/drivers/char/tty_io.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/tty_io.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/tty_io.c	2005-12-12 17:48:17.000000000 +0000
@@ -2677,8 +2677,8 @@ static void initialize_tty_struct(struct
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup, tty);
-	sema_init(&tty->atomic_read, 1);
-	sema_init(&tty->atomic_write, 1);
+	init_MUTEX(&tty->atomic_read);
+	init_MUTEX(&tty->atomic_write);
 	spin_lock_init(&tty->read_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
 	INIT_WORK(&tty->SAK_work, NULL, NULL);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/viotape.c linux-2.6.15-rc5-mutex/drivers/char/viotape.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/viotape.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/viotape.c	2005-12-12 20:20:37.000000000 +0000
@@ -454,12 +454,12 @@ static ssize_t viotap_write(struct file 
 	 * semaphore
 	 */
 	if (noblock) {
-		if (down_trylock(&reqSem)) {
+		if (down_sem_trylock(&reqSem)) {
 			ret = -EWOULDBLOCK;
 			goto free_op;
 		}
 	} else
-		down(&reqSem);
+		down_sem(&reqSem);
 
 	/* Allocate a DMA buffer */
 	op->dev = tape_device[devi.devno];
@@ -515,7 +515,7 @@ static ssize_t viotap_write(struct file 
 free_dma:
 	dma_free_coherent(op->dev, count, op->buffer, op->dmaaddr);
 up_sem:
-	up(&reqSem);
+	up_sem(&reqSem);
 free_op:
 	free_op_struct(op);
 	return ret;
@@ -544,12 +544,12 @@ static ssize_t viotap_read(struct file *
 	 * semaphore
 	 */
 	if (noblock) {
-		if (down_trylock(&reqSem)) {
+		if (down_sem_trylock(&reqSem)) {
 			ret = -EWOULDBLOCK;
 			goto free_op;
 		}
 	} else
-		down(&reqSem);
+		down_sem(&reqSem);
 
 	chg_state(devi.devno, VIOT_READING, file);
 
@@ -595,7 +595,7 @@ static ssize_t viotap_read(struct file *
 free_dma:
 	dma_free_coherent(op->dev, count, op->buffer, op->dmaaddr);
 up_sem:
-	up(&reqSem);
+	up_sem(&reqSem);
 free_op:
 	free_op_struct(op);
 	return ret;
@@ -617,7 +617,7 @@ static int viotap_ioctl(struct inode *in
 
 	get_dev_info(file->f_dentry->d_inode, &devi);
 
-	down(&reqSem);
+	down_sem(&reqSem);
 
 	ret = -EINVAL;
 
@@ -748,7 +748,7 @@ static int viotap_ioctl(struct inode *in
 		/* Operation is complete - grab the error code */
 		ret = tape_rc_to_errno(op->rc, "get status", devi.devno);
 		free_op_struct(op);
-		up(&reqSem);
+		up_sem(&reqSem);
 
 		if ((ret == 0) && copy_to_user((void *)arg,
 					&viomtget[devi.devno],
@@ -766,7 +766,7 @@ static int viotap_ioctl(struct inode *in
 
 free_op:
 	free_op_struct(op);
-	up(&reqSem);
+	up_sem(&reqSem);
 	return ret;
 }
 
@@ -918,7 +918,7 @@ static void vioHandleTapeEvent(struct Hv
 			dma_free_coherent(op->dev, op->count,
 					op->buffer, op->dmaaddr);
 			free_op_struct(op);
-			up(&reqSem);
+			up_sem(&reqSem);
 		} else {
 			op->rc = tevent->sub_type_result;
 			op->count = tevent->len;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/cpu5wdt.c linux-2.6.15-rc5-mutex/drivers/char/watchdog/cpu5wdt.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/cpu5wdt.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/watchdog/cpu5wdt.c	2005-12-12 21:29:41.000000000 +0000
@@ -57,7 +57,7 @@ static int ticks = 10000;
 /* some device data */
 
 static struct {
-	struct semaphore stop;
+	struct mutex stop;
 	volatile int running;
 	struct timer_list timer;
 	volatile int queue;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/pcwd_usb.c linux-2.6.15-rc5-mutex/drivers/char/watchdog/pcwd_usb.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/pcwd_usb.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/watchdog/pcwd_usb.c	2005-12-12 21:29:35.000000000 +0000
@@ -138,7 +138,7 @@ struct usb_pcwd_private {
 	atomic_t		cmd_received;		/* true if we received a report after a command */
 
 	int			exists;			/* Wether or not the device exists */
-	struct semaphore	sem;			/* locks this structure */
+	struct mutex		sem;			/* locks this structure */
 };
 static struct usb_pcwd_private *usb_pcwd_device;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/sc1200wdt.c linux-2.6.15-rc5-mutex/drivers/char/watchdog/sc1200wdt.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/sc1200wdt.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/watchdog/sc1200wdt.c	2005-12-12 22:08:48.000000000 +0000
@@ -41,7 +41,7 @@
 #include <linux/fs.h>
 #include <linux/pci.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -74,7 +74,7 @@ static char banner[] __initdata = KERN_I
 static int timeout = 1;
 static int io = -1;
 static int io_len = 2;		/* for non plug and play */
-static struct semaphore open_sem;
+static struct mutex open_sem;
 static char expect_close;
 static spinlock_t sc1200wdt_lock;	/* io port access serialisation */
 
@@ -380,7 +380,7 @@ static int __init sc1200wdt_init(void)
 	printk(banner);
 
 	spin_lock_init(&sc1200wdt_lock);
-	sema_init(&open_sem, 1);
+	init_MUTEX(&open_sem);
 
 #if defined CONFIG_PNP
 	if (isapnp) {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/scx200_wdt.c linux-2.6.15-rc5-mutex/drivers/char/watchdog/scx200_wdt.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/scx200_wdt.c	2005-11-01 13:19:06.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/watchdog/scx200_wdt.c	2005-12-12 20:18:41.000000000 +0000
@@ -48,7 +48,7 @@ module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
 
 static u16 wdto_restart;
-static struct semaphore open_semaphore;
+static struct mutex open_semaphore;
 static char expect_close;
 
 /* Bits of the WDCNFG register */
@@ -230,7 +230,7 @@ static int __init scx200_wdt_init(void)
 	scx200_wdt_update_margin();
 	scx200_wdt_disable();
 
-	sema_init(&open_semaphore, 1);
+	init_MUTEX(&open_semaphore);
 
 	r = misc_register(&scx200_wdt_miscdev);
 	if (r) {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/wdt_pci.c linux-2.6.15-rc5-mutex/drivers/char/watchdog/wdt_pci.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/char/watchdog/wdt_pci.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/watchdog/wdt_pci.c	2005-12-12 20:18:17.000000000 +0000
@@ -74,7 +74,7 @@
 /* We can only use 1 card due to the /dev/watchdog restriction */
 static int dev_count;
 
-static struct semaphore open_sem;
+static struct mutex open_sem;
 static spinlock_t wdtpci_lock;
 static char expect_close;
 
@@ -607,7 +607,7 @@ static int __devinit wdtpci_init_one (st
 		goto out_pci;
 	}
 
-	sema_init(&open_sem, 1);
+	init_MUTEX(&open_sem);
 	spin_lock_init(&wdtpci_lock);
 
 	irq = dev->irq;
