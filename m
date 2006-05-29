Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWE2Vrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWE2Vrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWE2Vrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:47:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4024 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751328AbWE2VXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:34 -0400
Date: Mon, 29 May 2006 23:23:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 09/61] lock validator: spin/rwlock init cleanups
Message-ID: <20060529212349.GI3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

locking init cleanups:

 - convert " = SPIN_LOCK_UNLOCKED" to spin_lock_init() or DEFINE_SPINLOCK()
 - convert rwlocks in a similar manner

this patch was generated automatically.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/ia64/sn/kernel/irq.c                    |    2 +-
 arch/mips/kernel/smtc.c                      |    4 ++--
 arch/powerpc/platforms/cell/spufs/switch.c   |    2 +-
 arch/powerpc/platforms/powermac/pfunc_core.c |    2 +-
 arch/powerpc/platforms/pseries/eeh_event.c   |    2 +-
 arch/powerpc/sysdev/mmio_nvram.c             |    2 +-
 arch/xtensa/kernel/time.c                    |    2 +-
 arch/xtensa/kernel/traps.c                   |    2 +-
 drivers/char/drm/drm_memory_debug.h          |    2 +-
 drivers/char/drm/via_dmablit.c               |    2 +-
 drivers/char/epca.c                          |    2 +-
 drivers/char/moxa.c                          |    2 +-
 drivers/char/specialix.c                     |    2 +-
 drivers/char/sx.c                            |    2 +-
 drivers/isdn/gigaset/common.c                |    2 +-
 drivers/leds/led-core.c                      |    2 +-
 drivers/leds/led-triggers.c                  |    2 +-
 drivers/message/i2o/exec-osm.c               |    2 +-
 drivers/misc/ibmasm/module.c                 |    2 +-
 drivers/pcmcia/m8xx_pcmcia.c                 |    4 ++--
 drivers/rapidio/rio-access.c                 |    4 ++--
 drivers/rtc/rtc-sa1100.c                     |    2 +-
 drivers/rtc/rtc-vr41xx.c                     |    2 +-
 drivers/s390/block/dasd_eer.c                |    2 +-
 drivers/scsi/libata-core.c                   |    2 +-
 drivers/sn/ioc3.c                            |    2 +-
 drivers/usb/ip/stub_dev.c                    |    4 ++--
 drivers/usb/ip/vhci_hcd.c                    |    4 ++--
 drivers/video/backlight/hp680_bl.c           |    2 +-
 fs/gfs2/ops_fstype.c                         |    2 +-
 fs/nfsd/nfs4state.c                          |    2 +-
 fs/ocfs2/cluster/heartbeat.c                 |    2 +-
 fs/ocfs2/cluster/tcp.c                       |    2 +-
 fs/ocfs2/dlm/dlmdomain.c                     |    2 +-
 fs/ocfs2/dlm/dlmlock.c                       |    2 +-
 fs/ocfs2/dlm/dlmrecovery.c                   |    4 ++--
 fs/ocfs2/dlmglue.c                           |    2 +-
 fs/ocfs2/journal.c                           |    2 +-
 fs/reiser4/block_alloc.c                     |    2 +-
 fs/reiser4/debug.c                           |    2 +-
 fs/reiser4/fsdata.c                          |    2 +-
 fs/reiser4/txnmgr.c                          |    2 +-
 include/asm-alpha/core_t2.h                  |    2 +-
 kernel/audit.c                               |    2 +-
 mm/sparse.c                                  |    2 +-
 net/ipv6/route.c                             |    2 +-
 net/sunrpc/auth_gss/gss_krb5_seal.c          |    2 +-
 net/tipc/bcast.c                             |    4 ++--
 net/tipc/bearer.c                            |    2 +-
 net/tipc/config.c                            |    2 +-
 net/tipc/dbg.c                               |    2 +-
 net/tipc/handler.c                           |    2 +-
 net/tipc/name_table.c                        |    4 ++--
 net/tipc/net.c                               |    2 +-
 net/tipc/node.c                              |    2 +-
 net/tipc/port.c                              |    4 ++--
 net/tipc/ref.c                               |    4 ++--
 net/tipc/subscr.c                            |    2 +-
 net/tipc/user_reg.c                          |    2 +-
 59 files changed, 69 insertions(+), 69 deletions(-)

