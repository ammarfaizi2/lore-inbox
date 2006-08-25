Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWHYSZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWHYSZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422779AbWHYSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:53 -0400
Received: from mx.pathscale.com ([64.160.42.68]:42114 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422745AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 23] IB/ipath - merge ipath_core and ib_ipath drivers
X-Mercurial-Node: f8ba658a13d8fe5fe748d6f27b53a43b1dada8df
Message-Id: <f8ba658a13d8fe5fe748.1156530271@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:31 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is little point in keeping the two drivers separate, so we are
merging them.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/Makefile b/drivers/infiniband/Makefile
--- a/drivers/infiniband/Makefile	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/Makefile	Fri Aug 25 11:19:45 2006 -0700
@@ -1,6 +1,6 @@ obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
-obj-$(CONFIG_IPATH_CORE)		+= hw/ipath/
+obj-$(CONFIG_INFINIBAND_IPATH)		+= hw/ipath/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
 obj-$(CONFIG_INFINIBAND_ISER)		+= ulp/iser/
diff --git a/drivers/infiniband/hw/ipath/Kconfig b/drivers/infiniband/hw/ipath/Kconfig
--- a/drivers/infiniband/hw/ipath/Kconfig	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/Kconfig	Fri Aug 25 11:19:45 2006 -0700
@@ -1,16 +1,9 @@ config IPATH_CORE
-config IPATH_CORE
+config INFINIBAND_IPATH
 	tristate "QLogic InfiniPath Driver"
-	depends on 64BIT && PCI_MSI && NET
+	depends on PCI_MSI && 64BIT && INFINIBAND
 	---help---
-	This is a low-level driver for QLogic InfiniPath host channel
-	adapters (HCAs) based on the HT-400 and PE-800 chips.
-
-config INFINIBAND_IPATH
-	tristate "QLogic InfiniPath Verbs Driver"
-	depends on IPATH_CORE && INFINIBAND
-	---help---
-	This is a driver that provides InfiniBand verbs support for
-	QLogic InfiniPath host channel adapters (HCAs).  This
-	allows these devices to be used with both kernel upper level
-	protocols such as IP-over-InfiniBand as well as with userspace
-	applications (in conjunction with InfiniBand userspace access).
+	This is a driver for QLogic InfiniPath host channel adapters,
+	including InfiniBand verbs support.  This driver allows these
+	devices to be used with both kernel upper level protocols such
+	as IP-over-InfiniBand as well as with userspace applications
+	(in conjunction with InfiniBand userspace access).
diff --git a/drivers/infiniband/hw/ipath/Makefile b/drivers/infiniband/hw/ipath/Makefile
--- a/drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:45 2006 -0700
@@ -1,10 +1,10 @@ EXTRA_CFLAGS += -DIPATH_IDSTR='"QLogic k
 EXTRA_CFLAGS += -DIPATH_IDSTR='"QLogic kernel.org driver"' \
 	-DIPATH_KERN_TYPE=0
 
-obj-$(CONFIG_IPATH_CORE) += ipath_core.o
 obj-$(CONFIG_INFINIBAND_IPATH) += ib_ipath.o
 
-ipath_core-y := \
+ib_ipath-y := \
+	ipath_cq.o \
 	ipath_diag.o \
 	ipath_driver.o \
 	ipath_eeprom.o \
@@ -13,26 +13,23 @@ ipath_core-y := \
 	ipath_ht400.o \
 	ipath_init_chip.o \
 	ipath_intr.o \
+	ipath_keys.o \
 	ipath_layer.o \
-	ipath_pe800.o \
-	ipath_stats.o \
-	ipath_sysfs.o \
-	ipath_user_pages.o
-
-ipath_core-$(CONFIG_X86_64) += ipath_wc_x86_64.o
-ipath_core-$(CONFIG_PPC64) += ipath_wc_ppc64.o
-
-ib_ipath-y := \
-	ipath_cq.o \
-	ipath_keys.o \
 	ipath_mad.o \
 	ipath_mmap.o \
 	ipath_mr.o \
