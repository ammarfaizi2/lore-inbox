Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVLPXNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVLPXNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVLPXNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:13:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46812 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964834AbVLPXNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:35 -0500
Date: Fri, 16 Dec 2005 23:13:08 GMT
Message-Id: <200512162313.jBGND8HD019639@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 9/12]: MUTEX: Rename DECLARE_MUTEX for net/ dir
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
net/ directory.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-net-2615rc5-2.diff
 net/atm/ioctl.c                    |    2 +-
 net/atm/resources.c                |    2 +-
 net/bluetooth/rfcomm/core.c        |    2 +-
 net/bridge/netfilter/ebtables.c    |    2 +-
 net/core/dev.c                     |    2 +-
 net/core/flow.c                    |    2 +-
 net/core/pktgen.c                  |    2 +-
 net/core/rtnetlink.c               |    2 +-
 net/ipv4/ipcomp.c                  |    2 +-
 net/ipv4/ipvs/ip_vs_app.c          |    2 +-
 net/ipv4/ipvs/ip_vs_ctl.c          |    2 +-
 net/ipv4/netfilter/arp_tables.c    |    2 +-
 net/ipv4/netfilter/ip_queue.c      |    2 +-
 net/ipv4/netfilter/ip_tables.c     |    2 +-
 net/ipv4/netfilter/ipt_hashlimit.c |    2 +-
 net/ipv4/xfrm4_tunnel.c            |    2 +-
 net/ipv6/ipcomp6.c                 |    2 +-
 net/ipv6/netfilter/ip6_queue.c     |    2 +-
 net/ipv6/netfilter/ip6_tables.c    |    2 +-
 net/ipv6/xfrm6_tunnel.c            |    2 +-
 net/netfilter/nf_conntrack_core.c  |    2 +-
 net/netfilter/nf_sockopt.c         |    2 +-
 net/netfilter/nfnetlink.c          |    2 +-
 net/netlink/genetlink.c            |    2 +-
 net/socket.c                       |    6 +++---
 net/sunrpc/cache.c                 |    2 +-
 net/sunrpc/sched.c                 |    4 ++--
 net/unix/garbage.c                 |    2 +-
 net/xfrm/xfrm_policy.c             |    2 +-
 29 files changed, 32 insertions(+), 32 deletions(-)

diff -uNrp linux-2.6.15-rc5/net/atm/ioctl.c linux-2.6.15-rc5-mutex/net/atm/ioctl.c
--- linux-2.6.15-rc5/net/atm/ioctl.c	2005-11-01 13:19:23.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/atm/ioctl.c	2005-12-15 17:14:56.000000000 +0000
@@ -24,7 +24,7 @@
 #include "common.h"
 
 
-static DECLARE_MUTEX(ioctl_mutex);
+static DECLARE_SEM_MUTEX(ioctl_mutex);
 static LIST_HEAD(ioctl_list);
 
 
diff -uNrp linux-2.6.15-rc5/net/atm/resources.c linux-2.6.15-rc5-mutex/net/atm/resources.c
--- linux-2.6.15-rc5/net/atm/resources.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/atm/resources.c	2005-12-15 17:14:56.000000000 +0000
@@ -25,7 +25,7 @@
 
 
 LIST_HEAD(atm_devs);