Index: linux/arch/ia64/sn/kernel/irq.c
===================================================================
--- linux.orig/arch/ia64/sn/kernel/irq.c
+++ linux/arch/ia64/sn/kernel/irq.c
@@ -27,7 +27,7 @@ static void unregister_intr_pda(struct s
 int sn_force_interrupt_flag = 1;
 extern int sn_ioif_inited;
 struct list_head **sn_irq_lh;
-static spinlock_t sn_irq_info_lock = SPIN_LOCK_UNLOCKED; /* non-IRQ lock */
+static DEFINE_SPINLOCK(sn_irq_info_lock); /* non-IRQ lock */
 
 u64 sn_intr_alloc(nasid_t local_nasid, int local_widget,
 				     struct sn_irq_info *sn_irq_info,
Index: linux/arch/mips/kernel/smtc.c
===================================================================
--- linux.orig/arch/mips/kernel/smtc.c
+++ linux/arch/mips/kernel/smtc.c
@@ -367,7 +367,7 @@ void mipsmt_prepare_cpus(void)
 	dvpe();
 	dmt();
 
-	freeIPIq.lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&freeIPIq.lock);
 
 	/*
 	 * We probably don't have as many VPEs as we do SMP "CPUs",
@@ -375,7 +375,7 @@ void mipsmt_prepare_cpus(void)
 	 */
 	for (i=0; i<NR_CPUS; i++) {
 		IPIQ[i].head = IPIQ[i].tail = NULL;
-		IPIQ[i].lock = SPIN_LOCK_UNLOCKED;
+		spin_lock_init(&IPIQ[i].lock);
 		IPIQ[i].depth = 0;
 		ipi_timer_latch[i] = 0;
 	}
Index: linux/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2183,7 +2183,7 @@ void spu_init_csa(struct spu_state *csa)
 
 	memset(lscsa, 0, sizeof(struct spu_lscsa));
 	csa->lscsa = lscsa;
-	csa->register_lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&csa->register_lock);
 
 	/* Set LS pages reserved to allow for user-space mapping. */
 	for (p = lscsa->ls; p < lscsa->ls + LS_SIZE; p += PAGE_SIZE)
Index: linux/arch/powerpc/platforms/powermac/pfunc_core.c
===================================================================
--- linux.orig/arch/powerpc/platforms/powermac/pfunc_core.c
+++ linux/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -545,7 +545,7 @@ struct pmf_device {
 };
 
 static LIST_HEAD(pmf_devices);
-static spinlock_t pmf_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(pmf_lock);
 
 static void pmf_release_device(struct kref *kref)
 {
Index: linux/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- linux.orig/arch/powerpc/platforms/pseries/eeh_event.c
+++ linux/arch/powerpc/platforms/pseries/eeh_event.c
@@ -35,7 +35,7 @@
  */
 
 /* EEH event workqueue setup. */
-static spinlock_t eeh_eventlist_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(eeh_eventlist_lock);
 LIST_HEAD(eeh_eventlist);
 static void eeh_thread_launcher(void *);
 DECLARE_WORK(eeh_event_wq, eeh_thread_launcher, NULL);
Index: linux/arch/powerpc/sysdev/mmio_nvram.c
===================================================================
--- linux.orig/arch/powerpc/sysdev/mmio_nvram.c
+++ linux/arch/powerpc/sysdev/mmio_nvram.c
@@ -32,7 +32,7 @@
 
 static void __iomem *mmio_nvram_start;
 static long mmio_nvram_len;
-static spinlock_t mmio_nvram_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(mmio_nvram_lock);
 
 static ssize_t mmio_nvram_read(char *buf, size_t count, loff_t *index)
 {
Index: linux/arch/xtensa/kernel/time.c
===================================================================
--- linux.orig/arch/xtensa/kernel/time.c
+++ linux/arch/xtensa/kernel/time.c
@@ -29,7 +29,7 @@
 
 extern volatile unsigned long wall_jiffies;
 
-spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
 
Index: linux/arch/xtensa/kernel/traps.c
===================================================================
--- linux.orig/arch/xtensa/kernel/traps.c
+++ linux/arch/xtensa/kernel/traps.c
@@ -461,7 +461,7 @@ void show_code(unsigned int *pc)
 	}
 }
 
-spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(die_lock);
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
Index: linux/drivers/char/drm/drm_memory_debug.h
===================================================================
--- linux.orig/drivers/char/drm/drm_memory_debug.h
+++ linux/drivers/char/drm/drm_memory_debug.h
@@ -43,7 +43,7 @@ typedef struct drm_mem_stats {
 	unsigned long bytes_freed;
 } drm_mem_stats_t;
 
-static spinlock_t drm_mem_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(drm_mem_lock);
 static unsigned long drm_ram_available = 0;	/* In pages */
 static unsigned long drm_ram_used = 0;
 static drm_mem_stats_t drm_mem_stats[] =
Index: linux/drivers/char/drm/via_dmablit.c
===================================================================
--- linux.orig/drivers/char/drm/via_dmablit.c
+++ linux/drivers/char/drm/via_dmablit.c
@@ -557,7 +557,7 @@ via_init_dmablit(drm_device_t *dev)
 		blitq->num_outstanding = 0;
 		blitq->is_active = 0;
 		blitq->aborting = 0;