+	ipath_pe800.o \
 	ipath_qp.o \
 	ipath_rc.o \
 	ipath_ruc.o \
 	ipath_srq.o \
+	ipath_stats.o \
+	ipath_sysfs.o \
 	ipath_uc.o \
 	ipath_ud.o \
-	ipath_verbs.o \
-	ipath_verbs_mcast.o
+	ipath_user_pages.o \
+	ipath_verbs_mcast.o \
+	ipath_verbs.o
+
+ib_ipath-$(CONFIG_X86_64) += ipath_wc_x86_64.o
+ib_ipath-$(CONFIG_PPC64) += ipath_wc_ppc64.o
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
@@ -40,6 +40,7 @@
 
 #include "ipath_kernel.h"
 #include "ipath_layer.h"
+#include "ipath_verbs.h"
 #include "ipath_common.h"
 
 static void ipath_update_pio_bufs(struct ipath_devdata *);
@@ -50,8 +51,6 @@ const char *ipath_get_unit_name(int unit
 	snprintf(iname, sizeof iname, "infinipath%u", unit);
 	return iname;
 }
-
-EXPORT_SYMBOL_GPL(ipath_get_unit_name);
 
 #define DRIVER_LOAD_MSG "QLogic " IPATH_DRV_NAME " loaded: "
 #define PFX IPATH_DRV_NAME ": "
