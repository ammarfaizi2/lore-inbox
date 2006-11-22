Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161950AbWKVILv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161950AbWKVILv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161948AbWKVILv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:11:51 -0500
Received: from gilford.textdrive.com ([207.7.108.53]:42438 "EHLO
	gilford.textdrive.com") by vger.kernel.org with ESMTP
	id S1161947AbWKVILt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:11:49 -0500
Date: Wed, 22 Nov 2006 00:11:46 -0800
From: Ira Snyder <kernel@irasnyder.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse fix: add many lock annotations
Message-Id: <20061122001146.95a56c72.kernel@irasnyder.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sparse fix: add many lock annotations

This patch adds many lock annotations to the kernel source to quiet
warnings from sparse. In almost every case, it quiets the warning caused
by locks that are intentionally grabbed in one function and released in
another.

In the other cases, __acquire() and __release() are used to make sparse
believe that a lock was grabbed (even though it was not), in order to
make all exit points have equal lock counts. These follow the style in
kernel/sched.c.

Signed-off-by: Ira W. Snyder <kernel@irasnyder.com>

---
commit 0e11ae8a1a84552e55605690b40a6f54e0c317d9
tree a5ea88c1b700a429e183189148c8678b931e990a
parent b80ebbf39fc628afab7d9cf94b84cfc51d845b2f
author Ira W. Snyder <kernel@irasnyder.com> Tue, 21 Nov 2006 22:40:39 -0800
committer Ira W. Snyder <kernel@irasnyder.com> Tue, 21 Nov 2006 22:40:39 -0800

 arch/i386/kernel/smp.c                       |    2 ++
 drivers/acpi/osl.c                           |    2 ++
 drivers/infiniband/hw/mthca/mthca_qp.c       |   10 ++++++++--
 drivers/isdn/capi/kcapi_proc.c               |    2 ++
 drivers/net/bonding/bond_main.c              |    2 ++
 drivers/net/hamradio/bpqether.c              |    2 ++
 drivers/net/pppoe.c                          |    2 ++
 fs/nfs/client.c                              |    4 ++++
 kernel/rcutorture.c                          |    4 ++--
 net/802/tr.c                                 |    2 ++
 net/8021q/vlanproc.c                         |    2 ++
 net/appletalk/aarp.c                         |    2 ++
 net/appletalk/atalk_proc.c                   |    6 ++++++
 net/atm/br2684.c                             |    2 ++
 net/atm/proc.c                               |    2 ++
 net/ax25/af_ax25.c                           |    2 ++
 net/ax25/ax25_route.c                        |    2 ++
 net/ax25/ax25_uid.c                          |    2 ++
 net/core/dev.c                               |    2 ++
 net/core/dev_mcast.c                         |    2 ++
 net/core/neighbour.c                         |    2 ++
 net/core/sock.c                              |    2 ++
 net/dccp/ccid.c                              |    2 ++
 net/ipv4/fib_hash.c                          |    2 ++
 net/ipv4/ipmr.c                              |    2 ++
 net/ipv4/ipvs/ip_vs_ctl.c                    |    2 ++
 net/ipv4/netfilter/ip_conntrack_standalone.c |    4 ++++
 net/ipv4/netfilter/ipt_hashlimit.c           |    2 ++
 net/ipv4/netfilter/ipt_recent.c              |    2 ++
 net/ipv4/raw.c                               |    2 ++
 net/ipv4/udp.c                               |    2 ++
 net/ipv6/addrconf.c                          |    2 ++
 net/ipv6/anycast.c                           |    2 ++
 net/ipv6/ip6_flowlabel.c                     |    2 ++
 net/ipv6/raw.c                               |    2 ++
 net/ipx/ipx_proc.c                           |    5 +++++
 net/irda/discovery.c                         |    2 ++
 net/irda/ircomm/ircomm_core.c                |    2 ++
 net/irda/iriap.c                             |    2 ++
 net/irda/irlan/irlan_common.c                |    2 ++
 net/irda/irlap.c                             |    2 ++
 net/irda/irttp.c                             |    2 ++
 net/llc/llc_proc.c                           |    2 ++
 net/netfilter/nf_log.c                       |    2 ++
 net/netfilter/nfnetlink_log.c                |    2 ++
 net/netfilter/nfnetlink_queue.c              |    2 ++
 net/netlink/af_netlink.c                     |    2 ++
 net/netrom/af_netrom.c                       |    2 ++
 net/netrom/nr_route.c                        |    4 ++++
 net/packet/af_packet.c                       |    2 ++
 net/rose/af_rose.c                           |    2 ++
 net/rose/rose_route.c                        |    6 ++++++
 net/rxrpc/call.c                             |    2 ++
 net/sched/sch_generic.c                      |    2 ++
 net/sunrpc/cache.c                           |    2 ++
 net/tipc/socket.c                            |    2 ++
 net/unix/af_unix.c                           |    2 ++
 net/wanrouter/wanmain.c                      |    4 +++-
 net/wanrouter/wanproc.c                      |    2 ++
 net/x25/x25_proc.c                           |    4 ++++
 security/keys/proc.c                         |    4 ++++
 61 files changed, 150 insertions(+), 5 deletions(-)

diff --git a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
index 31e5c65..af1993f 100644
--- a/arch/i386/kernel/smp.c
+++ b/arch/i386/kernel/smp.c
@@ -507,11 +507,13 @@ struct call_data_struct {
 };
 
 void lock_ipi_call_lock(void)
+__acquires(call_lock)
 {
 	spin_lock_irq(&call_lock);
 }
 
 void unlock_ipi_call_lock(void)
+__releases(call_lock)
 {
 	spin_unlock_irq(&call_lock);
 }
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 068fe4f..e485740 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1004,6 +1004,7 @@ EXPORT_SYMBOL(max_cstate);
  */
 
 acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
+__acquires(lockp)
 {
 	acpi_cpu_flags flags;
 	spin_lock_irqsave(lockp, flags);
@@ -1015,6 +1016,7 @@ acpi_cpu_flags acpi_os_acquire_lock(acpi
  */
 
 void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
+__releases(lockp)
 {
 	spin_unlock_irqrestore(lockp, flags);
 }
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 6a7822e..28afe3e 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1268,9 +1268,12 @@ int mthca_alloc_qp(struct mthca_dev *dev
 }
 
 static void mthca_lock_cqs(struct mthca_cq *send_cq, struct mthca_cq *recv_cq)
+__acquires(send_cq->lock) __acquires(recv_cq->lock)
 {
-	if (send_cq == recv_cq)
+	if (send_cq == recv_cq) {
 		spin_lock_irq(&send_cq->lock);
+		__acquire(recv_cq->lock); /* Fake out sparse */
+	}
 	else if (send_cq->cqn < recv_cq->cqn) {
 		spin_lock_irq(&send_cq->lock);
 		spin_lock_nested(&recv_cq->lock, SINGLE_DEPTH_NESTING);
@@ -1281,9 +1284,12 @@ static void mthca_lock_cqs(struct mthca_
 }
 
 static void mthca_unlock_cqs(struct mthca_cq *send_cq, struct mthca_cq *recv_cq)
+__releases(send_cq->lock) __releases(recv_cq->lock)
 {
-	if (send_cq == recv_cq)
+	if (send_cq == recv_cq) {
 		spin_unlock_irq(&send_cq->lock);
+		__release(recv_cq->lock); /* Fake out sparse */
+	}
 	else if (send_cq->cqn < recv_cq->cqn) {
 		spin_unlock(&recv_cq->lock);
 		spin_unlock_irq(&send_cq->lock);
diff --git a/drivers/isdn/capi/kcapi_proc.c b/drivers/isdn/capi/kcapi_proc.c
index ca9dc00..a0c3a6e 100644
--- a/drivers/isdn/capi/kcapi_proc.c
+++ b/drivers/isdn/capi/kcapi_proc.c
@@ -260,6 +260,7 @@ static __inline__ struct capi_driver *ca
 }
 
 static void *capi_driver_start(struct seq_file *seq, loff_t *pos)
+__acquires(capi_drivers_list_lock)
 {
 	struct capi_driver *drv;
 	read_lock(&capi_drivers_list_lock);
@@ -276,6 +277,7 @@ static void *capi_driver_next(struct seq
 }
 
 static void capi_driver_stop(struct seq_file *seq, void *v)
+__releases(capi_drivers_list_lock)
 {
 	read_unlock(&capi_drivers_list_lock);
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17a4611..a9e271d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2913,6 +2913,7 @@ out:
 #define SEQ_START_TOKEN ((void *)1)
 
 static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(dev_base_lock) __acquires(bond->lock)
 {
 	struct bonding *bond = seq->private;
 	loff_t off = 0;
@@ -2952,6 +2953,7 @@ static void *bond_info_seq_next(struct s
 }
 
 static void bond_info_seq_stop(struct seq_file *seq, void *v)
+__releases(bond->lock) __releases(dev_base_lock)
 {
 	struct bonding *bond = seq->private;
 
diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index 889f338..89073f7 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -395,6 +395,7 @@ static const char * bpq_print_ethaddr(co
 }
 
 static void *bpq_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(rcu_read_lock)
 {
 	int i = 1;
 	struct bpqdev *bpqdev;
@@ -427,6 +428,7 @@ static void *bpq_seq_next(struct seq_fil
 }
 
 static void bpq_seq_stop(struct seq_file *seq, void *v)
+__releases(rcu_read_lock)
 {
 	rcu_read_unlock();
 }
diff --git a/drivers/net/pppoe.c b/drivers/net/pppoe.c
index 0adee73..ee0a088 100644
--- a/drivers/net/pppoe.c
+++ b/drivers/net/pppoe.c
@@ -994,6 +994,7 @@ out:
 }
 
 static void *pppoe_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(pppoe_hash_lock)
 {
 	loff_t l = *pos;
 
@@ -1027,6 +1028,7 @@ out:
 }
 
 static void pppoe_seq_stop(struct seq_file *seq, void *v)
+__releases(pppoe_hash_lock)
 {
 	read_unlock_bh(&pppoe_hash_lock);
 }
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 5fea638..ae2018b 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1223,6 +1223,7 @@ static int nfs_server_list_open(struct i
  * set up the iterator to start reading from the server list and return the first item
  */
 static void *nfs_server_list_start(struct seq_file *m, loff_t *_pos)
+__acquires(nfs_client_lock)
 {
 	struct list_head *_p;
 	loff_t pos = *_pos;
@@ -1262,6 +1263,7 @@ static void *nfs_server_list_next(struct
  * clean up after reading from the transports list
  */
 static void nfs_server_list_stop(struct seq_file *p, void *v)
+__releases(nfs_client_lock)
 {
 	spin_unlock(&nfs_client_lock);
 }
@@ -1314,6 +1316,7 @@ static int nfs_volume_list_open(struct i
  * set up the iterator to start reading from the volume list and return the first item
  */
 static void *nfs_volume_list_start(struct seq_file *m, loff_t *_pos)
+__acquires(nfs_client_lock)
 {
 	struct list_head *_p;
 	loff_t pos = *_pos;
@@ -1353,6 +1356,7 @@ static void *nfs_volume_list_next(struct
  * clean up after reading from the transports list
  */
 static void nfs_volume_list_stop(struct seq_file *p, void *v)
+__releases(nfs_client_lock)
 {
 	spin_unlock(&nfs_client_lock);
 }
diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index e2bda18..ca9d593 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -401,7 +401,7 @@ static void srcu_torture_cleanup(void)
 	cleanup_srcu_struct(&srcu_ctl);
 }
 
-static int srcu_torture_read_lock(void)
+static int srcu_torture_read_lock(void) __acquires(srcu_ctl)
 {
 	return srcu_read_lock(&srcu_ctl);
 }
@@ -419,7 +419,7 @@ static void srcu_read_delay(struct rcu_r
 		schedule_timeout_interruptible(longdelay);
 }
 
-static void srcu_torture_read_unlock(int idx)
+static void srcu_torture_read_unlock(int idx) __releases(srcu_ctl)
 {
 	srcu_read_unlock(&srcu_ctl, idx);
 }
diff --git a/net/802/tr.c b/net/802/tr.c
index 829deb4..f217ef0 100644
--- a/net/802/tr.c
+++ b/net/802/tr.c
@@ -486,6 +486,7 @@ static struct rif_cache *rif_get_idx(lof
 }
 
 static void *rif_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(rif_lock)
 {
 	spin_lock_irq(&rif_lock);
 
@@ -517,6 +518,7 @@ static void *rif_seq_next(struct seq_fil
 }
 
 static void rif_seq_stop(struct seq_file *seq, void *v)
+__releases(rif_lock)
 {
 	spin_unlock_irq(&rif_lock);
 }
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index a8fc0de..6a1970c 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -248,6 +248,7 @@ static struct net_device *vlan_skip(stru
 
 /* start read of /proc/net/vlan/config */ 
 static void *vlan_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(dev_base_lock)
 {
 	struct net_device *dev;
 	loff_t i = 1;
@@ -273,6 +274,7 @@ static void *vlan_seq_next(struct seq_fi
 }
 
 static void vlan_seq_stop(struct seq_file *seq, void *v)
+__releases(dev_base_lock)
 {
 	read_unlock(&dev_base_lock);
 }
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index f3777ec..07f223b 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -932,6 +932,7 @@ static struct aarp_entry *iter_next(stru
 }
 
 static void *aarp_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(aarp_lock)
 {
 	struct aarp_iter_state *iter = seq->private;
 
@@ -966,6 +967,7 @@ static void *aarp_seq_next(struct seq_fi
 }
 
 static void aarp_seq_stop(struct seq_file *seq, void *v)
+__releases(aarp_lock)
 {
 	read_unlock_bh(&aarp_lock);
 }
diff --git a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
index 7ae4916..6d023f4 100644
--- a/net/appletalk/atalk_proc.c
+++ b/net/appletalk/atalk_proc.c
@@ -26,6 +26,7 @@ static __inline__ struct atalk_iface *at
 }
 
 static void *atalk_seq_interface_start(struct seq_file *seq, loff_t *pos)
+__acquires(atalk_interfaces_lock)
 {
 	loff_t l = *pos;
 
@@ -51,6 +52,7 @@ out:
 }
 
 static void atalk_seq_interface_stop(struct seq_file *seq, void *v)
+__releases(atalk_interfaces_lock)
 {
 	read_unlock_bh(&atalk_interfaces_lock);
 }
@@ -85,6 +87,7 @@ static __inline__ struct atalk_route *at
 }
 
 static void *atalk_seq_route_start(struct seq_file *seq, loff_t *pos)
+__acquires(atalk_routes_lock)
 {
 	loff_t l = *pos;
 
@@ -110,6 +113,7 @@ out:
 }
 
 static void atalk_seq_route_stop(struct seq_file *seq, void *v)
+__releases(atalk_routes_lock)
 {
 	read_unlock_bh(&atalk_routes_lock);
 }
@@ -153,6 +157,7 @@ found:
 }
 
 static void *atalk_seq_socket_start(struct seq_file *seq, loff_t *pos)
+__acquires(atalk_sockets_lock)
 {
 	loff_t l = *pos;
 
@@ -175,6 +180,7 @@ out:
 }
 
 static void atalk_seq_socket_stop(struct seq_file *seq, void *v)
+__releases(atalk_sockets_lock)
 {
 	read_unlock_bh(&atalk_sockets_lock);
 }
diff --git a/net/atm/br2684.c b/net/atm/br2684.c
index d00cca9..5984322 100644
--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -680,6 +680,7 @@ static struct atm_ioctl br2684_ioctl_ops
 
 #ifdef CONFIG_PROC_FS
 static void *br2684_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(devs_lock)
 {
 	loff_t offs = 0;
 	struct br2684_dev *brd;
@@ -706,6 +707,7 @@ static void *br2684_seq_next(struct seq_
 }
 
 static void br2684_seq_stop(struct seq_file *seq, void *v)
+__releases(devs_lock)
 {
 	read_unlock(&devs_lock);
 }
diff --git a/net/atm/proc.c b/net/atm/proc.c
index 91fe5f5..e7ab43b 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -141,6 +141,7 @@ static int vcc_seq_release(struct inode
 }
 
 static void *vcc_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(vcc_sklist_lock)
 {
 	struct vcc_state *state = seq->private;
 	loff_t left = *pos;
@@ -151,6 +152,7 @@ static void *vcc_seq_start(struct seq_fi
 }
 
 static void vcc_seq_stop(struct seq_file *seq, void *v)
+__releases(vcc_sklist_lock)
 {
 	read_unlock(&vcc_sklist_lock);
 }
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 000695c..52a2076 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1848,6 +1848,7 @@ static int ax25_ioctl(struct socket *soc
 #ifdef CONFIG_PROC_FS
 
 static void *ax25_info_start(struct seq_file *seq, loff_t *pos)
+__acquires(ax25_list_lock)
 {
 	struct ax25_cb *ax25;
 	struct hlist_node *node;
@@ -1871,6 +1872,7 @@ static void *ax25_info_next(struct seq_f
 }
 	
 static void ax25_info_stop(struct seq_file *seq, void *v)
+__releases(a25_list_lock)
 {
 	spin_unlock_bh(&ax25_list_lock);
 }
diff --git a/net/ax25/ax25_route.c b/net/ax25/ax25_route.c
index 51b7bda..aa9cca7 100644
--- a/net/ax25/ax25_route.c
+++ b/net/ax25/ax25_route.c
@@ -249,6 +249,7 @@ int ax25_rt_ioctl(unsigned int cmd, void
 #ifdef CONFIG_PROC_FS
 
 static void *ax25_rt_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(ax25_route_lock)
 {
 	struct ax25_route *ax25_rt;
 	int i = 1;
@@ -274,6 +275,7 @@ static void *ax25_rt_seq_next(struct seq
 }
 
 static void ax25_rt_seq_stop(struct seq_file *seq, void *v)
+__releases(ax25_route_lock)
 {
 	read_unlock(&ax25_route_lock);
 }
diff --git a/net/ax25/ax25_uid.c b/net/ax25/ax25_uid.c
index 5e9a81e..4dc2e91 100644
--- a/net/ax25/ax25_uid.c
+++ b/net/ax25/ax25_uid.c
@@ -145,6 +145,7 @@ int ax25_uid_ioctl(int cmd, struct socka
 #ifdef CONFIG_PROC_FS
 
 static void *ax25_uid_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(ax25_uid_lock)
 {
 	struct ax25_uid_assoc *pt;
 	struct hlist_node *node;
@@ -168,6 +169,7 @@ static void *ax25_uid_seq_next(struct se
 }
 
 static void ax25_uid_seq_stop(struct seq_file *seq, void *v)
+__releases(ax25_uid_lock)
 {
 	read_unlock(&ax25_uid_lock);
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 81c426a..87ffb77 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2093,6 +2093,7 @@ static __inline__ struct net_device *dev
 }
 
 void *dev_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(dev_base_lock)
 {
 	read_lock(&dev_base_lock);
 	return *pos ? dev_get_idx(*pos - 1) : SEQ_START_TOKEN;
@@ -2105,6 +2106,7 @@ void *dev_seq_next(struct seq_file *seq,
 }
 
 void dev_seq_stop(struct seq_file *seq, void *v)
+__releases(dev_base_lock)
 {
 	read_unlock(&dev_base_lock);
 }
diff --git a/net/core/dev_mcast.c b/net/core/dev_mcast.c
index b22648d..8d86f94 100644
--- a/net/core/dev_mcast.c
+++ b/net/core/dev_mcast.c
@@ -219,6 +219,7 @@ void dev_mc_discard(struct net_device *d
 
 #ifdef CONFIG_PROC_FS
 static void *dev_mc_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(dev_base_lock)
 {
 	struct net_device *dev;
 	loff_t off = 0;
@@ -239,6 +240,7 @@ static void *dev_mc_seq_next(struct seq_
 }
 
 static void dev_mc_seq_stop(struct seq_file *seq, void *v)
+__releases(dev_base_lock)
 {
 	read_unlock(&dev_base_lock);
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index b4b4783..841840f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2256,6 +2256,7 @@ static void *neigh_get_idx_any(struct se
 }
 
 void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl, unsigned int neigh_seq_flags)
+__acquires(tbl->lock)
 {
 	struct neigh_seq_state *state = seq->private;
 	loff_t pos_minus_one;
@@ -2299,6 +2300,7 @@ out:
 EXPORT_SYMBOL(neigh_seq_next);
 
 void neigh_seq_stop(struct seq_file *seq, void *v)
+__releases(tbl->lock)
 {
 	struct neigh_seq_state *state = seq->private;
 	struct neigh_table *tbl = state->tbl;
diff --git a/net/core/sock.c b/net/core/sock.c
index ee6cd25..1a0771e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1836,6 +1836,7 @@ out:
 }
 
 static void *proto_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(proto_list_lock)
 {
 	read_lock(&proto_list_lock);
 	return *pos ? proto_get_idx(*pos - 1) : SEQ_START_TOKEN;
@@ -1848,6 +1849,7 @@ static void *proto_seq_next(struct seq_f
 }
 
 static void proto_seq_stop(struct seq_file *seq, void *v)
+__releases(proto_list_lock)
 {
 	read_unlock(&proto_list_lock);
 }
diff --git a/net/dccp/ccid.c b/net/dccp/ccid.c
index ff05e59..c4f5500 100644
--- a/net/dccp/ccid.c
+++ b/net/dccp/ccid.c
@@ -23,6 +23,7 @@ static DEFINE_SPINLOCK(ccids_lock);
  * veeery rare, but read access should be free of any exclusive locks.
  */
 static void ccids_write_lock(void)
+__acquires(ccids_lock)
 {
 	spin_lock(&ccids_lock);
 	while (atomic_read(&ccids_lockct) != 0) {
@@ -33,6 +34,7 @@ static void ccids_write_lock(void)
 }
 
 static inline void ccids_write_unlock(void)
+__releases(ccids_lock)
 {
 	spin_unlock(&ccids_lock);
 }
diff --git a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
index 107bb6c..cd1ec50 100644
--- a/net/ipv4/fib_hash.c
+++ b/net/ipv4/fib_hash.c
@@ -946,6 +946,7 @@ static struct fib_alias *fib_get_idx(str
 }
 
 static void *fib_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(fib_hash_lock)
 {
 	void *v = NULL;
 
@@ -962,6 +963,7 @@ static void *fib_seq_next(struct seq_fil
 }
 
 static void fib_seq_stop(struct seq_file *seq, void *v)
+__releases(fib_hash_lock)
 {
 	read_unlock(&fib_hash_lock);
 }
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 97cfa97..198c26f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1637,6 +1637,7 @@ static struct vif_device *ipmr_vif_seq_i
 }
 
 static void *ipmr_vif_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(mrt_lock)
 {
 	read_lock(&mrt_lock);
 	return *pos ? ipmr_vif_seq_idx(seq->private, *pos - 1) 
@@ -1660,6 +1661,7 @@ static void *ipmr_vif_seq_next(struct se
 }
 
 static void ipmr_vif_seq_stop(struct seq_file *seq, void *v)
+__releases(mrt_lock)
 {
 	read_unlock(&mrt_lock);
 }
diff --git a/net/ipv4/ipvs/ip_vs_ctl.c b/net/ipv4/ipvs/ip_vs_ctl.c
index f261616..a42ff21 100644
--- a/net/ipv4/ipvs/ip_vs_ctl.c
+++ b/net/ipv4/ipvs/ip_vs_ctl.c
@@ -1680,6 +1680,7 @@ static struct ip_vs_service *ip_vs_info_
 }
 
 static void *ip_vs_info_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(__ip_vs_svc_lock)
 {
 
 	read_lock_bh(&__ip_vs_svc_lock);
@@ -1733,6 +1734,7 @@ static void *ip_vs_info_seq_next(struct
 }
 
 static void ip_vs_info_seq_stop(struct seq_file *seq, void *v)
+__releases(__ip_vs_svc_lock)
 {
 	read_unlock_bh(&__ip_vs_svc_lock);
 }
diff --git a/net/ipv4/netfilter/ip_conntrack_standalone.c b/net/ipv4/netfilter/ip_conntrack_standalone.c
index 0213575..da14b50 100644
--- a/net/ipv4/netfilter/ip_conntrack_standalone.c
+++ b/net/ipv4/netfilter/ip_conntrack_standalone.c
@@ -117,6 +117,7 @@ static struct list_head *ct_get_idx(stru
 }
 
 static void *ct_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(ip_conntrack_lock)
 {
 	read_lock_bh(&ip_conntrack_lock);
 	return ct_get_idx(seq, *pos);
@@ -129,6 +130,7 @@ static void *ct_seq_next(struct seq_file
 }
   
 static void ct_seq_stop(struct seq_file *s, void *v)
+__releases(ip_conntrack_lock)
 {
 	read_unlock_bh(&ip_conntrack_lock);
 }
@@ -236,6 +238,7 @@ static struct file_operations ct_file_op
   
 /* expects */
 static void *exp_seq_start(struct seq_file *s, loff_t *pos)
+__acquires(ip_conntrack_lock)
 {
 	struct list_head *e = &ip_conntrack_expect_list;
 	loff_t i;
@@ -269,6 +272,7 @@ static void *exp_seq_next(struct seq_fil
 }
 
 static void exp_seq_stop(struct seq_file *s, void *v)
+__releases(ip_conntrack_lock)
 {
 	read_unlock_bh(&ip_conntrack_lock);
 }
diff --git a/net/ipv4/netfilter/ipt_hashlimit.c b/net/ipv4/netfilter/ipt_hashlimit.c
index 33ccdbf..c677ccc 100644
--- a/net/ipv4/netfilter/ipt_hashlimit.c
+++ b/net/ipv4/netfilter/ipt_hashlimit.c
@@ -578,6 +578,7 @@ static struct ipt_match ipt_hashlimit =
 /* PROC stuff */
 
 static void *dl_seq_start(struct seq_file *s, loff_t *pos)
+__acquires(htable->lock)
 {
 	struct proc_dir_entry *pde = s->private;
 	struct ipt_hashlimit_htable *htable = pde->data;
@@ -610,6 +611,7 @@ static void *dl_seq_next(struct seq_file
 }
 
 static void dl_seq_stop(struct seq_file *s, void *v)
+__releases(htable->lock)
 {
 	struct proc_dir_entry *pde = s->private;
 	struct ipt_hashlimit_htable *htable = pde->data;
diff --git a/net/ipv4/netfilter/ipt_recent.c b/net/ipv4/netfilter/ipt_recent.c
index 126db44..2eee235 100644
--- a/net/ipv4/netfilter/ipt_recent.c
+++ b/net/ipv4/netfilter/ipt_recent.c
@@ -320,6 +320,7 @@ struct recent_iter_state {
 };
 
 static void *recent_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(recent_lock)
 {
 	struct recent_iter_state *st = seq->private;
 	struct recent_table *t = st->table;
@@ -354,6 +355,7 @@ static void *recent_seq_next(struct seq_
 }
 
 static void recent_seq_stop(struct seq_file *s, void *v)
+__releases(recent_lock)
 {
 	spin_unlock_bh(&recent_lock);
 }
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 5c31dea..503f7f4 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -829,6 +829,7 @@ static struct sock *raw_get_idx(struct s
 }
 
 static void *raw_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(raw_v4_lock)
 {
 	read_lock(&raw_v4_lock);
 	return *pos ? raw_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
@@ -847,6 +848,7 @@ static void *raw_seq_next(struct seq_fil
 }
 
 static void raw_seq_stop(struct seq_file *seq, void *v)
+__releases(raw_v4_lock)
 {
 	read_unlock(&raw_v4_lock);
 }
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 865d752..34ce87a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1480,6 +1480,7 @@ static struct sock *udp_get_idx(struct s
 }
 
 static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(udp_hash_lock)
 {
 	read_lock(&udp_hash_lock);
 	return *pos ? udp_get_idx(seq, *pos-1) : (void *)1;
@@ -1499,6 +1500,7 @@ static void *udp_seq_next(struct seq_fil
 }
 
 static void udp_seq_stop(struct seq_file *seq, void *v)
+__releases(udp_hash_lock)
 {
 	read_unlock(&udp_hash_lock);
 }
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index b312a5f..bc51cc8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2708,6 +2708,7 @@ static struct inet6_ifaddr *if6_get_idx(
 }
 
 static void *if6_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(addrconf_hash_lock)
 {
 	read_lock_bh(&addrconf_hash_lock);
 	return if6_get_idx(seq, *pos);
@@ -2723,6 +2724,7 @@ static void *if6_seq_next(struct seq_fil
 }
 
 static void if6_seq_stop(struct seq_file *seq, void *v)
+__releases(addrconf_hash_lock)
 {
 	read_unlock_bh(&addrconf_hash_lock);
 }
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index a960476..cc3ba7f 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -500,6 +500,7 @@ static struct ifacaddr6 *ac6_get_idx(str
 }
 
 static void *ac6_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(dev_base_lock)
 {
 	read_lock(&dev_base_lock);
 	return ac6_get_idx(seq, *pos);
@@ -514,6 +515,7 @@ static void *ac6_seq_next(struct seq_fil
 }
 
 static void ac6_seq_stop(struct seq_file *seq, void *v)
+__releases(dev_base_lock)
 {
 	struct ac6_iter_state *state = ac6_seq_private(seq);
 	if (likely(state->idev != NULL)) {
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 6d4533b..faa116e 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -605,6 +605,7 @@ static struct ip6_flowlabel *ip6fl_get_i
 }
 
 static void *ip6fl_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(ip6_fl_lock)
 {
 	read_lock_bh(&ip6_fl_lock);
 	return *pos ? ip6fl_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
@@ -623,6 +624,7 @@ static void *ip6fl_seq_next(struct seq_f
 }
 
 static void ip6fl_seq_stop(struct seq_file *seq, void *v)
+__releases(ip6_fl_lock)
 {
 	read_unlock_bh(&ip6_fl_lock);
 }
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index d6dedc4..798ac9d 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1175,6 +1175,7 @@ static struct sock *raw6_get_idx(struct
 }
 
 static void *raw6_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(raw_v6_lock)
 {
 	read_lock(&raw_v6_lock);
 	return *pos ? raw6_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
@@ -1193,6 +1194,7 @@ static void *raw6_seq_next(struct seq_fi
 }
 
 static void raw6_seq_stop(struct seq_file *seq, void *v)
+__releases(raw_v6_lock)
 {
 	read_unlock(&raw_v6_lock);
 }
diff --git a/net/ipx/ipx_proc.c b/net/ipx/ipx_proc.c
index b7463df..f6b17c2 100644
--- a/net/ipx/ipx_proc.c
+++ b/net/ipx/ipx_proc.c
@@ -34,6 +34,7 @@ static struct ipx_interface *ipx_interfa
 }
 
 static void *ipx_seq_interface_start(struct seq_file *seq, loff_t *pos)
+__acquires(ipx_interfaces_lock)
 {
 	loff_t l = *pos;
 
@@ -54,6 +55,7 @@ static void *ipx_seq_interface_next(stru
 }
 
 static void ipx_seq_interface_stop(struct seq_file *seq, void *v)
+__releases(ipx_interfaces_lock)
 {
 	spin_unlock_bh(&ipx_interfaces_lock);
 }
@@ -119,6 +121,7 @@ out:
 }
 
 static void *ipx_seq_route_start(struct seq_file *seq, loff_t *pos)
+__acquires(ipx_routes_lock)
 {
 	loff_t l = *pos;
 	read_lock_bh(&ipx_routes_lock);
@@ -138,6 +141,7 @@ static void *ipx_seq_route_next(struct s
 }
 
 static void ipx_seq_route_stop(struct seq_file *seq, void *v)
+__releases(ipx_routes_lock)
 {
 	read_unlock_bh(&ipx_routes_lock);
 }
@@ -190,6 +194,7 @@ found:
 }
 
 static void *ipx_seq_socket_start(struct seq_file *seq, loff_t *pos)
+__acquires(ipx_interfaces_lock)
 {
 	loff_t l = *pos;
 
diff --git a/net/irda/discovery.c b/net/irda/discovery.c
index 3fefc82..b3e9825 100644
--- a/net/irda/discovery.c
+++ b/net/irda/discovery.c
@@ -331,6 +331,7 @@ static inline discovery_t *discovery_seq
 }
 
 static void *discovery_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(irlmp->cachelog->hb_spinlock)
 {
 	spin_lock_irq(&irlmp->cachelog->hb_spinlock);
         return *pos ? discovery_seq_idx(*pos - 1) : SEQ_START_TOKEN;
@@ -345,6 +346,7 @@ static void *discovery_seq_next(struct s
 }
 
 static void discovery_seq_stop(struct seq_file *seq, void *v)
+__releases(irlmp->cachelog->hb_spinlock)
 {
 	spin_unlock_irq(&irlmp->cachelog->hb_spinlock);
 }
diff --git a/net/irda/ircomm/ircomm_core.c b/net/irda/ircomm/ircomm_core.c
index ad6b6af..3ade8d2 100644
--- a/net/irda/ircomm/ircomm_core.c
+++ b/net/irda/ircomm/ircomm_core.c
@@ -506,6 +506,7 @@ EXPORT_SYMBOL(ircomm_flow_request);
 
 #ifdef CONFIG_PROC_FS
 static void *ircomm_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(ircomm->hb_spinlock)
 {
 	struct ircomm_cb *self;
 	loff_t off = 0;
@@ -530,6 +531,7 @@ static void *ircomm_seq_next(struct seq_
 }
 
 static void ircomm_seq_stop(struct seq_file *seq, void *v)
+__releases(ircomm->hb_spinlock)
 {
 	spin_unlock_irq(&ircomm->hb_spinlock);
 }
diff --git a/net/irda/iriap.c b/net/irda/iriap.c
index 415cf4e..e88ba81 100644
--- a/net/irda/iriap.c
+++ b/net/irda/iriap.c
@@ -985,6 +985,7 @@ static inline struct ias_object *irias_s
 }
 
 static void *irias_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(irias_objects->hb_spinlock)
 {
 	spin_lock_irq(&irias_objects->hb_spinlock);
 
@@ -1001,6 +1002,7 @@ static void *irias_seq_next(struct seq_f
 }
 
 static void irias_seq_stop(struct seq_file *seq, void *v)
+__releases(irias_objects->hb_spinlock)
 {
 	spin_unlock_irq(&irias_objects->hb_spinlock);
 }
diff --git a/net/irda/irlan/irlan_common.c b/net/irda/irlan/irlan_common.c
index 9b962f2..0af821d 100644
--- a/net/irda/irlan/irlan_common.c
+++ b/net/irda/irlan/irlan_common.c
@@ -1121,6 +1121,7 @@ int irlan_extract_param(__u8 *buf, char
  *	or NULL if end of file
  */
 static void *irlan_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(rcu_read_lock)
 {
 	int i = 1;
 	struct irlan_cb *self;
@@ -1154,6 +1155,7 @@ static void *irlan_seq_next(struct seq_f
 
 /* End of reading /proc file */
 static void irlan_seq_stop(struct seq_file *seq, void *v)
+__releases(rcu_read_lock)
 {
 	rcu_read_unlock();
 }
diff --git a/net/irda/irlap.c b/net/irda/irlap.c
index e7852a0..05341fe 100644
--- a/net/irda/irlap.c
+++ b/net/irda/irlap.c
@@ -1101,6 +1101,7 @@ struct irlap_iter_state {
 };
 
 static void *irlap_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(irlap->hb_spinlock)
 {
 	struct irlap_iter_state *iter = seq->private;
 	struct irlap_cb *self;
@@ -1129,6 +1130,7 @@ static void *irlap_seq_next(struct seq_f
 }
 
 static void irlap_seq_stop(struct seq_file *seq, void *v)
+__releases(irlap->hb_spinlock)
 {
 	spin_unlock_irq(&irlap->hb_spinlock);
 }
diff --git a/net/irda/irttp.c b/net/irda/irttp.c
index 3c2e70b..55d38f7 100644
--- a/net/irda/irttp.c
+++ b/net/irda/irttp.c
@@ -1789,6 +1789,7 @@ struct irttp_iter_state {
 };
 
 static void *irttp_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(irttp->tsaps->hb_spinlock)
 {
 	struct irttp_iter_state *iter = seq->private;
 	struct tsap_cb *self;
@@ -1818,6 +1819,7 @@ static void *irttp_seq_next(struct seq_f
 }
 
 static void irttp_seq_stop(struct seq_file *seq, void *v)
+__releases(irttp->tsaps->hb_spinlock)
 {
 	spin_unlock_irq(&irttp->tsaps->hb_spinlock);
 }
diff --git a/net/llc/llc_proc.c b/net/llc/llc_proc.c
index 19308fe..0e9bdf2 100644
--- a/net/llc/llc_proc.c
+++ b/net/llc/llc_proc.c
@@ -54,6 +54,7 @@ found:
 }
 
 static void *llc_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(llc_sap_list_lock)
 {
 	loff_t l = *pos;
 
@@ -98,6 +99,7 @@ out:
 }
 
 static void llc_seq_stop(struct seq_file *seq, void *v)
+__releases(llc_sap_list_lock)
 {
 	if (v && v != SEQ_START_TOKEN) {
 		struct sock *sk = v;
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 8901b3a..9a79154 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -102,6 +102,7 @@ EXPORT_SYMBOL(nf_log_packet);
 
 #ifdef CONFIG_PROC_FS
 static void *seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(rcu_read_lock)
 {
 	rcu_read_lock();
 
@@ -122,6 +123,7 @@ static void *seq_next(struct seq_file *s
 }
 
 static void seq_stop(struct seq_file *s, void *v)
+__releases(rcu_read_lock)
 {
 	rcu_read_unlock();
 }
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 1e5207b..682c900 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -972,6 +972,7 @@ static struct hlist_node *get_idx(struct
 }
 
 static void *seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(instances_lock)
 {
 	read_lock_bh(&instances_lock);
 	return get_idx(seq, *pos);
@@ -984,6 +985,7 @@ static void *seq_next(struct seq_file *s
 }
 
 static void seq_stop(struct seq_file *s, void *v)
+__releases(instances_lock)
 {
 	read_unlock_bh(&instances_lock);
 }
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index e815a9a..da52c85 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1014,6 +1014,7 @@ static struct hlist_node *get_idx(struct
 }
 
 static void *seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(instances_lock)
 {
 	read_lock_bh(&instances_lock);
 	return get_idx(seq, *pos);
@@ -1026,6 +1027,7 @@ static void *seq_next(struct seq_file *s
 }
 
 static void seq_stop(struct seq_file *s, void *v)
+__releases(instances_lock)
 {
 	read_unlock_bh(&instances_lock);
 }
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index d527c89..9ab5f0c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1614,6 +1614,7 @@ static struct sock *netlink_seq_socket_i
 }
 
 static void *netlink_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(nl_table_lock)
 {
 	read_lock(&nl_table_lock);
 	return *pos ? netlink_seq_socket_idx(seq, *pos - 1) : SEQ_START_TOKEN;
@@ -1657,6 +1658,7 @@ static void *netlink_seq_next(struct seq
 }
 
 static void netlink_seq_stop(struct seq_file *seq, void *v)
+__releases(nl_table_lock)
 {
 	read_unlock(&nl_table_lock);
 }
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 1d50f80..871ef0b 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -1237,6 +1237,7 @@ static int nr_ioctl(struct socket *sock,
 #ifdef CONFIG_PROC_FS
 
 static void *nr_info_start(struct seq_file *seq, loff_t *pos)
+__acquires(nr_list_lock)
 {
 	struct sock *s;
 	struct hlist_node *node;
@@ -1263,6 +1264,7 @@ static void *nr_info_next(struct seq_fil
 }
 	
 static void nr_info_stop(struct seq_file *seq, void *v)
+__releases(nr_list_lock)
 {
 	spin_unlock_bh(&nr_list_lock);
 }
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index c11737f..8b6f0d6 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -848,6 +848,7 @@ int nr_route_frame(struct sk_buff *skb,
 #ifdef CONFIG_PROC_FS
 
 static void *nr_node_start(struct seq_file *seq, loff_t *pos)
+__acquires(nr_node_list_lock)
 {
 	struct nr_node *nr_node;
 	struct hlist_node *node;
@@ -879,6 +880,7 @@ static void *nr_node_next(struct seq_fil
 }
 
 static void nr_node_stop(struct seq_file *seq, void *v)
+__releases(nr_node_list_lock)
 {
 	spin_unlock_bh(&nr_node_list_lock);
 }
@@ -934,6 +936,7 @@ struct file_operations nr_nodes_fops = {
 };
 
 static void *nr_neigh_start(struct seq_file *seq, loff_t *pos)
+__acquires(nr_neigh_list_lock)
 {
 	struct nr_neigh *nr_neigh;
 	struct hlist_node *node;
@@ -963,6 +966,7 @@ static void *nr_neigh_next(struct seq_fi
 }
 
 static void nr_neigh_stop(struct seq_file *seq, void *v)
+__releases(nr_neigh_list_lock)
 {
 	spin_unlock_bh(&nr_neigh_list_lock);
 }
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f4ccb90..f61f76c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1842,6 +1842,7 @@ static inline struct sock *packet_seq_id
 }
 
 static void *packet_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(packet_sklist_lock)
 {
 	read_lock(&packet_sklist_lock);
 	return *pos ? packet_seq_idx(*pos - 1) : SEQ_START_TOKEN;
@@ -1856,6 +1857,7 @@ static void *packet_seq_next(struct seq_
 }
 
 static void packet_seq_stop(struct seq_file *seq, void *v)
+__releases(packet_sklist_lock)
 {
 	read_unlock(&packet_sklist_lock);		
 }
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 08a5428..616d95f 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1342,6 +1342,7 @@ static int rose_ioctl(struct socket *soc
 
 #ifdef CONFIG_PROC_FS
 static void *rose_info_start(struct seq_file *seq, loff_t *pos)
+__acquires(rose_list_lock)
 {
 	int i;
 	struct sock *s;
@@ -1369,6 +1370,7 @@ static void *rose_info_next(struct seq_f
 }
 	
 static void rose_info_stop(struct seq_file *seq, void *v)
+__releases(rose_list_lock)
 {
 	spin_unlock_bh(&rose_list_lock);
 }
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index a22542f..a5c7d15 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -1065,6 +1065,7 @@ out:
 #ifdef CONFIG_PROC_FS
 
 static void *rose_node_start(struct seq_file *seq, loff_t *pos)
+__acquires(rose_neigh_list_lock)
 {
 	struct rose_node *rose_node;
 	int i = 1;
@@ -1088,6 +1089,7 @@ static void *rose_node_next(struct seq_f
 }
 
 static void rose_node_stop(struct seq_file *seq, void *v)
+__releases(rose_neigh_list_lock)
 {
 	spin_unlock_bh(&rose_neigh_list_lock);
 }
@@ -1141,6 +1143,7 @@ struct file_operations rose_nodes_fops =
 };
 
 static void *rose_neigh_start(struct seq_file *seq, loff_t *pos)
+__acquires(rose_neigh_list_lock)
 {
 	struct rose_neigh *rose_neigh;
 	int i = 1;
@@ -1164,6 +1167,7 @@ static void *rose_neigh_next(struct seq_
 }
 
 static void rose_neigh_stop(struct seq_file *seq, void *v)
+__releases(rose_neigh_list_lock)
 {
 	spin_unlock_bh(&rose_neigh_list_lock);
 }
@@ -1224,6 +1228,7 @@ struct file_operations rose_neigh_fops =
 
 
 static void *rose_route_start(struct seq_file *seq, loff_t *pos)
+__acquires(rose_route_list_lock)
 {
 	struct rose_route *rose_route;
 	int i = 1;
@@ -1247,6 +1252,7 @@ static void *rose_route_next(struct seq_
 }
 
 static void rose_route_stop(struct seq_file *seq, void *v)
+__releases(rose_route_list_lock)
 {
 	spin_unlock_bh(&rose_route_list_lock);
 }
diff --git a/net/rxrpc/call.c b/net/rxrpc/call.c
index d07122b..c9c1797 100644
--- a/net/rxrpc/call.c
+++ b/net/rxrpc/call.c
@@ -838,6 +838,7 @@ void rxrpc_call_do_stuff(struct rxrpc_ca
  * - the supplied error code is sent as the packet data
  */
 static int __rxrpc_call_abort(struct rxrpc_call *call, int errno)
+__releases(call->lock)
 {
 	struct rxrpc_connection *conn = call->conn;
 	struct rxrpc_message *msg;
@@ -1643,6 +1644,7 @@ static int rxrpc_call_record_ACK(struct
  bad_queue:
 	panic("%s(): acks_pendq in bad state (packet #%u absent)\n",
 	      __FUNCTION__, seq);
+	__release(call->lock); /* Fake out sparse */
 
 } /* end rxrpc_call_record_ACK() */
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 88c6a99..13ddd12 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -55,12 +55,14 @@
 DEFINE_RWLOCK(qdisc_tree_lock);
 
 void qdisc_lock_tree(struct net_device *dev)
+__acquires(qdisc_tree_lock) __acquires(dev->queue_lock)
 {
 	write_lock(&qdisc_tree_lock);
 	spin_lock_bh(&dev->queue_lock);
 }
 
 void qdisc_unlock_tree(struct net_device *dev)
+__releases(dev->queue_lock) __releases(qdisc_tree_lock)
 {
 	spin_unlock_bh(&dev->queue_lock);
 	write_unlock(&qdisc_tree_lock);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 00cb388..d2732d9 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1126,6 +1126,7 @@ struct handle {
 };
 
 static void *c_start(struct seq_file *m, loff_t *pos)
+__acquires(cd->hash_lock)
 {
 	loff_t n = *pos;
 	unsigned hash, entry;
@@ -1182,6 +1183,7 @@ static void *c_next(struct seq_file *m,
 }
 
 static void c_stop(struct seq_file *m, void *p)
+__releases(cd->hash_lock)
 {
 	struct cache_detail *cd = ((struct handle*)m->private)->cd;
 	read_unlock(&cd->hash_lock);
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 2a6a5a6..8a69312 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -89,6 +89,7 @@ static atomic_t tipc_queue_size = ATOMIC
  * See net.c for description of locking policy.
  */
 static void sock_lock(struct tipc_sock* tsock)
+__acquires(tsock->p->lock)
 {
         spin_lock_bh(tsock->p->lock);       
 }
@@ -97,6 +98,7 @@ static void sock_lock(struct tipc_sock*
  * sock_unlock(): Unlock a port/socket pair
  */
 static void sock_unlock(struct tipc_sock* tsock)
+__releases(tsock->p->lock)
 {
         spin_unlock_bh(tsock->p->lock);
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b43a278..33f20c5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1945,6 +1945,7 @@ static struct sock *unix_seq_idx(int *it
 
 
 static void *unix_seq_start(struct seq_file *seq, loff_t *pos)
+__acquires(unix_table_lock)
 {
 	spin_lock(&unix_table_lock);
 	return *pos ? unix_seq_idx(seq->private, *pos - 1) : ((void *) 1);
@@ -1960,6 +1961,7 @@ static void *unix_seq_next(struct seq_fi
 }
 
 static void unix_seq_stop(struct seq_file *seq, void *v)
+__releases(unix_table_lock)
 {
 	spin_unlock(&unix_table_lock);
 }
diff --git a/net/wanrouter/wanmain.c b/net/wanrouter/wanmain.c
index 9479659..f1c4de0 100644
--- a/net/wanrouter/wanmain.c
+++ b/net/wanrouter/wanmain.c
@@ -857,12 +857,14 @@ static int wanrouter_delete_interface(st
 }
 
 void lock_adapter_irq(spinlock_t *lock, unsigned long *smp_flags)
+__acquires(lock)
 {
-       	spin_lock_irqsave(lock, *smp_flags);
+	spin_lock_irqsave(lock, *smp_flags);
 }
 
 
 void unlock_adapter_irq(spinlock_t *lock, unsigned long *smp_flags)
+__releases(lock)
 {
 	spin_unlock_irqrestore(lock, *smp_flags);
 }
diff --git a/net/wanrouter/wanproc.c b/net/wanrouter/wanproc.c
index 930ea59..e9fdbc7 100644
--- a/net/wanrouter/wanproc.c
+++ b/net/wanrouter/wanproc.c
@@ -79,6 +79,7 @@ static struct proc_dir_entry *proc_route
  *	Iterator
  */
 static void *r_start(struct seq_file *m, loff_t *pos)
+__acquires(lock_kernel)
 {
 	struct wan_device *wandev;
 	loff_t l = *pos;
@@ -100,6 +101,7 @@ static void *r_next(struct seq_file *m,
 }
 
 static void r_stop(struct seq_file *m, void *v)
+__releases(lock_kernel)
 {
 	unlock_kernel();
 }
diff --git a/net/x25/x25_proc.c b/net/x25/x25_proc.c
index a11837d..69eee76 100644
--- a/net/x25/x25_proc.c
+++ b/net/x25/x25_proc.c
@@ -40,6 +40,7 @@ found:
 }
 
 static void *x25_seq_route_start(struct seq_file *seq, loff_t *pos)
+__acquires(x25_route_list_lock)
 {
 	loff_t l = *pos;
 
@@ -69,6 +70,7 @@ out:
 }
 
 static void x25_seq_route_stop(struct seq_file *seq, void *v)
+__releases(x25_route_list_lock)
 {
 	read_unlock_bh(&x25_route_list_lock);
 }
@@ -104,6 +106,7 @@ found:
 }
 
 static void *x25_seq_socket_start(struct seq_file *seq, loff_t *pos)
+__acquires(x25_list_lock)
 {
 	loff_t l = *pos;
 
@@ -126,6 +129,7 @@ out:
 }
 
 static void x25_seq_socket_stop(struct seq_file *seq, void *v)
+__releases(x25_list_lock)
 {
 	read_unlock_bh(&x25_list_lock);
 }
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 686a9ee..3d38a4e 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -102,6 +102,7 @@ static int proc_keys_open(struct inode *
 }
 
 static void *proc_keys_start(struct seq_file *p, loff_t *_pos)
+__acquires(key_serial_lock)
 {
 	struct rb_node *_p;
 	loff_t pos = *_pos;
@@ -126,6 +127,7 @@ static void *proc_keys_next(struct seq_f
 }
 
 static void proc_keys_stop(struct seq_file *p, void *v)
+__releases(key_serial_lock)
 {
 	spin_unlock(&key_serial_lock);
 }
@@ -214,6 +216,7 @@ static int proc_key_users_open(struct in
 }
 
 static void *proc_key_users_start(struct seq_file *p, loff_t *_pos)
+__acquires(key_user_lock)
 {
 	struct rb_node *_p;
 	loff_t pos = *_pos;
@@ -238,6 +241,7 @@ static void *proc_key_users_next(struct
 }
 
 static void proc_key_users_stop(struct seq_file *p, void *v)
+__releases(key_user_lock)
 {
 	spin_unlock(&key_user_lock);
 }