-		blitq->blit_lock = SPIN_LOCK_UNLOCKED;
+		spin_lock_init(&blitq->blit_lock);
 		for (j=0; j<VIA_NUM_BLIT_SLOTS; ++j) {
 			DRM_INIT_WAITQUEUE(blitq->blit_queue + j);
 		}
Index: linux/drivers/char/epca.c
===================================================================
--- linux.orig/drivers/char/epca.c
+++ linux/drivers/char/epca.c
@@ -80,7 +80,7 @@ static int invalid_lilo_config;
 /* The ISA boards do window flipping into the same spaces so its only sane
    with a single lock. It's still pretty efficient */
 
-static spinlock_t epca_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(epca_lock);
 
 /* -----------------------------------------------------------------------
 	MAXBOARDS is typically 12, but ISA and EISA cards are restricted to 
Index: linux/drivers/char/moxa.c
===================================================================
--- linux.orig/drivers/char/moxa.c
+++ linux/drivers/char/moxa.c
@@ -301,7 +301,7 @@ static struct tty_operations moxa_ops = 
 	.tiocmset = moxa_tiocmset,
 };
 
-static spinlock_t moxa_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(moxa_lock);
 
 #ifdef CONFIG_PCI
 static int moxa_get_PCI_conf(struct pci_dev *p, int board_type, moxa_board_conf * board)
Index: linux/drivers/char/specialix.c
===================================================================
--- linux.orig/drivers/char/specialix.c
+++ linux/drivers/char/specialix.c
@@ -2477,7 +2477,7 @@ static int __init specialix_init(void)
 #endif
 
 	for (i = 0; i < SX_NBOARD; i++)
-		sx_board[i].lock = SPIN_LOCK_UNLOCKED;
+		spin_lock_init(&sx_board[i].lock);
 
 	if (sx_init_drivers()) {
 		func_exit();
Index: linux/drivers/char/sx.c
===================================================================
--- linux.orig/drivers/char/sx.c
+++ linux/drivers/char/sx.c
@@ -2320,7 +2320,7 @@ static int sx_init_portstructs (int nboa
 #ifdef NEW_WRITE_LOCKING
 			port->gs.port_write_mutex = MUTEX;
 #endif
-			port->gs.driver_lock = SPIN_LOCK_UNLOCKED;
+			spin_lock_init(&port->gs.driver_lock);
 			/*
 			 * Initializing wait queue
 			 */
Index: linux/drivers/isdn/gigaset/common.c
===================================================================
--- linux.orig/drivers/isdn/gigaset/common.c
+++ linux/drivers/isdn/gigaset/common.c
@@ -981,7 +981,7 @@ exit:
 EXPORT_SYMBOL_GPL(gigaset_stop);
 
 static LIST_HEAD(drivers);
