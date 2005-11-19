Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbVKSCT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbVKSCT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161236AbVKSCT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:19:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:54508 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161237AbVKSCT4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:19:56 -0500
Subject: [RFC][PATCH 2/7]: simple set of notifier_head definition changes
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Nov 2005 18:19:54 -0800
Message-Id: <1132366794.9617.14.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple set of changes to files affected by the interface change in 1/7.
This patch updates the definitions and declarations of many of the
notifier chain heads.  It also removes some repeated declarations in
include/linux/memory.h.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Alan Stern <stern@rowland.harvard.edu>
-----

 arch/alpha/kernel/setup.c                   |    2 +-
 arch/powerpc/platforms/pseries/reconfig.c   |    2 +-
 arch/s390/kernel/process.c                  |    2 +-
 drivers/base/memory.c                       |    2 +-
 drivers/char/ipmi/ipmi_si_intf.c            |    2 +-
 drivers/macintosh/adb.c                     |    2 +-
 drivers/macintosh/via-pmu.c                 |    2 +-
 drivers/macintosh/via-pmu68k.c              |    2 +-
 drivers/macintosh/windfarm_core.c           |    2 +-
 drivers/video/fbmem.c                       |    2 +-
 include/linux/adb.h                         |    2 +-
 include/linux/kernel.h                      |    2 +-
 include/linux/memory.h                      |    4 ----
 include/linux/netfilter_ipv4/ip_conntrack.h |    4 ++--
 include/net/netfilter/nf_conntrack.h        |    4 ++--
 kernel/panic.c                              |    2 +-
 kernel/sys.c                                |    2 +-
 net/bluetooth/hci_core.c                    |    2 +-
 net/core/dev.c                              |    2 +-
 net/decnet/dn_dev.c                         |    2 +-
 net/ipv4/devinet.c                          |    2 +-
 net/ipv4/netfilter/ip_conntrack_core.c      |    4 ++--
 net/ipv6/addrconf.c                         |    2 +-
 net/netfilter/nf_conntrack_core.c           |    4 ++--
 net/netlink/af_netlink.c                    |    2 +-
 25 files changed, 28 insertions(+), 32 deletions(-)

Index: l2615-rc1-notifiers/arch/alpha/kernel/setup.c
===================================================================
--- l2615-rc1-notifiers.orig/arch/alpha/kernel/setup.c
+++ l2615-rc1-notifiers/arch/alpha/kernel/setup.c
@@ -42,7 +42,7 @@
 #include <asm/setup.h>
 #include <asm/io.h>
 