@@ -510,6 +509,7 @@ static int __devinit ipath_init_one(stru
 	ipath_user_add(dd);
 	ipath_diag_add(dd);
 	ipath_layer_add(dd);
+	ipath_register_ib_device(dd);
 
 	goto bail;
 
@@ -538,6 +538,7 @@ static void __devexit ipath_remove_one(s
 		return;
 
 	dd = pci_get_drvdata(pdev);
+	ipath_unregister_ib_device(dd->verbs_dev);
 	ipath_layer_remove(dd);
 	ipath_diag_remove(dd);
 	ipath_user_remove(dd);
@@ -978,12 +979,8 @@ reloop:
 		if (unlikely(eflags))
 			ipath_rcv_hdrerr(dd, eflags, l, etail, rc);
 		else if (etype == RCVHQ_RCV_TYPE_NON_KD) {
-				int ret = __ipath_verbs_rcv(dd, rc + 1,
-							    ebuf, tlen);
-				if (ret == -ENODEV)
-					ipath_cdbg(VERBOSE,
-						   "received IB packet, "
-						   "not SMA (QP=%x)\n", qp);
+				ipath_ib_rcv(dd->verbs_dev, rc + 1, ebuf,
+					     tlen);
 				if (dd->ipath_lli_counter)
 					dd->ipath_lli_counter--;
 
diff --git a/drivers/infiniband/hw/ipath/ipath_intr.c b/drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri Aug 25 11:19:45 2006 -0700
@@ -35,6 +35,7 @@
 
 #include "ipath_kernel.h"
 #include "ipath_layer.h"
+#include "ipath_verbs.h"
 #include "ipath_common.h"
 
 /* These are all rcv-related errors which we want to count for stats */
@@ -712,7 +713,7 @@ static void handle_layer_pioavail(struct
 	if (ret > 0)
 		goto set;
 
-	ret = __ipath_verbs_piobufavail(dd);
+	ret = ipath_ib_piobufavail(dd->verbs_dev);
 	if (ret > 0)
 		goto set;
 
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
@@ -132,12 +132,6 @@ struct _ipath_layer {
 	void *l_arg;
 };
 
-/* Verbs layer interface */
-struct _verbs_layer {
-	void *l_arg;
-	struct timer_list l_timer;
-};
-
 struct ipath_devdata {
 	struct list_head ipath_list;
 
@@ -198,7 +192,8 @@ struct ipath_devdata {
 	void (*ipath_f_setextled)(struct ipath_devdata *, u64, u64);
 	/* fill out chip-specific fields */
 	int (*ipath_f_get_base_info)(struct ipath_portdata *, void *);
-	struct _verbs_layer verbs_layer;
+	struct ipath_ibdev *verbs_dev;
+	struct timer_list verbs_timer;
 	/* total dwords sent (summed from counter) */
 	u64 ipath_sword;
 	/* total dwords rcvd (summed from counter) */
@@ -529,8 +524,6 @@ extern int __ipath_layer_rcv(struct ipat
 extern int __ipath_layer_rcv(struct ipath_devdata *, void *,
 			     struct sk_buff *);
 extern int __ipath_layer_rcv_lid(struct ipath_devdata *, void *);
-extern int __ipath_verbs_piobufavail(struct ipath_devdata *);
-extern int __ipath_verbs_rcv(struct ipath_devdata *, void *, void *, u32);
 
 void ipath_layer_add(struct ipath_devdata *);
 void ipath_layer_remove(struct ipath_devdata *);
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.c b/drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri Aug 25 11:19:45 2006 -0700
@@ -42,26 +42,20 @@
 
 #include "ipath_kernel.h"
 #include "ipath_layer.h"
+#include "ipath_verbs.h"
 #include "ipath_common.h"
 
 /* Acquire before ipath_devs_lock. */
 static DEFINE_MUTEX(ipath_layer_mutex);
-
-static int ipath_verbs_registered;
 
 u16 ipath_layer_rcv_opcode;
 
 static int (*layer_intr)(void *, u32);
 static int (*layer_rcv)(void *, void *, struct sk_buff *);
 static int (*layer_rcv_lid)(void *, void *);
-static int (*verbs_piobufavail)(void *);
-static void (*verbs_rcv)(void *, void *, void *, u32);
 
 static void *(*layer_add_one)(int, struct ipath_devdata *);
 static void (*layer_remove_one)(void *);
-static void *(*verbs_add_one)(int, struct ipath_devdata *);
-static void (*verbs_remove_one)(void *);
-static void (*verbs_timer_cb)(void *);
 
 int __ipath_layer_intr(struct ipath_devdata *dd, u32 arg)
 {
@@ -103,29 +97,6 @@ int __ipath_layer_rcv_lid(struct ipath_d
 
 	if (dd->ipath_layer.l_arg && layer_rcv_lid)
 		ret = layer_rcv_lid(dd->ipath_layer.l_arg, hdr);
-
-	return ret;
-}
-
-int __ipath_verbs_piobufavail(struct ipath_devdata *dd)
-{
-	int ret = -ENODEV;
-
-	if (dd->verbs_layer.l_arg && verbs_piobufavail)
-		ret = verbs_piobufavail(dd->verbs_layer.l_arg);
-
-	return ret;
-}
-
-int __ipath_verbs_rcv(struct ipath_devdata *dd, void *rc, void *ebuf,
-		      u32 tlen)
-{
-	int ret = -ENODEV;
-
-	if (dd->verbs_layer.l_arg && verbs_rcv) {
-		verbs_rcv(dd->verbs_layer.l_arg, rc, ebuf, tlen);
-		ret = 0;
-	}
 
 	return ret;
 }
@@ -211,8 +182,6 @@ bail:
 bail:
 	return ret;
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_set_linkstate);
 
 /**
  * ipath_layer_set_mtu - set the MTU
@@ -298,8 +267,6 @@ bail:
 	return ret;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_set_mtu);
-
 int ipath_set_lid(struct ipath_devdata *dd, u32 arg, u8 lmc)
 {
 	dd->ipath_lid = arg;
@@ -315,8 +282,6 @@ int ipath_set_lid(struct ipath_devdata *
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_set_lid);
-
 int ipath_layer_set_guid(struct ipath_devdata *dd, __be64 guid)
 {
 	/* XXX - need to inform anyone who cares this just happened. */
@@ -324,84 +289,55 @@ int ipath_layer_set_guid(struct ipath_de
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_set_guid);
-
 __be64 ipath_layer_get_guid(struct ipath_devdata *dd)
 {
 	return dd->ipath_guid;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_guid);
-
-u32 ipath_layer_get_nguid(struct ipath_devdata *dd)
-{
-	return dd->ipath_nguid;
-}
-
-EXPORT_SYMBOL_GPL(ipath_layer_get_nguid);
-
 u32 ipath_layer_get_majrev(struct ipath_devdata *dd)
 {
 	return dd->ipath_majrev;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_majrev);
-
 u32 ipath_layer_get_minrev(struct ipath_devdata *dd)
 {
 	return dd->ipath_minrev;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_minrev);
-
 u32 ipath_layer_get_pcirev(struct ipath_devdata *dd)
 {
 	return dd->ipath_pcirev;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_pcirev);
-
 u32 ipath_layer_get_flags(struct ipath_devdata *dd)
 {
 	return dd->ipath_flags;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_flags);
-
 struct device *ipath_layer_get_device(struct ipath_devdata *dd)
 {
 	return &dd->pcidev->dev;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_device);
-
 u16 ipath_layer_get_deviceid(struct ipath_devdata *dd)
 {
 	return dd->ipath_deviceid;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_deviceid);
-
 u32 ipath_layer_get_vendorid(struct ipath_devdata *dd)
 {
 	return dd->ipath_vendorid;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_vendorid);
-
 u64 ipath_layer_get_lastibcstat(struct ipath_devdata *dd)
 {
 	return dd->ipath_lastibcstat;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_lastibcstat);
-
 u32 ipath_layer_get_ibmtu(struct ipath_devdata *dd)
 {
 	return dd->ipath_ibmtu;
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_get_ibmtu);
 
 void ipath_layer_add(struct ipath_devdata *dd)
 {
@@ -411,10 +347,6 @@ void ipath_layer_add(struct ipath_devdat
 		dd->ipath_layer.l_arg =
 			layer_add_one(dd->ipath_unit, dd);
 
-	if (verbs_add_one)
-		dd->verbs_layer.l_arg =
-			verbs_add_one(dd->ipath_unit, dd);
-
 	mutex_unlock(&ipath_layer_mutex);
 }
 
@@ -425,11 +357,6 @@ void ipath_layer_remove(struct ipath_dev
 	if (dd->ipath_layer.l_arg && layer_remove_one) {
 		layer_remove_one(dd->ipath_layer.l_arg);
 		dd->ipath_layer.l_arg = NULL;
-	}
-
-	if (dd->verbs_layer.l_arg && verbs_remove_one) {
-		verbs_remove_one(dd->verbs_layer.l_arg);
-		dd->verbs_layer.l_arg = NULL;
 	}
 
 	mutex_unlock(&ipath_layer_mutex);
@@ -521,94 +448,9 @@ static void __ipath_verbs_timer(unsigned
 		ipath_kreceive(dd);
 
 	/* Handle verbs layer timeouts. */
-	if (dd->verbs_layer.l_arg && verbs_timer_cb)
-		verbs_timer_cb(dd->verbs_layer.l_arg);
-
-	mod_timer(&dd->verbs_layer.l_timer, jiffies + 1);
-}
-
-/**
- * ipath_verbs_register - verbs layer registration
- * @l_piobufavail: callback for when PIO buffers become available
- * @l_rcv: callback for receiving a packet
- * @l_timer_cb: timer callback
- * @ipath_devdata: device data structure is put here
- */
-int ipath_verbs_register(void *(*l_add)(int, struct ipath_devdata *),
-			 void (*l_remove)(void *arg),
-			 int (*l_piobufavail) (void *arg),
-			 void (*l_rcv) (void *arg, void *rhdr,
-					void *data, u32 tlen),
-			 void (*l_timer_cb) (void *arg))
-{
-	struct ipath_devdata *dd, *tmp;
-	unsigned long flags;
-
-	mutex_lock(&ipath_layer_mutex);
-
-	verbs_add_one = l_add;
-	verbs_remove_one = l_remove;
-	verbs_piobufavail = l_piobufavail;
-	verbs_rcv = l_rcv;
-	verbs_timer_cb = l_timer_cb;
-
-	spin_lock_irqsave(&ipath_devs_lock, flags);
-
-	list_for_each_entry_safe(dd, tmp, &ipath_dev_list, ipath_list) {
-		if (!(dd->ipath_flags & IPATH_INITTED))
-			continue;
-
-		if (dd->verbs_layer.l_arg)
-			continue;
-
-		spin_unlock_irqrestore(&ipath_devs_lock, flags);
-		dd->verbs_layer.l_arg = l_add(dd->ipath_unit, dd);
-		spin_lock_irqsave(&ipath_devs_lock, flags);
-	}
-
-	spin_unlock_irqrestore(&ipath_devs_lock, flags);
-	mutex_unlock(&ipath_layer_mutex);
-
-	ipath_verbs_registered = 1;
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ipath_verbs_register);
-
-void ipath_verbs_unregister(void)
-{
-	struct ipath_devdata *dd, *tmp;
-	unsigned long flags;
-
-	mutex_lock(&ipath_layer_mutex);
-	spin_lock_irqsave(&ipath_devs_lock, flags);
-
-	list_for_each_entry_safe(dd, tmp, &ipath_dev_list, ipath_list) {
-		*dd->ipath_statusp &= ~IPATH_STATUS_OIB_SMA;
-
-		if (dd->verbs_layer.l_arg && verbs_remove_one) {
-			spin_unlock_irqrestore(&ipath_devs_lock, flags);
-			verbs_remove_one(dd->verbs_layer.l_arg);
-			spin_lock_irqsave(&ipath_devs_lock, flags);
-			dd->verbs_layer.l_arg = NULL;
-		}
-	}
-
-	spin_unlock_irqrestore(&ipath_devs_lock, flags);
-
-	verbs_add_one = NULL;
-	verbs_remove_one = NULL;
-	verbs_piobufavail = NULL;
-	verbs_rcv = NULL;
-	verbs_timer_cb = NULL;
-
-	ipath_verbs_registered = 0;
-
-	mutex_unlock(&ipath_layer_mutex);
-}
-
-EXPORT_SYMBOL_GPL(ipath_verbs_unregister);
+	ipath_ib_timer(dd->verbs_dev);
+	mod_timer(&dd->verbs_timer, jiffies + 1);
+}
 
 int ipath_layer_open(struct ipath_devdata *dd, u32 * pktmax)
 {
@@ -702,8 +544,6 @@ u32 ipath_layer_get_cr_errpkey(struct ip
 {
 	return ipath_read_creg32(dd, dd->ipath_cregs->cr_errpkey);
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_get_cr_errpkey);
 
 static void update_sge(struct ipath_sge_state *ss, u32 length)
 {
@@ -981,8 +821,6 @@ bail:
 	return ret;
 }
 
-EXPORT_SYMBOL_GPL(ipath_verbs_send);
-
 int ipath_layer_snapshot_counters(struct ipath_devdata *dd, u64 *swords,
 				  u64 *rwords, u64 *spkts, u64 *rpkts,
 				  u64 *xmit_wait)
@@ -1006,8 +844,6 @@ bail:
 bail:
 	return ret;
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_snapshot_counters);
 
 /**
  * ipath_layer_get_counters - get various chip counters
@@ -1069,8 +905,6 @@ bail:
 	return ret;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_counters);
-
 int ipath_layer_want_buffer(struct ipath_devdata *dd)
 {
 	set_bit(IPATH_S_PIOINTBUFAVAIL, &dd->ipath_sendctrl);
@@ -1079,8 +913,6 @@ int ipath_layer_want_buffer(struct ipath
 
 	return 0;
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_want_buffer);
 
 int ipath_layer_send_hdr(struct ipath_devdata *dd, struct ether_header *hdr)
 {
@@ -1174,16 +1006,14 @@ int ipath_layer_enable_timer(struct ipat
 				 (u64) (1 << 2));
 	}
 
-	init_timer(&dd->verbs_layer.l_timer);
-	dd->verbs_layer.l_timer.function = __ipath_verbs_timer;
-	dd->verbs_layer.l_timer.data = (unsigned long)dd;
-	dd->verbs_layer.l_timer.expires = jiffies + 1;
-	add_timer(&dd->verbs_layer.l_timer);
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ipath_layer_enable_timer);
+	init_timer(&dd->verbs_timer);
+	dd->verbs_timer.function = __ipath_verbs_timer;
+	dd->verbs_timer.data = (unsigned long)dd;
+	dd->verbs_timer.expires = jiffies + 1;
+	add_timer(&dd->verbs_timer);
+
+	return 0;
+}
 
 int ipath_layer_disable_timer(struct ipath_devdata *dd)
 {
@@ -1191,12 +1021,10 @@ int ipath_layer_disable_timer(struct ipa
 	if (dd->ipath_flags & IPATH_GPIO_INTR)
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_mask, 0);
 
-	del_timer_sync(&dd->verbs_layer.l_timer);
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ipath_layer_disable_timer);
+	del_timer_sync(&dd->verbs_timer);
+
+	return 0;
+}
 
 /**
  * ipath_layer_set_verbs_flags - set the verbs layer flags
@@ -1225,8 +1053,6 @@ int ipath_layer_set_verbs_flags(struct i
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_set_verbs_flags);
-
 /**
  * ipath_layer_get_npkeys - return the size of the PKEY table for port 0
  * @dd: the infinipath device
@@ -1235,8 +1061,6 @@ unsigned ipath_layer_get_npkeys(struct i
 {
 	return ARRAY_SIZE(dd->ipath_pd[0]->port_pkeys);
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_get_npkeys);
 
 /**
  * ipath_layer_get_pkey - return the indexed PKEY from the port 0 PKEY table
@@ -1255,8 +1079,6 @@ unsigned ipath_layer_get_pkey(struct ipa
 	return ret;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_get_pkey);
-
 /**
  * ipath_layer_get_pkeys - return the PKEY table for port 0
  * @dd: the infinipath device
@@ -1270,8 +1092,6 @@ int ipath_layer_get_pkeys(struct ipath_d
 
 	return 0;
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_get_pkeys);
 
 /**
  * rm_pkey - decrecment the reference count for the given PKEY
@@ -1419,8 +1239,6 @@ int ipath_layer_set_pkeys(struct ipath_d
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_set_pkeys);
-
 /**
  * ipath_layer_get_linkdowndefaultstate - get the default linkdown state
  * @dd: the infinipath device
@@ -1431,8 +1249,6 @@ int ipath_layer_get_linkdowndefaultstate
 {
 	return !!(dd->ipath_ibcctrl & INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE);
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_get_linkdowndefaultstate);
 
 /**
  * ipath_layer_set_linkdowndefaultstate - set the default linkdown state
@@ -1453,16 +1269,12 @@ int ipath_layer_set_linkdowndefaultstate
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_set_linkdowndefaultstate);
-
 int ipath_layer_get_phyerrthreshold(struct ipath_devdata *dd)
 {
 	return (dd->ipath_ibcctrl >>
 		INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) &
 		INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK;
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_get_phyerrthreshold);
 
 /**
  * ipath_layer_set_phyerrthreshold - set the physical error threshold
@@ -1489,16 +1301,12 @@ int ipath_layer_set_phyerrthreshold(stru
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_set_phyerrthreshold);
-
 int ipath_layer_get_overrunthreshold(struct ipath_devdata *dd)
 {
 	return (dd->ipath_ibcctrl >>
 		INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT) &
 		INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK;
 }
-
-EXPORT_SYMBOL_GPL(ipath_layer_get_overrunthreshold);
 
 /**
  * ipath_layer_set_overrunthreshold - set the overrun threshold
@@ -1525,17 +1333,13 @@ int ipath_layer_set_overrunthreshold(str
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_layer_set_overrunthreshold);
-
 int ipath_layer_get_boardname(struct ipath_devdata *dd, char *name,
 			      size_t namelen)
 {
 	return dd->ipath_f_get_boardname(dd, name, namelen);
 }
-EXPORT_SYMBOL_GPL(ipath_layer_get_boardname);
 
 u32 ipath_layer_get_rcvhdrentsize(struct ipath_devdata *dd)
 {
 	return dd->ipath_rcvhdrentsize;
 }
-EXPORT_SYMBOL_GPL(ipath_layer_get_rcvhdrentsize);
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.h b/drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Fri Aug 25 11:19:45 2006 -0700
@@ -114,14 +114,7 @@ int ipath_layer_register(void *(*l_add)(
 				      struct sk_buff *),
 			 u16 rcv_opcode,
 			 int (*l_rcv_lid)(void *, void *));
-int ipath_verbs_register(void *(*l_add)(int, struct ipath_devdata *),
-			 void (*l_remove)(void *arg),
-			 int (*l_piobufavail)(void *arg),
-			 void (*l_rcv)(void *arg, void *rhdr,
-				       void *data, u32 tlen),
-			 void (*l_timer_cb)(void *arg));
 void ipath_layer_unregister(void);
-void ipath_verbs_unregister(void);
 int ipath_layer_open(struct ipath_devdata *, u32 * pktmax);
 u16 ipath_layer_get_lid(struct ipath_devdata *dd);
 int ipath_layer_get_mac(struct ipath_devdata *dd, u8 *);
@@ -145,7 +138,6 @@ int ipath_layer_want_buffer(struct ipath
 int ipath_layer_want_buffer(struct ipath_devdata *dd);
 int ipath_layer_set_guid(struct ipath_devdata *, __be64 guid);
 __be64 ipath_layer_get_guid(struct ipath_devdata *);
-u32 ipath_layer_get_nguid(struct ipath_devdata *);
 u32 ipath_layer_get_majrev(struct ipath_devdata *);
 u32 ipath_layer_get_minrev(struct ipath_devdata *);
 u32 ipath_layer_get_pcirev(struct ipath_devdata *);
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -368,7 +368,7 @@ static void ipath_qp_rcv(struct ipath_ib
 }
 
 /**
- * ipath_ib_rcv - process and incoming packet
+ * ipath_ib_rcv - process an incoming packet
  * @arg: the device pointer
  * @rhdr: the header of the packet
  * @data: the packet data
@@ -377,9 +377,9 @@ static void ipath_qp_rcv(struct ipath_ib
  * This is called from ipath_kreceive() to process an incoming packet at
  * interrupt level. Tlen is the length of the header + data + CRC in bytes.
  */
-static void ipath_ib_rcv(void *arg, void *rhdr, void *data, u32 tlen)
-{
-	struct ipath_ibdev *dev = (struct ipath_ibdev *) arg;
+void ipath_ib_rcv(struct ipath_ibdev *dev, void *rhdr, void *data,
+		  u32 tlen)
+{
 	struct ipath_ib_header *hdr = rhdr;
 	struct ipath_other_headers *ohdr;
 	struct ipath_qp *qp;
@@ -468,9 +468,8 @@ bail:;
  * This is called from ipath_do_rcv_timer() at interrupt level to check for
  * QPs which need retransmits and to collect performance numbers.
  */
-static void ipath_ib_timer(void *arg)
-{
-	struct ipath_ibdev *dev = (struct ipath_ibdev *) arg;
+void ipath_ib_timer(struct ipath_ibdev *dev)
+{
 	struct ipath_qp *resend = NULL;
 	struct list_head *last;
 	struct ipath_qp *qp;
@@ -564,9 +563,8 @@ static void ipath_ib_timer(void *arg)
  * QPs waiting for buffers (for now, just do a tasklet_hi_schedule and
  * return zero).
  */
-static int ipath_ib_piobufavail(void *arg)
-{
-	struct ipath_ibdev *dev = (struct ipath_ibdev *) arg;
+int ipath_ib_piobufavail(struct ipath_ibdev *dev)
+{
 	struct ipath_qp *qp;
 	unsigned long flags;
 
@@ -957,11 +955,10 @@ static int ipath_verbs_register_sysfs(st
 
 /**
  * ipath_register_ib_device - register our device with the infiniband core
- * @unit: the device number to register
  * @dd: the device data structure
  * Return the allocated ipath_ibdev pointer or NULL on error.
  */
-static void *ipath_register_ib_device(int unit, struct ipath_devdata *dd)
+int ipath_register_ib_device(struct ipath_devdata *dd)
 {
 	struct ipath_layer_counters cntrs;
 	struct ipath_ibdev *idev;
@@ -969,8 +966,10 @@ static void *ipath_register_ib_device(in
 	int ret;
 
 	idev = (struct ipath_ibdev *)ib_alloc_device(sizeof *idev);
-	if (idev == NULL)
-		goto bail;
+	if (idev == NULL) {
+		ret = -ENOMEM;
+		goto bail;
+	}
 
 	dev = &idev->ibdev;
 
@@ -1047,7 +1046,7 @@ static void *ipath_register_ib_device(in
 	if (!sys_image_guid)
 		sys_image_guid = ipath_layer_get_guid(dd);
 	idev->sys_image_guid = sys_image_guid;
-	idev->ib_unit = unit;
+	idev->ib_unit = dd->ipath_unit;
 	idev->dd = dd;
 
 	strlcpy(dev->name, "ipath%d", IB_DEVICE_NAME_MAX);
@@ -1153,16 +1152,16 @@ err_qp:
 err_qp:
 	ib_dealloc_device(dev);
 	_VERBS_ERROR("ib_ipath%d cannot register verbs (%d)!\n",
-		     unit, -ret);
+		     dd->ipath_unit, -ret);
 	idev = NULL;
 
 bail:
-	return idev;
-}
-
-static void ipath_unregister_ib_device(void *arg)
-{
-	struct ipath_ibdev *dev = (struct ipath_ibdev *) arg;
+	dd->verbs_dev = idev;
+	return ret;
+}
+
+void ipath_unregister_ib_device(struct ipath_ibdev *dev)
+{
 	struct ib_device *ibdev = &dev->ibdev;
 
 	ipath_layer_disable_timer(dev->dd);
@@ -1193,19 +1192,6 @@ static void ipath_unregister_ib_device(v
 	ib_dealloc_device(ibdev);
 }
 
-static int __init ipath_verbs_init(void)
-{
-	return ipath_verbs_register(ipath_register_ib_device,
-				    ipath_unregister_ib_device,
-				    ipath_ib_piobufavail, ipath_ib_rcv,
-				    ipath_ib_timer);
-}
-
-static void __exit ipath_verbs_cleanup(void)
-{
-	ipath_verbs_unregister();
-}
-
 static ssize_t show_rev(struct class_device *cdev, char *buf)
 {
 	struct ipath_ibdev *dev =
@@ -1297,6 +1283,3 @@ bail:
 bail:
 	return ret;
 }
-
-module_init(ipath_verbs_init);
-module_exit(ipath_verbs_cleanup);
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
@@ -711,6 +711,16 @@ int ipath_make_uc_req(struct ipath_qp *q
 int ipath_make_uc_req(struct ipath_qp *qp, struct ipath_other_headers *ohdr,
 		      u32 pmtu, u32 *bth0p, u32 *bth2p);
 
+int ipath_register_ib_device(struct ipath_devdata *);
+
+void ipath_unregister_ib_device(struct ipath_ibdev *);
+
+void ipath_ib_rcv(struct ipath_ibdev *, void *, void *, u32);
+
+int ipath_ib_piobufavail(struct ipath_ibdev *);
+
+void ipath_ib_timer(struct ipath_ibdev *);
+
 extern const enum ib_wc_opcode ib_ipath_wc_opcode[];
 
 extern const u8 ipath_cvt_physportstate[];