-static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(driver_lock);
 
 struct cardstate *gigaset_get_cs_by_id(int id)
 {
Index: linux/drivers/leds/led-core.c
===================================================================
--- linux.orig/drivers/leds/led-core.c
+++ linux/drivers/leds/led-core.c
@@ -18,7 +18,7 @@
 #include <linux/leds.h>
 #include "leds.h"
 
-rwlock_t leds_list_lock = RW_LOCK_UNLOCKED;
+DEFINE_RWLOCK(leds_list_lock);
 LIST_HEAD(leds_list);
 
 EXPORT_SYMBOL_GPL(leds_list);
Index: linux/drivers/leds/led-triggers.c
===================================================================
--- linux.orig/drivers/leds/led-triggers.c
+++ linux/drivers/leds/led-triggers.c
@@ -26,7 +26,7 @@
 /*
  * Nests outside led_cdev->trigger_lock
  */
-static rwlock_t triggers_list_lock = RW_LOCK_UNLOCKED;
+static DEFINE_RWLOCK(triggers_list_lock);
 static LIST_HEAD(trigger_list);
 
 ssize_t led_trigger_store(struct class_device *dev, const char *buf,
Index: linux/drivers/message/i2o/exec-osm.c
===================================================================
--- linux.orig/drivers/message/i2o/exec-osm.c
+++ linux/drivers/message/i2o/exec-osm.c
@@ -213,7 +213,7 @@ static int i2o_msg_post_wait_complete(st
 {
 	struct i2o_exec_wait *wait, *tmp;
 	unsigned long flags;
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(lock);
 	int rc = 1;
 
 	/*
Index: linux/drivers/misc/ibmasm/module.c
===================================================================
--- linux.orig/drivers/misc/ibmasm/module.c
+++ linux/drivers/misc/ibmasm/module.c
@@ -85,7 +85,7 @@ static int __devinit ibmasm_init_one(str
 	}
 	memset(sp, 0, sizeof(struct service_processor));
 
-	sp->lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&sp->lock);
 	INIT_LIST_HEAD(&sp->command_queue);
 
 	pci_set_drvdata(pdev, (void *)sp);
Index: linux/drivers/pcmcia/m8xx_pcmcia.c
===================================================================
--- linux.orig/drivers/pcmcia/m8xx_pcmcia.c
+++ linux/drivers/pcmcia/m8xx_pcmcia.c
@@ -157,7 +157,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 
 static int pcmcia_schlvl = PCMCIA_SCHLVL;
 
-static spinlock_t events_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(events_lock);
 
 
 #define PCMCIA_SOCKET_KEY_5V 1
@@ -644,7 +644,7 @@ static struct platform_device m8xx_devic
 };
 
 static u32 pending_events[PCMCIA_SOCKETS_NO];
-static spinlock_t pending_event_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(pending_event_lock);
 
 static irqreturn_t m8xx_interrupt(int irq, void *dev, struct pt_regs *regs)
 {
Index: linux/drivers/rapidio/rio-access.c
===================================================================
--- linux.orig/drivers/rapidio/rio-access.c
+++ linux/drivers/rapidio/rio-access.c
@@ -17,8 +17,8 @@
  * These interrupt-safe spinlocks protect all accesses to RIO
  * configuration space and doorbell access.
  */
-static spinlock_t rio_config_lock = SPIN_LOCK_UNLOCKED;
-static spinlock_t rio_doorbell_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(rio_config_lock);
+static DEFINE_SPINLOCK(rio_doorbell_lock);
 
 /*
  *  Wrappers for all RIO configuration access functions.  They just check
Index: linux/drivers/rtc/rtc-sa1100.c
===================================================================
--- linux.orig/drivers/rtc/rtc-sa1100.c
+++ linux/drivers/rtc/rtc-sa1100.c
@@ -45,7 +45,7 @@
 
 static unsigned long rtc_freq = 1024;
 static struct rtc_time rtc_alarm;
-static spinlock_t sa1100_rtc_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(sa1100_rtc_lock);
 
 static int rtc_update_alarm(struct rtc_time *alrm)
 {
Index: linux/drivers/rtc/rtc-vr41xx.c
===================================================================
--- linux.orig/drivers/rtc/rtc-vr41xx.c
+++ linux/drivers/rtc/rtc-vr41xx.c
@@ -93,7 +93,7 @@ static void __iomem *rtc2_base;
 
 static unsigned long epoch = 1970;	/* Jan 1 1970 00:00:00 */
 
-static spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(rtc_lock);
 static char rtc_name[] = "RTC";
 static unsigned long periodic_frequency;
 static unsigned long periodic_count;
Index: linux/drivers/s390/block/dasd_eer.c
===================================================================
--- linux.orig/drivers/s390/block/dasd_eer.c
+++ linux/drivers/s390/block/dasd_eer.c
@@ -89,7 +89,7 @@ struct eerbuffer {
 };
 
 static LIST_HEAD(bufferlist);
-static spinlock_t bufferlock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(bufferlock);
 static DECLARE_WAIT_QUEUE_HEAD(dasd_eer_read_wait_queue);
 
 /*
Index: linux/drivers/scsi/libata-core.c
===================================================================
--- linux.orig/drivers/scsi/libata-core.c
+++ linux/drivers/scsi/libata-core.c
@@ -5605,7 +5605,7 @@ module_init(ata_init);
 module_exit(ata_exit);
 
 static unsigned long ratelimit_time;
-static spinlock_t ata_ratelimit_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(ata_ratelimit_lock);
 
 int ata_ratelimit(void)
 {
Index: linux/drivers/sn/ioc3.c
===================================================================
--- linux.orig/drivers/sn/ioc3.c
+++ linux/drivers/sn/ioc3.c
@@ -26,7 +26,7 @@ static DECLARE_RWSEM(ioc3_devices_rwsem)
 
 static struct ioc3_submodule *ioc3_submodules[IOC3_MAX_SUBMODULES];
 static struct ioc3_submodule *ioc3_ethernet;
-static rwlock_t ioc3_submodules_lock = RW_LOCK_UNLOCKED;
+static DEFINE_RWLOCK(ioc3_submodules_lock);
 
 /* NIC probing code */
 
Index: linux/drivers/usb/ip/stub_dev.c
===================================================================
--- linux.orig/drivers/usb/ip/stub_dev.c
+++ linux/drivers/usb/ip/stub_dev.c
@@ -285,13 +285,13 @@ static struct stub_device * stub_device_
 
 	sdev->ud.side = USBIP_STUB;
 	sdev->ud.status = SDEV_ST_AVAILABLE;
-	sdev->ud.lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&sdev->ud.lock);
 	sdev->ud.tcp_socket = NULL;
 
 	INIT_LIST_HEAD(&sdev->priv_init);
 	INIT_LIST_HEAD(&sdev->priv_tx);
 	INIT_LIST_HEAD(&sdev->priv_free);
-	sdev->priv_lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&sdev->priv_lock);
 
 	sdev->ud.eh_ops.shutdown = stub_shutdown_connection;
 	sdev->ud.eh_ops.reset    = stub_device_reset;
Index: linux/drivers/usb/ip/vhci_hcd.c
===================================================================
--- linux.orig/drivers/usb/ip/vhci_hcd.c
+++ linux/drivers/usb/ip/vhci_hcd.c
@@ -768,11 +768,11 @@ static void vhci_device_init(struct vhci
 
 	vdev->ud.side   = USBIP_VHCI;
 	vdev->ud.status = VDEV_ST_NULL;
-	vdev->ud.lock   = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&vdev->ud.lock  );
 
 	INIT_LIST_HEAD(&vdev->priv_rx);
 	INIT_LIST_HEAD(&vdev->priv_tx);
-	vdev->priv_lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&vdev->priv_lock);
 
 	init_waitqueue_head(&vdev->waitq);
 
Index: linux/drivers/video/backlight/hp680_bl.c
===================================================================
--- linux.orig/drivers/video/backlight/hp680_bl.c
+++ linux/drivers/video/backlight/hp680_bl.c
@@ -27,7 +27,7 @@
 
 static int hp680bl_suspended;
 static int current_intensity = 0;
-static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(bl_lock);
 static struct backlight_device *hp680_backlight_device;
 
 static void hp680bl_send_intensity(struct backlight_device *bd)
Index: linux/fs/gfs2/ops_fstype.c
===================================================================
--- linux.orig/fs/gfs2/ops_fstype.c
+++ linux/fs/gfs2/ops_fstype.c
@@ -58,7 +58,7 @@ static struct gfs2_sbd *init_sbd(struct 
 	gfs2_tune_init(&sdp->sd_tune);
 
 	for (x = 0; x < GFS2_GL_HASH_SIZE; x++) {
-		sdp->sd_gl_hash[x].hb_lock = RW_LOCK_UNLOCKED;
+		rwlock_init(&sdp->sd_gl_hash[x].hb_lock);
 		INIT_LIST_HEAD(&sdp->sd_gl_hash[x].hb_list);
 	}
 	INIT_LIST_HEAD(&sdp->sd_reclaim_list);
Index: linux/fs/nfsd/nfs4state.c
===================================================================
--- linux.orig/fs/nfsd/nfs4state.c
+++ linux/fs/nfsd/nfs4state.c
@@ -123,7 +123,7 @@ static void release_stateid(struct nfs4_
  */
 
 /* recall_lock protects the del_recall_lru */
-static spinlock_t recall_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(recall_lock);
 static struct list_head del_recall_lru;
 
 static void
Index: linux/fs/ocfs2/cluster/heartbeat.c
===================================================================
--- linux.orig/fs/ocfs2/cluster/heartbeat.c
+++ linux/fs/ocfs2/cluster/heartbeat.c
@@ -54,7 +54,7 @@ static DECLARE_RWSEM(o2hb_callback_sem);
  * multiple hb threads are watching multiple regions.  A node is live
  * whenever any of the threads sees activity from the node in its region.
  */
-static spinlock_t o2hb_live_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(o2hb_live_lock);
 static struct list_head o2hb_live_slots[O2NM_MAX_NODES];
 static unsigned long o2hb_live_node_bitmap[BITS_TO_LONGS(O2NM_MAX_NODES)];
 static LIST_HEAD(o2hb_node_events);
Index: linux/fs/ocfs2/cluster/tcp.c
===================================================================
--- linux.orig/fs/ocfs2/cluster/tcp.c
+++ linux/fs/ocfs2/cluster/tcp.c
@@ -107,7 +107,7 @@
 	    ##args);							\
 } while (0)
 
-static rwlock_t o2net_handler_lock = RW_LOCK_UNLOCKED;
+static DEFINE_RWLOCK(o2net_handler_lock);
 static struct rb_root o2net_handler_tree = RB_ROOT;
 
 static struct o2net_node o2net_nodes[O2NM_MAX_NODES];
Index: linux/fs/ocfs2/dlm/dlmdomain.c
===================================================================
--- linux.orig/fs/ocfs2/dlm/dlmdomain.c
+++ linux/fs/ocfs2/dlm/dlmdomain.c
@@ -88,7 +88,7 @@ out_free:
  *
  */
 
-spinlock_t dlm_domain_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(dlm_domain_lock);
 LIST_HEAD(dlm_domains);
 static DECLARE_WAIT_QUEUE_HEAD(dlm_domain_events);
 
Index: linux/fs/ocfs2/dlm/dlmlock.c
===================================================================
--- linux.orig/fs/ocfs2/dlm/dlmlock.c
+++ linux/fs/ocfs2/dlm/dlmlock.c
@@ -53,7 +53,7 @@
 #define MLOG_MASK_PREFIX ML_DLM
 #include "cluster/masklog.h"
 
-static spinlock_t dlm_cookie_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(dlm_cookie_lock);
 static u64 dlm_next_cookie = 1;
 
 static enum dlm_status dlm_send_remote_lock_request(struct dlm_ctxt *dlm,
Index: linux/fs/ocfs2/dlm/dlmrecovery.c
===================================================================
--- linux.orig/fs/ocfs2/dlm/dlmrecovery.c
+++ linux/fs/ocfs2/dlm/dlmrecovery.c
@@ -101,8 +101,8 @@ static int dlm_lockres_master_requery(st
 
 static u64 dlm_get_next_mig_cookie(void);
 
-static spinlock_t dlm_reco_state_lock = SPIN_LOCK_UNLOCKED;
-static spinlock_t dlm_mig_cookie_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(dlm_reco_state_lock);
+static DEFINE_SPINLOCK(dlm_mig_cookie_lock);
 static u64 dlm_mig_cookie = 1;
 
 static u64 dlm_get_next_mig_cookie(void)
Index: linux/fs/ocfs2/dlmglue.c
===================================================================
--- linux.orig/fs/ocfs2/dlmglue.c
+++ linux/fs/ocfs2/dlmglue.c
@@ -242,7 +242,7 @@ static void ocfs2_build_lock_name(enum o
 	mlog_exit_void();
 }
 
-static spinlock_t ocfs2_dlm_tracking_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(ocfs2_dlm_tracking_lock);
 
 static void ocfs2_add_lockres_tracking(struct ocfs2_lock_res *res,
 				       struct ocfs2_dlm_debug *dlm_debug)
Index: linux/fs/ocfs2/journal.c
===================================================================
--- linux.orig/fs/ocfs2/journal.c
+++ linux/fs/ocfs2/journal.c
@@ -49,7 +49,7 @@
 
 #include "buffer_head_io.h"
 
-spinlock_t trans_inc_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(trans_inc_lock);
 
 static int ocfs2_force_read_journal(struct inode *inode);
 static int ocfs2_recover_node(struct ocfs2_super *osb,
Index: linux/fs/reiser4/block_alloc.c
===================================================================
--- linux.orig/fs/reiser4/block_alloc.c
+++ linux/fs/reiser4/block_alloc.c
@@ -499,7 +499,7 @@ void cluster_reserved2free(int count)
 	spin_unlock_reiser4_super(sbinfo);
 }
 
-static spinlock_t fake_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(fake_lock);
 static reiser4_block_nr fake_gen = 0;
 
 /* obtain a block number for new formatted node which will be used to refer
Index: linux/fs/reiser4/debug.c
===================================================================
--- linux.orig/fs/reiser4/debug.c
+++ linux/fs/reiser4/debug.c
@@ -52,7 +52,7 @@ static char panic_buf[REISER4_PANIC_MSG_
 /*
  * lock protecting consistency of panic_buf under concurrent panics
  */
-static spinlock_t panic_guard = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(panic_guard);
 
 /* Your best friend. Call it on each occasion.  This is called by
     fs/reiser4/debug.h:reiser4_panic(). */
Index: linux/fs/reiser4/fsdata.c
===================================================================
--- linux.orig/fs/reiser4/fsdata.c
+++ linux/fs/reiser4/fsdata.c
@@ -17,7 +17,7 @@ static LIST_HEAD(cursor_cache);
 static unsigned long d_cursor_unused = 0;
 
 /* spinlock protecting manipulations with dir_cursor's hash table and lists */
-spinlock_t d_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(d_lock);
 
 static reiser4_file_fsdata *create_fsdata(struct file *file);
 static int file_is_stateless(struct file *file);
Index: linux/fs/reiser4/txnmgr.c
===================================================================
--- linux.orig/fs/reiser4/txnmgr.c
+++ linux/fs/reiser4/txnmgr.c
@@ -905,7 +905,7 @@ jnode *find_first_dirty_jnode(txn_atom *
 
 /* this spin lock is used to prevent races during steal on capture.
    FIXME: should be per filesystem or even per atom */
-spinlock_t scan_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(scan_lock);
 
 /* Scan atom->writeback_nodes list and dispatch jnodes according to their state:
  * move dirty and !writeback jnodes to @fq, clean jnodes to atom's clean
Index: linux/include/asm-alpha/core_t2.h
===================================================================
--- linux.orig/include/asm-alpha/core_t2.h
+++ linux/include/asm-alpha/core_t2.h
@@ -435,7 +435,7 @@ static inline void t2_outl(u32 b, unsign
 	set_hae(msb); \
 }
 
-static spinlock_t t2_hae_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(t2_hae_lock);
 
 __EXTERN_INLINE u8 t2_readb(const volatile void __iomem *xaddr)
 {
Index: linux/kernel/audit.c
===================================================================
--- linux.orig/kernel/audit.c
+++ linux/kernel/audit.c
@@ -787,7 +787,7 @@ err:
  */
 unsigned int audit_serial(void)
 {
-	static spinlock_t serial_lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(serial_lock);
 	static unsigned int serial = 0;
 
 	unsigned long flags;
Index: linux/mm/sparse.c
===================================================================
--- linux.orig/mm/sparse.c
+++ linux/mm/sparse.c
@@ -45,7 +45,7 @@ static struct mem_section *sparse_index_
 
 static int sparse_index_init(unsigned long section_nr, int nid)
 {
-	static spinlock_t index_init_lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(index_init_lock);
 	unsigned long root = SECTION_NR_TO_ROOT(section_nr);
 	struct mem_section *section;
 	int ret = 0;
Index: linux/net/ipv6/route.c
===================================================================
--- linux.orig/net/ipv6/route.c
+++ linux/net/ipv6/route.c
@@ -343,7 +343,7 @@ static struct rt6_info *rt6_select(struc
 	    (strict & RT6_SELECT_F_REACHABLE) &&
 	    last && last != rt0) {
 		/* no entries matched; do round-robin */
-		static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+		static DEFINE_SPINLOCK(lock);
 		spin_lock(&lock);
 		*head = rt0->u.next;
 		rt0->u.next = last->u.next;
Index: linux/net/sunrpc/auth_gss/gss_krb5_seal.c
===================================================================
--- linux.orig/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ linux/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -70,7 +70,7 @@
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
 
-spinlock_t krb5_seq_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(krb5_seq_lock);
 
 u32
 gss_get_mic_kerberos(struct gss_ctx *gss_ctx, struct xdr_buf *text,
Index: linux/net/tipc/bcast.c
===================================================================
--- linux.orig/net/tipc/bcast.c
+++ linux/net/tipc/bcast.c
@@ -102,7 +102,7 @@ struct bclink {
 static struct bcbearer *bcbearer = NULL;
 static struct bclink *bclink = NULL;
 static struct link *bcl = NULL;
-static spinlock_t bc_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(bc_lock);
 
 char tipc_bclink_name[] = "multicast-link";
 
@@ -783,7 +783,7 @@ int tipc_bclink_init(void)
 	memset(bclink, 0, sizeof(struct bclink));
 	INIT_LIST_HEAD(&bcl->waiting_ports);
 	bcl->next_out_no = 1;
-	bclink->node.lock =  SPIN_LOCK_UNLOCKED;        
+	spin_lock_init(&bclink->node.lock);
 	bcl->owner = &bclink->node;
         bcl->max_pkt = MAX_PKT_DEFAULT_MCAST;
 	tipc_link_set_queue_limits(bcl, BCLINK_WIN_DEFAULT);
Index: linux/net/tipc/bearer.c
===================================================================
--- linux.orig/net/tipc/bearer.c
+++ linux/net/tipc/bearer.c
@@ -552,7 +552,7 @@ restart:
 		b_ptr->link_req = tipc_disc_init_link_req(b_ptr, &m_ptr->bcast_addr,
 							  bcast_scope, 2);
 	}
-	b_ptr->publ.lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&b_ptr->publ.lock);
 	write_unlock_bh(&tipc_net_lock);
 	info("Enabled bearer <%s>, discovery domain %s, priority %u\n",
 	     name, addr_string_fill(addr_string, bcast_scope), priority);
Index: linux/net/tipc/config.c
===================================================================
--- linux.orig/net/tipc/config.c
+++ linux/net/tipc/config.c
@@ -63,7 +63,7 @@ struct manager {
 
 static struct manager mng = { 0};
 
-static spinlock_t config_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(config_lock);
 
 static const void *req_tlv_area;	/* request message TLV area */
 static int req_tlv_space;		/* request message TLV area size */
Index: linux/net/tipc/dbg.c
===================================================================
--- linux.orig/net/tipc/dbg.c
+++ linux/net/tipc/dbg.c
@@ -41,7 +41,7 @@
 #define MAX_STRING 512
 
 static char print_string[MAX_STRING];
-static spinlock_t print_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(print_lock);
 
 static struct print_buf cons_buf = { NULL, 0, NULL, NULL };
 struct print_buf *TIPC_CONS = &cons_buf;
Index: linux/net/tipc/handler.c
===================================================================
--- linux.orig/net/tipc/handler.c
+++ linux/net/tipc/handler.c
@@ -44,7 +44,7 @@ struct queue_item {
 
 static kmem_cache_t *tipc_queue_item_cache;
 static struct list_head signal_queue_head;
-static spinlock_t qitem_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(qitem_lock);
 static int handler_enabled = 0;
 
 static void process_signal_queue(unsigned long dummy);
Index: linux/net/tipc/name_table.c
===================================================================
--- linux.orig/net/tipc/name_table.c
+++ linux/net/tipc/name_table.c
@@ -101,7 +101,7 @@ struct name_table {
 
 static struct name_table table = { NULL } ;
 static atomic_t rsv_publ_ok = ATOMIC_INIT(0);
-rwlock_t tipc_nametbl_lock = RW_LOCK_UNLOCKED;
+DEFINE_RWLOCK(tipc_nametbl_lock);
 
 
 static int hash(int x)
@@ -172,7 +172,7 @@ static struct name_seq *tipc_nameseq_cre
 	}
 
 	memset(nseq, 0, sizeof(*nseq));
-	nseq->lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&nseq->lock);
 	nseq->type = type;
 	nseq->sseqs = sseq;
 	dbg("tipc_nameseq_create() nseq = %x type %u, ssseqs %x, ff: %u\n",
Index: linux/net/tipc/net.c
===================================================================
--- linux.orig/net/tipc/net.c
+++ linux/net/tipc/net.c
@@ -115,7 +115,7 @@
  *     - A local spin_lock protecting the queue of subscriber events.
 */
 
-rwlock_t tipc_net_lock = RW_LOCK_UNLOCKED;
+DEFINE_RWLOCK(tipc_net_lock);
 struct network tipc_net = { NULL };
 
 struct node *tipc_net_select_remote_node(u32 addr, u32 ref) 
Index: linux/net/tipc/node.c
===================================================================
--- linux.orig/net/tipc/node.c
+++ linux/net/tipc/node.c
@@ -64,7 +64,7 @@ struct node *tipc_node_create(u32 addr)
         if (n_ptr != NULL) {
                 memset(n_ptr, 0, sizeof(*n_ptr));
                 n_ptr->addr = addr;
-                n_ptr->lock =  SPIN_LOCK_UNLOCKED;	
+                spin_lock_init(&n_ptr->lock);
                 INIT_LIST_HEAD(&n_ptr->nsub);
 	
 		c_ptr = tipc_cltr_find(addr);
Index: linux/net/tipc/port.c
===================================================================
--- linux.orig/net/tipc/port.c
+++ linux/net/tipc/port.c
@@ -57,8 +57,8 @@
 static struct sk_buff *msg_queue_head = NULL;
 static struct sk_buff *msg_queue_tail = NULL;
 
-spinlock_t tipc_port_list_lock = SPIN_LOCK_UNLOCKED;
-static spinlock_t queue_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(tipc_port_list_lock);
+static DEFINE_SPINLOCK(queue_lock);
 
 static LIST_HEAD(ports);
 static void port_handle_node_down(unsigned long ref);
Index: linux/net/tipc/ref.c
===================================================================
--- linux.orig/net/tipc/ref.c
+++ linux/net/tipc/ref.c
@@ -63,7 +63,7 @@
 
 struct ref_table tipc_ref_table = { NULL };
 
-static rwlock_t ref_table_lock = RW_LOCK_UNLOCKED;
+static DEFINE_RWLOCK(ref_table_lock);
 
 /**
  * tipc_ref_table_init - create reference table for objects
@@ -87,7 +87,7 @@ int tipc_ref_table_init(u32 requested_si
 	index_mask = sz - 1;
 	for (i = sz - 1; i >= 0; i--) {
 		table[i].object = NULL;
-		table[i].lock = SPIN_LOCK_UNLOCKED;
+		spin_lock_init(&table[i].lock);
 		table[i].data.next_plus_upper = (start & ~index_mask) + i - 1;
 	}
 	tipc_ref_table.entries = table;
Index: linux/net/tipc/subscr.c
===================================================================
--- linux.orig/net/tipc/subscr.c
+++ linux/net/tipc/subscr.c
@@ -457,7 +457,7 @@ int tipc_subscr_start(void)
 	int res = -1;
 
 	memset(&topsrv, 0, sizeof (topsrv));
-	topsrv.lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&topsrv.lock);
 	INIT_LIST_HEAD(&topsrv.subscriber_list);
 
 	spin_lock_bh(&topsrv.lock);
Index: linux/net/tipc/user_reg.c
===================================================================
--- linux.orig/net/tipc/user_reg.c
+++ linux/net/tipc/user_reg.c
@@ -67,7 +67,7 @@ struct tipc_user {
 
 static struct tipc_user *users = NULL;
 static u32 next_free_user = MAX_USERID + 1;
-static spinlock_t reg_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(reg_lock);
 
 /**
  * reg_init - create TIPC user registry (but don't activate it)