-extern struct notifier_block *panic_notifier_list;
+extern struct notifier_head panic_notifier_list;
 static int alpha_panic_event(struct notifier_block *, unsigned long, void *);
 static struct notifier_block alpha_panic_block = {
 	alpha_panic_event,
Index: l2615-rc1-notifiers/net/ipv4/devinet.c
===================================================================
--- l2615-rc1-notifiers.orig/net/ipv4/devinet.c
+++ l2615-rc1-notifiers/net/ipv4/devinet.c
@@ -79,7 +79,7 @@ static struct ipv4_devconf ipv4_devconf_
 
 static void rtmsg_ifa(int event, struct in_ifaddr *);
 
-static struct notifier_block *inetaddr_chain;
+static BLOCKING_NOTIFIER_HEAD(inetaddr_chain);
 static void inet_del_ifa(struct in_device *in_dev, struct in_ifaddr **ifap,
 			 int destroy);
 #ifdef CONFIG_SYSCTL
Index: l2615-rc1-notifiers/net/bluetooth/hci_core.c
===================================================================
--- l2615-rc1-notifiers.orig/net/bluetooth/hci_core.c
+++ l2615-rc1-notifiers/net/bluetooth/hci_core.c
@@ -73,7 +73,7 @@ DEFINE_RWLOCK(hci_cb_list_lock);
 struct hci_proto *hci_proto[HCI_MAX_PROTO];
 
 /* HCI notifiers list */
-static struct notifier_block *hci_notifier;
+static ATOMIC_NOTIFIER_HEAD(hci_notifier);
 
 /* ---- HCI notifications ---- */
 
Index: l2615-rc1-notifiers/net/decnet/dn_dev.c
===================================================================
--- l2615-rc1-notifiers.orig/net/decnet/dn_dev.c
+++ l2615-rc1-notifiers/net/decnet/dn_dev.c
@@ -67,7 +67,7 @@ dn_address decnet_address = 0;
 
 static DEFINE_RWLOCK(dndev_lock);
 static struct net_device *decnet_default_device;
-static struct notifier_block *dnaddr_chain;
+static BLOCKING_NOTIFIER_HEAD(dnaddr_chain);
 
 static struct dn_dev *dn_dev_create(struct net_device *dev, int *err);
 static void dn_dev_delete(struct net_device *dev);
Index: l2615-rc1-notifiers/net/netlink/af_netlink.c
===================================================================
--- l2615-rc1-notifiers.orig/net/netlink/af_netlink.c
+++ l2615-rc1-notifiers/net/netlink/af_netlink.c
@@ -121,7 +121,7 @@ static void netlink_destroy_callback(str
 static DEFINE_RWLOCK(nl_table_lock);
 static atomic_t nl_table_users = ATOMIC_INIT(0);
 
-static struct notifier_block *netlink_chain;
+static ATOMIC_NOTIFIER_HEAD(netlink_chain);
 
 static u32 netlink_group_mask(u32 group)
 {
Index: l2615-rc1-notifiers/net/ipv6/addrconf.c
===================================================================
--- l2615-rc1-notifiers.orig/net/ipv6/addrconf.c
+++ l2615-rc1-notifiers/net/ipv6/addrconf.c
@@ -145,7 +145,7 @@ static void inet6_prefix_notify(int even
 				struct prefix_info *pinfo);
 static int ipv6_chk_same_addr(const struct in6_addr *addr, struct net_device *dev);
 
-static struct notifier_block *inet6addr_chain;
+static ATOMIC_NOTIFIER_HEAD(inet6addr_chain);
 
 struct ipv6_devconf ipv6_devconf = {
 	.forwarding		= 0,
Index: l2615-rc1-notifiers/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- l2615-rc1-notifiers.orig/arch/powerpc/platforms/pseries/reconfig.c
+++ l2615-rc1-notifiers/arch/powerpc/platforms/pseries/reconfig.c
@@ -94,7 +94,7 @@ static struct device_node *derive_parent
 	return parent;
 }
 
-static struct notifier_block *pSeries_reconfig_chain;
+static BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);
 
 int pSeries_reconfig_notifier_register(struct notifier_block *nb)
 {
Index: l2615-rc1-notifiers/arch/s390/kernel/process.c
===================================================================
--- l2615-rc1-notifiers.orig/arch/s390/kernel/process.c
+++ l2615-rc1-notifiers/arch/s390/kernel/process.c
@@ -68,7 +68,7 @@ unsigned long thread_saved_pc(struct tas
 /*
  * Need to know about CPUs going idle?
  */
-static struct notifier_block *idle_chain;
+static BLOCKING_NOTIFIER_HEAD(idle_chain);
 
 int register_idle_notifier(struct notifier_block *nb)
 {
Index: l2615-rc1-notifiers/drivers/base/memory.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/base/memory.c
+++ l2615-rc1-notifiers/drivers/base/memory.c
@@ -48,7 +48,7 @@ static struct kset_hotplug_ops memory_ho
 	.hotplug	= memory_hotplug,
 };
 
-static struct notifier_block *memory_chain;
+static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
 static int register_memory_notifier(struct notifier_block *nb)
 {
Index: l2615-rc1-notifiers/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ l2615-rc1-notifiers/drivers/char/ipmi/ipmi_si_intf.c
@@ -226,7 +226,7 @@ struct smi_info
         struct task_struct *thread;
 };
 
-static struct notifier_block *xaction_notifier_list;
+static ATOMIC_NOTIFIER_HEAD(xaction_notifier_list);
 static int register_xaction_notifier(struct notifier_block * nb)
 {
 	return notifier_chain_register(&xaction_notifier_list, nb);
Index: l2615-rc1-notifiers/drivers/macintosh/adb.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/macintosh/adb.c
+++ l2615-rc1-notifiers/drivers/macintosh/adb.c
@@ -80,7 +80,7 @@ static struct adb_driver *adb_driver_lis
 static struct class *adb_dev_class;
 
 struct adb_driver *adb_controller;
-struct notifier_block *adb_client_list = NULL;
+BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
 static pid_t adb_probe_task_pid;
Index: l2615-rc1-notifiers/drivers/macintosh/via-pmu.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/macintosh/via-pmu.c
+++ l2615-rc1-notifiers/drivers/macintosh/via-pmu.c
@@ -182,7 +182,7 @@ extern int disable_kernel_backlight;
 
 int __fake_sleep;
 int asleep;
-struct notifier_block *sleep_notifier_list;
+BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
 
 #ifdef CONFIG_ADB
 static int adb_dev_map = 0;
Index: l2615-rc1-notifiers/drivers/macintosh/via-pmu68k.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/macintosh/via-pmu68k.c
+++ l2615-rc1-notifiers/drivers/macintosh/via-pmu68k.c
@@ -102,7 +102,7 @@ static int pmu_kind = PMU_UNKNOWN;
 static int pmu_fully_inited = 0;
 
 int asleep;
-struct notifier_block *sleep_notifier_list;
+BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
 
 static int pmu_probe(void);
 static int pmu_init(void);
Index: l2615-rc1-notifiers/drivers/macintosh/windfarm_core.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/macintosh/windfarm_core.c
+++ l2615-rc1-notifiers/drivers/macintosh/windfarm_core.c
@@ -49,7 +49,7 @@
 static LIST_HEAD(wf_controls);
 static LIST_HEAD(wf_sensors);
 static DECLARE_MUTEX(wf_lock);
-static struct notifier_block *wf_client_list;
+static BLOCKING_NOTIFIER_HEAD(wf_client_list);
 static int wf_client_count;
 static unsigned int wf_overtemp;
 static unsigned int wf_overtemp_counter;
Index: l2615-rc1-notifiers/drivers/video/fbmem.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/video/fbmem.c
+++ l2615-rc1-notifiers/drivers/video/fbmem.c
@@ -55,7 +55,7 @@
 
 #define FBPIXMAPSIZE	(1024 * 8)
 
-static struct notifier_block *fb_notifier_list;
+static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
 struct fb_info *registered_fb[FB_MAX];
 int num_registered_fb;
 
Index: l2615-rc1-notifiers/include/linux/adb.h
===================================================================
--- l2615-rc1-notifiers.orig/include/linux/adb.h
+++ l2615-rc1-notifiers/include/linux/adb.h
@@ -85,7 +85,7 @@ enum adb_message {
     ADB_MSG_POST_RESET	/* Called after resetting the bus (re-do init & register) */
 };
 extern struct adb_driver *adb_controller;
-extern struct notifier_block *adb_client_list;
+extern struct notifier_head adb_client_list;
 
 int adb_request(struct adb_request *req, void (*done)(struct adb_request *),
 		int flags, int nbytes, ...);
Index: l2615-rc1-notifiers/include/linux/kernel.h
===================================================================
--- l2615-rc1-notifiers.orig/include/linux/kernel.h
+++ l2615-rc1-notifiers/include/linux/kernel.h
@@ -85,7 +85,7 @@ extern int cond_resched(void);
 		(__x < 0) ? -__x : __x;		\
 	})
 
-extern struct notifier_block *panic_notifier_list;
+extern struct notifier_head panic_notifier_list;
 extern long (*panic_blink)(long time);
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
Index: l2615-rc1-notifiers/include/linux/memory.h
===================================================================
--- l2615-rc1-notifiers.orig/include/linux/memory.h
+++ l2615-rc1-notifiers/include/linux/memory.h
@@ -80,10 +80,6 @@ extern void unregister_memory_notifier(s
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 
 extern int invalidate_phys_mapping(unsigned long, unsigned long);
-struct notifier_block;
-
-extern int register_memory_notifier(struct notifier_block *nb);
-extern void unregister_memory_notifier(struct notifier_block *nb);
 
 extern struct sysdev_class memory_sysdev_class;
 #endif /* CONFIG_MEMORY_HOTPLUG */
Index: l2615-rc1-notifiers/include/linux/netfilter_ipv4/ip_conntrack.h
===================================================================
--- l2615-rc1-notifiers.orig/include/linux/netfilter_ipv4/ip_conntrack.h
+++ l2615-rc1-notifiers/include/linux/netfilter_ipv4/ip_conntrack.h
@@ -309,8 +309,8 @@ DECLARE_PER_CPU(struct ip_conntrack_ecac
 
 #define CONNTRACK_ECACHE(x)	(__get_cpu_var(ip_conntrack_ecache).x)
  
-extern struct notifier_block *ip_conntrack_chain;
-extern struct notifier_block *ip_conntrack_expect_chain;
+extern struct notifier_head ip_conntrack_chain;
+extern struct notifier_head ip_conntrack_expect_chain;
 
 static inline int ip_conntrack_register_notifier(struct notifier_block *nb)
 {
Index: l2615-rc1-notifiers/include/net/netfilter/nf_conntrack.h
===================================================================
--- l2615-rc1-notifiers.orig/include/net/netfilter/nf_conntrack.h
+++ l2615-rc1-notifiers/include/net/netfilter/nf_conntrack.h
@@ -269,8 +269,8 @@ DECLARE_PER_CPU(struct nf_conntrack_ecac
 
 #define CONNTRACK_ECACHE(x)	(__get_cpu_var(nf_conntrack_ecache).x)
 
-extern struct notifier_block *nf_conntrack_chain;
-extern struct notifier_block *nf_conntrack_expect_chain;
+extern struct notifier_head nf_conntrack_chain;
+extern struct notifier_head nf_conntrack_expect_chain;
 
 static inline int nf_conntrack_register_notifier(struct notifier_block *nb)
 {
Index: l2615-rc1-notifiers/kernel/panic.c
===================================================================
--- l2615-rc1-notifiers.orig/kernel/panic.c
+++ l2615-rc1-notifiers/kernel/panic.c
@@ -26,7 +26,7 @@ int tainted;
 
 EXPORT_SYMBOL(panic_timeout);
 
-struct notifier_block *panic_notifier_list;
+ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
Index: l2615-rc1-notifiers/net/core/dev.c
===================================================================
--- l2615-rc1-notifiers.orig/net/core/dev.c
+++ l2615-rc1-notifiers/net/core/dev.c
@@ -192,7 +192,7 @@ static inline struct hlist_head *dev_ind
  *	Our notifier list
  */
 
-static struct notifier_block *netdev_chain;
+static BLOCKING_NOTIFIER_HEAD(netdev_chain);
 
 /*
  *	Device drivers call our routines to queue packets here. We empty the
Index: l2615-rc1-notifiers/net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
--- l2615-rc1-notifiers.orig/net/ipv4/netfilter/ip_conntrack_core.c
+++ l2615-rc1-notifiers/net/ipv4/netfilter/ip_conntrack_core.c
@@ -80,8 +80,8 @@ static int ip_conntrack_vmalloc;
 static unsigned int ip_conntrack_next_id = 1;
 static unsigned int ip_conntrack_expect_next_id = 1;
 #ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
-struct notifier_block *ip_conntrack_chain;
-struct notifier_block *ip_conntrack_expect_chain;
+ATOMIC_NOTIFIER_HEAD(ip_conntrack_chain);
+ATOMIC_NOTIFIER_HEAD(ip_conntrack_expect_chain);
 
 DEFINE_PER_CPU(struct ip_conntrack_ecache, ip_conntrack_ecache);
 
Index: l2615-rc1-notifiers/net/netfilter/nf_conntrack_core.c
===================================================================
--- l2615-rc1-notifiers.orig/net/netfilter/nf_conntrack_core.c
+++ l2615-rc1-notifiers/net/netfilter/nf_conntrack_core.c
@@ -83,8 +83,8 @@ static LIST_HEAD(unconfirmed);
 static int nf_conntrack_vmalloc;
 
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
-struct notifier_block *nf_conntrack_chain;
-struct notifier_block *nf_conntrack_expect_chain;
+ATOMIC_NOTIFIER_HEAD(nf_conntrack_chain);
+ATOMIC_NOTIFIER_HEAD(nf_conntrack_expect_chain);
 
 DEFINE_PER_CPU(struct nf_conntrack_ecache, nf_conntrack_ecache);
 
Index: l2615-rc1-notifiers/kernel/sys.c
===================================================================
--- l2615-rc1-notifiers.orig/kernel/sys.c
+++ l2615-rc1-notifiers/kernel/sys.c
@@ -93,7 +93,7 @@ int cad_pid = 1;
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
+static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
 
 /**
  *	notifier_chain_register	- Add notifier to a notifier chain

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