-DECLARE_MUTEX(atm_dev_mutex);
+DECLARE_SEM_MUTEX(atm_dev_mutex);
 
 static struct atm_dev *__alloc_atm_dev(const char *type)
 {
diff -uNrp linux-2.6.15-rc5/net/bluetooth/rfcomm/core.c linux-2.6.15-rc5-mutex/net/bluetooth/rfcomm/core.c
--- linux-2.6.15-rc5/net/bluetooth/rfcomm/core.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/bluetooth/rfcomm/core.c	2005-12-15 17:14:56.000000000 +0000
@@ -55,7 +55,7 @@
 
 static struct task_struct *rfcomm_thread;
 
-static DECLARE_MUTEX(rfcomm_sem);
+static DECLARE_SEM_MUTEX(rfcomm_sem);
 #define rfcomm_lock()	down(&rfcomm_sem);
 #define rfcomm_unlock()	up(&rfcomm_sem);
 
diff -uNrp linux-2.6.15-rc5/net/bridge/netfilter/ebtables.c linux-2.6.15-rc5-mutex/net/bridge/netfilter/ebtables.c
--- linux-2.6.15-rc5/net/bridge/netfilter/ebtables.c	2005-11-01 13:19:23.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/bridge/netfilter/ebtables.c	2005-12-15 17:14:56.000000000 +0000
@@ -81,7 +81,7 @@ static void print_string(char *str)
 
 
 
-static DECLARE_MUTEX(ebt_mutex);
+static DECLARE_SEM_MUTEX(ebt_mutex);
 static LIST_HEAD(ebt_tables);
 static LIST_HEAD(ebt_targets);
 static LIST_HEAD(ebt_matches);
diff -uNrp linux-2.6.15-rc5/net/core/dev.c linux-2.6.15-rc5-mutex/net/core/dev.c
--- linux-2.6.15-rc5/net/core/dev.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/core/dev.c	2005-12-15 17:14:56.000000000 +0000
@@ -2902,7 +2902,7 @@ static void netdev_wait_allrefs(struct n
  * 2) Since we run with the RTNL semaphore not held, we can sleep
  *    safely in order to wait for the netdev refcnt to drop to zero.
  */
-static DECLARE_MUTEX(net_todo_run_mutex);
+static DECLARE_SEM_MUTEX(net_todo_run_mutex);
 void netdev_run_todo(void)
 {
 	struct list_head list = LIST_HEAD_INIT(list);
diff -uNrp linux-2.6.15-rc5/net/core/flow.c linux-2.6.15-rc5-mutex/net/core/flow.c
--- linux-2.6.15-rc5/net/core/flow.c	2005-11-01 13:19:23.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/core/flow.c	2005-12-15 17:14:56.000000000 +0000
@@ -283,7 +283,7 @@ static void flow_cache_flush_per_cpu(voi
 void flow_cache_flush(void)
 {
 	struct flow_flush_info info;
-	static DECLARE_MUTEX(flow_flush_sem);
+	static DECLARE_SEM_MUTEX(flow_flush_sem);
 
 	/* Don't want cpus going down or up during this. */
 	lock_cpu_hotplug();
diff -uNrp linux-2.6.15-rc5/net/core/pktgen.c linux-2.6.15-rc5-mutex/net/core/pktgen.c
--- linux-2.6.15-rc5/net/core/pktgen.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/core/pktgen.c	2005-12-15 17:14:56.000000000 +0000
@@ -491,7 +491,7 @@ static int pg_delay_d = 0;
 static int pg_clone_skb_d = 0;
 static int debug = 0;
 
-static DECLARE_MUTEX(pktgen_sem);
+static DECLARE_SEM_MUTEX(pktgen_sem);
 static struct pktgen_thread *pktgen_threads = NULL;
 
 static struct notifier_block pktgen_notifier_block = {
diff -uNrp linux-2.6.15-rc5/net/core/rtnetlink.c linux-2.6.15-rc5-mutex/net/core/rtnetlink.c
--- linux-2.6.15-rc5/net/core/rtnetlink.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/core/rtnetlink.c	2005-12-15 17:14:56.000000000 +0000
@@ -51,7 +51,7 @@
 #include <net/pkt_sched.h>
 #include <net/netlink.h>
 
-DECLARE_MUTEX(rtnl_sem);
+DECLARE_SEM_MUTEX(rtnl_sem);
 
 void rtnl_lock(void)
 {
diff -uNrp linux-2.6.15-rc5/net/ipv4/ipcomp.c linux-2.6.15-rc5-mutex/net/ipv4/ipcomp.c
--- linux-2.6.15-rc5/net/ipv4/ipcomp.c	2005-11-01 13:19:24.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/ipcomp.c	2005-12-15 17:14:57.000000000 +0000
@@ -35,7 +35,7 @@ struct ipcomp_tfms {
 	int users;
 };
 
-static DECLARE_MUTEX(ipcomp_resource_sem);
+static DECLARE_SEM_MUTEX(ipcomp_resource_sem);
 static void **ipcomp_scratches;
 static int ipcomp_scratch_users;
 static LIST_HEAD(ipcomp_tfms_list);
diff -uNrp linux-2.6.15-rc5/net/ipv4/ipvs/ip_vs_app.c linux-2.6.15-rc5-mutex/net/ipv4/ipvs/ip_vs_app.c
--- linux-2.6.15-rc5/net/ipv4/ipvs/ip_vs_app.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/ipvs/ip_vs_app.c	2005-12-15 17:14:57.000000000 +0000
@@ -40,7 +40,7 @@ EXPORT_SYMBOL(register_ip_vs_app_inc);
 
 /* ipvs application list head */
 static LIST_HEAD(ip_vs_app_list);
-static DECLARE_MUTEX(__ip_vs_app_mutex);
+static DECLARE_SEM_MUTEX(__ip_vs_app_mutex);
 
 
 /*
diff -uNrp linux-2.6.15-rc5/net/ipv4/ipvs/ip_vs_ctl.c linux-2.6.15-rc5-mutex/net/ipv4/ipvs/ip_vs_ctl.c
--- linux-2.6.15-rc5/net/ipv4/ipvs/ip_vs_ctl.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/ipvs/ip_vs_ctl.c	2005-12-15 17:14:57.000000000 +0000
@@ -42,7 +42,7 @@
 #include <net/ip_vs.h>
 
 /* semaphore for IPVS sockopts. And, [gs]etsockopt may sleep. */
-static DECLARE_MUTEX(__ip_vs_mutex);
+static DECLARE_SEM_MUTEX(__ip_vs_mutex);
 
 /* lock for service table */
 static DEFINE_RWLOCK(__ip_vs_svc_lock);
diff -uNrp linux-2.6.15-rc5/net/ipv4/netfilter/arp_tables.c linux-2.6.15-rc5-mutex/net/ipv4/netfilter/arp_tables.c
--- linux-2.6.15-rc5/net/ipv4/netfilter/arp_tables.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/netfilter/arp_tables.c	2005-12-15 17:14:57.000000000 +0000
@@ -56,7 +56,7 @@ do {								\
 #endif
 #define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
 
-static DECLARE_MUTEX(arpt_mutex);
+static DECLARE_SEM_MUTEX(arpt_mutex);
 
 #define ASSERT_READ_LOCK(x) ARP_NF_ASSERT(down_trylock(&arpt_mutex) != 0)
 #define ASSERT_WRITE_LOCK(x) ARP_NF_ASSERT(down_trylock(&arpt_mutex) != 0)
diff -uNrp linux-2.6.15-rc5/net/ipv4/netfilter/ip_queue.c linux-2.6.15-rc5-mutex/net/ipv4/netfilter/ip_queue.c
--- linux-2.6.15-rc5/net/ipv4/netfilter/ip_queue.c	2005-11-01 13:19:24.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/netfilter/ip_queue.c	2005-12-15 17:14:57.000000000 +0000
@@ -61,7 +61,7 @@ static unsigned int queue_dropped = 0;
 static unsigned int queue_user_dropped = 0;
 static struct sock *ipqnl;
 static LIST_HEAD(queue_list);
-static DECLARE_MUTEX(ipqnl_sem);
+static DECLARE_SEM_MUTEX(ipqnl_sem);
 
 static void
 ipq_issue_verdict(struct ipq_queue_entry *entry, int verdict)
diff -uNrp linux-2.6.15-rc5/net/ipv4/netfilter/ip_tables.c linux-2.6.15-rc5-mutex/net/ipv4/netfilter/ip_tables.c
--- linux-2.6.15-rc5/net/ipv4/netfilter/ip_tables.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/netfilter/ip_tables.c	2005-12-15 17:14:57.000000000 +0000
@@ -63,7 +63,7 @@ do {								\
 #endif
 #define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
 
-static DECLARE_MUTEX(ipt_mutex);
+static DECLARE_SEM_MUTEX(ipt_mutex);
 
 /* Must have mutex */
 #define ASSERT_READ_LOCK(x) IP_NF_ASSERT(down_trylock(&ipt_mutex) != 0)
diff -uNrp linux-2.6.15-rc5/net/ipv4/netfilter/ipt_hashlimit.c linux-2.6.15-rc5-mutex/net/ipv4/netfilter/ipt_hashlimit.c
--- linux-2.6.15-rc5/net/ipv4/netfilter/ipt_hashlimit.c	2005-11-01 13:19:24.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/netfilter/ipt_hashlimit.c	2005-12-15 17:14:57.000000000 +0000
@@ -92,7 +92,7 @@ struct ipt_hashlimit_htable {
 };
 
 static DEFINE_SPINLOCK(hashlimit_lock);	/* protects htables list */
-static DECLARE_MUTEX(hlimit_mutex);	/* additional checkentry protection */
+static DECLARE_SEM_MUTEX(hlimit_mutex);	/* additional checkentry protection */
 static HLIST_HEAD(hashlimit_htables);
 static kmem_cache_t *hashlimit_cachep __read_mostly;
 
diff -uNrp linux-2.6.15-rc5/net/ipv4/xfrm4_tunnel.c linux-2.6.15-rc5-mutex/net/ipv4/xfrm4_tunnel.c
--- linux-2.6.15-rc5/net/ipv4/xfrm4_tunnel.c	2005-08-30 13:56:41.000000000 +0100
+++ linux-2.6.15-rc5-mutex/net/ipv4/xfrm4_tunnel.c	2005-12-15 17:14:57.000000000 +0000
@@ -26,7 +26,7 @@ static int ipip_xfrm_rcv(struct xfrm_sta
 }
 
 static struct xfrm_tunnel *ipip_handler;
-static DECLARE_MUTEX(xfrm4_tunnel_sem);
+static DECLARE_SEM_MUTEX(xfrm4_tunnel_sem);
 
 int xfrm4_tunnel_register(struct xfrm_tunnel *handler)
 {
diff -uNrp linux-2.6.15-rc5/net/ipv6/ipcomp6.c linux-2.6.15-rc5-mutex/net/ipv6/ipcomp6.c
--- linux-2.6.15-rc5/net/ipv6/ipcomp6.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv6/ipcomp6.c	2005-12-15 17:14:57.000000000 +0000
@@ -56,7 +56,7 @@ struct ipcomp6_tfms {
 	int users;
 };
 
-static DECLARE_MUTEX(ipcomp6_resource_sem);
+static DECLARE_SEM_MUTEX(ipcomp6_resource_sem);
 static void **ipcomp6_scratches;
 static int ipcomp6_scratch_users;
 static LIST_HEAD(ipcomp6_tfms_list);
diff -uNrp linux-2.6.15-rc5/net/ipv6/netfilter/ip6_queue.c linux-2.6.15-rc5-mutex/net/ipv6/netfilter/ip6_queue.c
--- linux-2.6.15-rc5/net/ipv6/netfilter/ip6_queue.c	2005-11-01 13:19:25.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv6/netfilter/ip6_queue.c	2005-12-15 17:14:57.000000000 +0000
@@ -65,7 +65,7 @@ static unsigned int queue_dropped = 0;
 static unsigned int queue_user_dropped = 0;
 static struct sock *ipqnl;
 static LIST_HEAD(queue_list);
-static DECLARE_MUTEX(ipqnl_sem);
+static DECLARE_SEM_MUTEX(ipqnl_sem);
 
 static void
 ipq_issue_verdict(struct ipq_queue_entry *entry, int verdict)
diff -uNrp linux-2.6.15-rc5/net/ipv6/netfilter/ip6_tables.c linux-2.6.15-rc5-mutex/net/ipv6/netfilter/ip6_tables.c
--- linux-2.6.15-rc5/net/ipv6/netfilter/ip6_tables.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv6/netfilter/ip6_tables.c	2005-12-15 17:14:57.000000000 +0000
@@ -66,7 +66,7 @@ do {								\
 #endif
 #define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
 
-static DECLARE_MUTEX(ip6t_mutex);
+static DECLARE_SEM_MUTEX(ip6t_mutex);
 
 /* Must have mutex */
 #define ASSERT_READ_LOCK(x) IP_NF_ASSERT(down_trylock(&ip6t_mutex) != 0)
diff -uNrp linux-2.6.15-rc5/net/ipv6/xfrm6_tunnel.c linux-2.6.15-rc5-mutex/net/ipv6/xfrm6_tunnel.c
--- linux-2.6.15-rc5/net/ipv6/xfrm6_tunnel.c	2005-11-01 13:19:25.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv6/xfrm6_tunnel.c	2005-12-15 17:14:57.000000000 +0000
@@ -359,7 +359,7 @@ static int xfrm6_tunnel_input(struct xfr
 }
 
 static struct xfrm6_tunnel *xfrm6_tunnel_handler;
-static DECLARE_MUTEX(xfrm6_tunnel_sem);
+static DECLARE_SEM_MUTEX(xfrm6_tunnel_sem);
 
 int xfrm6_tunnel_register(struct xfrm6_tunnel *handler)
 {
diff -uNrp linux-2.6.15-rc5/net/netfilter/nf_conntrack_core.c linux-2.6.15-rc5-mutex/net/netfilter/nf_conntrack_core.c
--- linux-2.6.15-rc5/net/netfilter/nf_conntrack_core.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/netfilter/nf_conntrack_core.c	2005-12-15 17:14:57.000000000 +0000
@@ -180,7 +180,7 @@ static struct {
 DEFINE_RWLOCK(nf_ct_cache_lock);
 
 /* This avoids calling kmem_cache_create() with same name simultaneously */
-DECLARE_MUTEX(nf_ct_cache_mutex);
+DECLARE_SEM_MUTEX(nf_ct_cache_mutex);
 
 extern struct nf_conntrack_protocol nf_conntrack_generic_protocol;
 struct nf_conntrack_protocol *
diff -uNrp linux-2.6.15-rc5/net/netfilter/nf_sockopt.c linux-2.6.15-rc5-mutex/net/netfilter/nf_sockopt.c
--- linux-2.6.15-rc5/net/netfilter/nf_sockopt.c	2005-11-01 13:19:25.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/netfilter/nf_sockopt.c	2005-12-15 17:14:56.000000000 +0000
@@ -11,7 +11,7 @@
 /* Sockopts only registered and called from user context, so
    net locking would be overkill.  Also, [gs]etsockopt calls may
    sleep. */
-static DECLARE_MUTEX(nf_sockopt_mutex);
+static DECLARE_SEM_MUTEX(nf_sockopt_mutex);
 static LIST_HEAD(nf_sockopts);
 
 /* Do exclusive ranges overlap? */
diff -uNrp linux-2.6.15-rc5/net/netfilter/nfnetlink.c linux-2.6.15-rc5-mutex/net/netfilter/nfnetlink.c
--- linux-2.6.15-rc5/net/netfilter/nfnetlink.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/netfilter/nfnetlink.c	2005-12-15 17:14:56.000000000 +0000
@@ -53,7 +53,7 @@ static char __initdata nfversion[] = "0.
 
 static struct sock *nfnl = NULL;
 static struct nfnetlink_subsystem *subsys_table[NFNL_SUBSYS_COUNT];
-DECLARE_MUTEX(nfnl_sem);
+DECLARE_SEM_MUTEX(nfnl_sem);
 
 void nfnl_lock(void)
 {
diff -uNrp linux-2.6.15-rc5/net/netlink/genetlink.c linux-2.6.15-rc5-mutex/net/netlink/genetlink.c
--- linux-2.6.15-rc5/net/netlink/genetlink.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/netlink/genetlink.c	2005-12-15 17:14:56.000000000 +0000
@@ -18,7 +18,7 @@
 
 struct sock *genl_sock = NULL;
 
-static DECLARE_MUTEX(genl_sem); /* serialization of message processing */
+static DECLARE_SEM_MUTEX(genl_sem); /* serialization of message processing */
 
 static void genl_lock(void)
 {
diff -uNrp linux-2.6.15-rc5/net/socket.c linux-2.6.15-rc5-mutex/net/socket.c
--- linux-2.6.15-rc5/net/socket.c	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/socket.c	2005-12-15 17:14:56.000000000 +0000
@@ -796,7 +796,7 @@ static ssize_t sock_writev(struct file *
  * with module unload.
  */
 
-static DECLARE_MUTEX(br_ioctl_mutex);
+static DECLARE_SEM_MUTEX(br_ioctl_mutex);
 static int (*br_ioctl_hook)(unsigned int cmd, void __user *arg) = NULL;
 
 void brioctl_set(int (*hook)(unsigned int, void __user *))
@@ -807,7 +807,7 @@ void brioctl_set(int (*hook)(unsigned in
 }
 EXPORT_SYMBOL(brioctl_set);
 
-static DECLARE_MUTEX(vlan_ioctl_mutex);
+static DECLARE_SEM_MUTEX(vlan_ioctl_mutex);
 static int (*vlan_ioctl_hook)(void __user *arg);
 
 void vlan_ioctl_set(int (*hook)(void __user *))
@@ -818,7 +818,7 @@ void vlan_ioctl_set(int (*hook)(void __u
 }
 EXPORT_SYMBOL(vlan_ioctl_set);
 
-static DECLARE_MUTEX(dlci_ioctl_mutex);
+static DECLARE_SEM_MUTEX(dlci_ioctl_mutex);
 static int (*dlci_ioctl_hook)(unsigned int, void __user *);
 
 void dlci_ioctl_set(int (*hook)(unsigned int, void __user *))
diff -uNrp linux-2.6.15-rc5/net/sunrpc/cache.c linux-2.6.15-rc5-mutex/net/sunrpc/cache.c
--- linux-2.6.15-rc5/net/sunrpc/cache.c	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/sunrpc/cache.c	2005-12-15 17:14:56.000000000 +0000
@@ -532,7 +532,7 @@ void cache_clean_deferred(void *owner)
  */
 
 static DEFINE_SPINLOCK(queue_lock);
-static DECLARE_MUTEX(queue_io_sem);
+static DECLARE_SEM_MUTEX(queue_io_sem);
 
 struct cache_queue {
 	struct list_head	list;
diff -uNrp linux-2.6.15-rc5/net/sunrpc/sched.c linux-2.6.15-rc5-mutex/net/sunrpc/sched.c
--- linux-2.6.15-rc5/net/sunrpc/sched.c	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/sunrpc/sched.c	2005-12-15 17:14:56.000000000 +0000
@@ -64,7 +64,7 @@ static LIST_HEAD(all_tasks);
 /*
  * rpciod-related stuff
  */
-static DECLARE_MUTEX(rpciod_sema);
+static DECLARE_SEM_MUTEX(rpciod_sema);
 static unsigned int		rpciod_users;
 static struct workqueue_struct *rpciod_workqueue;
 
@@ -971,7 +971,7 @@ void rpc_killall_tasks(struct rpc_clnt *
 	spin_unlock(&rpc_sched_lock);
 }
 
-static DECLARE_MUTEX_LOCKED(rpciod_running);
+static DECLARE_SEM_MUTEX_LOCKED(rpciod_running);
 
 static void rpciod_killall(void)
 {
diff -uNrp linux-2.6.15-rc5/net/unix/garbage.c linux-2.6.15-rc5-mutex/net/unix/garbage.c
--- linux-2.6.15-rc5/net/unix/garbage.c	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/unix/garbage.c	2005-12-15 17:14:56.000000000 +0000
@@ -169,7 +169,7 @@ static void maybe_unmark_and_push(struct
 
 void unix_gc(void)
 {
-	static DECLARE_MUTEX(unix_gc_sem);
+	static DECLARE_SEM_MUTEX(unix_gc_sem);
 	int i;
 	struct sock *s;
 	struct sk_buff_head hitlist;
diff -uNrp linux-2.6.15-rc5/net/xfrm/xfrm_policy.c linux-2.6.15-rc5-mutex/net/xfrm/xfrm_policy.c
--- linux-2.6.15-rc5/net/xfrm/xfrm_policy.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/xfrm/xfrm_policy.c	2005-12-15 17:14:57.000000000 +0000
@@ -26,7 +26,7 @@
 #include <net/xfrm.h>
 #include <net/ip.h>
 
-DECLARE_MUTEX(xfrm_cfg_sem);
+DECLARE_SEM_MUTEX(xfrm_cfg_sem);
 EXPORT_SYMBOL(xfrm_cfg_sem);
 
 static DEFINE_RWLOCK(xfrm_policy_lock);
