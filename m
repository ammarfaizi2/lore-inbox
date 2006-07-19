Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWGSBDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWGSBDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWGSBDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:03:51 -0400
Received: from student.uhasselt.be ([193.190.2.1]:60676 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S932429AbWGSBDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:03:47 -0400
Date: Wed, 19 Jul 2006 03:03:43 +0200
To: linux-kernel@vger.kernel.org
Cc: acme@conectiva.com.br, patrick@tykepenguin.com, davem@davemloft.net,
       per.liden@ericsson.com, mitch@sfgoth.com, samuel@sortiz.org,
       eis@baty.hanse.de, ralf@linux-mips.org, netdev@vger.kernel.org
Subject: [PATCH] net: Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060719010343.GC30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

net: Conversions from kmalloc+memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
Applies to current GIT or 2.6.18-rc2. Compile-tested with 
make allyesconfig.

 net/8021q/vlan.c                            |    3 +--
 net/appletalk/ddp.c                         |    6 ++----
 net/atm/br2684.c                            |    3 +--
 net/atm/clip.c                              |    3 +--
 net/atm/lec.c                               |    3 +--
 net/atm/mpc.c                               |    3 +--
 net/atm/pppoatm.c                           |    3 +--
 net/atm/resources.c                         |    3 +--
 net/ax25/sysctl_net_ax25.c                  |    4 +---
 net/bridge/br_ioctl.c                       |    7 ++-----
 net/decnet/dn_dev.c                         |    9 ++-------
 net/decnet/dn_fib.c                         |    3 +--
 net/decnet/dn_neigh.c                       |    3 +--
 net/decnet/dn_rules.c                       |    3 +--
 net/decnet/dn_table.c                       |   11 +++--------
 net/econet/af_econet.c                      |    3 +--
 net/ieee80211/ieee80211_crypt.c             |    3 +--
 net/ieee80211/ieee80211_crypt_ccmp.c        |    3 +--
 net/ieee80211/ieee80211_crypt_wep.c         |    3 +--
 net/ieee80211/ieee80211_wx.c                |    7 ++-----
 net/ieee80211/softmac/ieee80211softmac_io.c |    3 +--
 net/ipv4/ah4.c                              |    4 +---
 net/ipv4/arp.c                              |    3 +--
 net/ipv4/devinet.c                          |    6 ++----
 net/ipv4/esp4.c                             |    4 +---
 net/ipv4/fib_hash.c                         |    6 ++----
 net/ipv4/fib_rules.c                        |    3 +--
 net/ipv4/fib_semantics.c                    |    3 +--
 net/ipv4/igmp.c                             |   12 ++++--------
 net/ipv4/inet_diag.c                        |    3 +--
 net/ipv4/ipcomp.c                           |    3 +--
 net/ipv4/ipvs/ip_vs_ctl.c                   |   10 +++-------
 net/ipv4/ipvs/ip_vs_est.c                   |    3 +--
 net/ipv4/netfilter/ipt_CLUSTERIP.c          |    3 +--
 net/ipv4/tcp_ipv4.c                         |    3 +--
 net/ipv4/udp.c                              |    3 +--
 net/ipv6/ip6_tunnel.c                       |    3 +--
 net/irda/ircomm/ircomm_core.c               |    4 +---
 net/irda/ircomm/ircomm_tty.c                |    3 +--
 net/irda/irda_device.c                      |    4 +---
 net/irda/irias_object.c                     |   24 ++++++++----------------
 net/irda/irlap.c                            |    6 ++----
 net/irda/irlap_frame.c                      |    3 +--
 net/irda/irlmp.c                            |    9 +++------
 net/irda/irnet/irnet_ppp.c                  |    3 +--
 net/irda/irttp.c                            |    9 +++------
 net/lapb/lapb_iface.c                       |    4 +---
 net/llc/llc_core.c                          |    3 +--
 net/netlink/af_netlink.c                    |   13 ++++---------
 net/rxrpc/connection.c                      |    6 ++----
 net/rxrpc/peer.c                            |    3 +--
 net/rxrpc/transport.c                       |    6 ++----
 net/sched/act_api.c                         |    9 +++------
 net/sched/act_pedit.c                       |    3 +--
 net/sched/act_police.c                      |    6 ++----
 net/sched/cls_basic.c                       |    6 ++----
 net/sched/cls_fw.c                          |    6 ++----
 net/sched/cls_route.c                       |    9 +++------
 net/sched/cls_rsvp.h                        |    9 +++------
 net/sched/cls_tcindex.c                     |   12 ++++--------
 net/sched/cls_u32.c                         |   15 +++++----------
 net/sched/em_meta.c                         |    3 +--
 net/sched/ematch.c                          |    3 +--
 net/sched/estimator.c                       |    3 +--
 net/sched/sch_cbq.c                         |    3 +--
 net/sched/sch_generic.c                     |    3 +--
 net/sched/sch_gred.c                        |    3 +--
 net/sched/sch_hfsc.c                        |    3 +--
 net/sched/sch_htb.c                         |    3 +--
 net/sunrpc/auth_gss/auth_gss.c              |    9 +++------
 net/sunrpc/auth_gss/gss_krb5_mech.c         |    3 +--
 net/sunrpc/auth_gss/gss_mech_switch.c       |    3 +--
 net/sunrpc/auth_gss/gss_spkm3_mech.c        |    3 +--
 net/sunrpc/auth_gss/gss_spkm3_token.c       |    3 +--
 net/sunrpc/clnt.c                           |    3 +--
 net/sunrpc/stats.c                          |    7 +------
 net/sunrpc/svc.c                            |    6 ++----
 net/sunrpc/svcsock.c                        |    3 +--
 net/sunrpc/xprt.c                           |    3 +--
 net/sunrpc/xprtsock.c                       |    6 ++----
 net/tipc/bearer.c                           |    6 ++----
 net/tipc/cluster.c                          |    8 ++------
 net/tipc/link.c                             |    3 +--
 net/tipc/name_table.c                       |   16 ++++------------
 net/tipc/net.c                              |    5 +----
 net/tipc/port.c                             |    5 ++---
 net/tipc/subscr.c                           |    3 +--
 net/tipc/user_reg.c                         |    3 +--
 net/tipc/zone.c                             |    3 +--
 net/unix/af_unix.c                          |    3 +--
 net/wanrouter/af_wanpipe.c                  |    9 +++------
 net/wanrouter/wanmain.c                     |    9 +++------
 net/xfrm/xfrm_policy.c                      |    3 +--
 net/xfrm/xfrm_state.c                       |    3 +--
 94 files changed, 154 insertions(+), 334 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 458031b..0ade0c6 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -542,12 +542,11 @@ #endif
 	 * so it cannot "appear" on us.
 	 */
 	if (!grp) { /* need to add a new group */
-		grp = kmalloc(sizeof(struct vlan_group), GFP_KERNEL);
+		grp = kzalloc(sizeof(struct vlan_group), GFP_KERNEL);
 		if (!grp)
 			goto out_free_unregister;
 					
 		/* printk(KERN_ALERT "VLAN REGISTER:  Allocated new group.\n"); */
-		memset(grp, 0, sizeof(struct vlan_group));
 		grp->real_dev_ifindex = real_dev->ifindex;
 
 		hlist_add_head_rcu(&grp->hlist, 
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 5ee96d4..96dc6bb 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -227,12 +227,11 @@ static void atif_drop_device(struct net_
 static struct atalk_iface *atif_add_device(struct net_device *dev,
 					   struct atalk_addr *sa)
 {
-	struct atalk_iface *iface = kmalloc(sizeof(*iface), GFP_KERNEL);
+	struct atalk_iface *iface = kzalloc(sizeof(*iface), GFP_KERNEL);
 
 	if (!iface)
 		goto out;
 
-	memset(iface, 0, sizeof(*iface));
 	dev_hold(dev);
 	iface->dev = dev;
 	dev->atalk_ptr = iface;
@@ -559,12 +558,11 @@ static int atrtr_create(struct rtentry *
 	}
 
 	if (!rt) {
-		rt = kmalloc(sizeof(*rt), GFP_ATOMIC);
+		rt = kzalloc(sizeof(*rt), GFP_ATOMIC);
 
 		retval = -ENOBUFS;
 		if (!rt)
 			goto out_unlock;
-		memset(rt, 0, sizeof(*rt));
 
 		rt->next = atalk_routes;
 		atalk_routes = rt;
diff --git a/net/atm/br2684.c b/net/atm/br2684.c
index a487233..d00cca9 100644
--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -508,10 +508,9 @@ Note: we do not have explicit unassign, 
 
 	if (copy_from_user(&be, arg, sizeof be))
 		return -EFAULT;
-	brvcc = kmalloc(sizeof(struct br2684_vcc), GFP_KERNEL);
+	brvcc = kzalloc(sizeof(struct br2684_vcc), GFP_KERNEL);
 	if (!brvcc)
 		return -ENOMEM;
-	memset(brvcc, 0, sizeof(struct br2684_vcc));
 	write_lock_irq(&devs_lock);
 	net_dev = br2684_find_dev(&be.ifspec);
 	if (net_dev == NULL) {
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 2e62105..7ce7bfe 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -929,12 +929,11 @@ static int arp_seq_open(struct inode *in
 	struct seq_file *seq;
 	int rc = -EAGAIN;
 
-	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (!state) {
 		rc = -ENOMEM;
 		goto out_kfree;
 	}
-	memset(state, 0, sizeof(*state));
 	state->ns.neigh_sub_iter = clip_seq_sub_iter;
 
 	rc = seq_open(file, &arp_seq_ops);
diff --git a/net/atm/lec.c b/net/atm/lec.c
index 4b68a18..b4aa489 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -1811,12 +1811,11 @@ make_entry(struct lec_priv *priv, unsign
 {
         struct lec_arp_table *to_return;
 
-        to_return = kmalloc(sizeof(struct lec_arp_table), GFP_ATOMIC);
+        to_return = kzalloc(sizeof(struct lec_arp_table), GFP_ATOMIC);
         if (!to_return) {
                 printk("LEC: Arp entry kmalloc failed\n");
                 return NULL;
         }
-        memset(to_return, 0, sizeof(struct lec_arp_table));
         memcpy(to_return->mac_addr, mac_addr, ETH_ALEN);
         init_timer(&to_return->timer);
         to_return->timer.function = lec_arp_expire_arp;
diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 9aafe1e..0070466 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -258,10 +258,9 @@ static struct mpoa_client *alloc_mpc(voi
 {
 	struct mpoa_client *mpc;
 
-	mpc = kmalloc(sizeof (struct mpoa_client), GFP_KERNEL);
+	mpc = kzalloc(sizeof (struct mpoa_client), GFP_KERNEL);
 	if (mpc == NULL)
 		return NULL;
-	memset(mpc, 0, sizeof(struct mpoa_client));
 	rwlock_init(&mpc->ingress_lock);
 	rwlock_init(&mpc->egress_lock);
 	mpc->next = mpcs;
diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index 76a7d8f..19d5dfc 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -287,10 +287,9 @@ static int pppoatm_assign_vcc(struct atm
 	if (be.encaps != PPPOATM_ENCAPS_AUTODETECT &&
 	    be.encaps != PPPOATM_ENCAPS_VC && be.encaps != PPPOATM_ENCAPS_LLC)
 		return -EINVAL;
-	pvcc = kmalloc(sizeof(*pvcc), GFP_KERNEL);
+	pvcc = kzalloc(sizeof(*pvcc), GFP_KERNEL);
 	if (pvcc == NULL)
 		return -ENOMEM;
-	memset(pvcc, 0, sizeof(*pvcc));
 	pvcc->atmvcc = atmvcc;
 	pvcc->old_push = atmvcc->push;
 	pvcc->old_pop = atmvcc->pop;
diff --git a/net/atm/resources.c b/net/atm/resources.c
index de25c64..529f7e6 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -33,10 +33,9 @@ static struct atm_dev *__alloc_atm_dev(c
 {
 	struct atm_dev *dev;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-	memset(dev, 0, sizeof(*dev));
 	dev->type = type;
 	dev->signal = ATM_PHY_SIG_UNKNOWN;
 	dev->link_rate = ATM_OC3_PCR;
diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index 369a75b..867d425 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -203,13 +203,11 @@ void ax25_register_sysctl(void)
 	for (ax25_table_size = sizeof(ctl_table), ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next)
 		ax25_table_size += sizeof(ctl_table);
 
-	if ((ax25_table = kmalloc(ax25_table_size, GFP_ATOMIC)) == NULL) {
+	if ((ax25_table = kzalloc(ax25_table_size, GFP_ATOMIC)) == NULL) {
 		spin_unlock_bh(&ax25_dev_lock);
 		return;
 	}
 
-	memset(ax25_table, 0x00, ax25_table_size);
-
 	for (n = 0, ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next) {
 		ctl_table *child = kmalloc(sizeof(ax25_param_table), GFP_ATOMIC);
 		if (!child) {
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 159fb84..4e4119a 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -162,12 +162,10 @@ static int old_dev_ioctl(struct net_devi
 		if (num > BR_MAX_PORTS)
 			num = BR_MAX_PORTS;
 
-		indices = kmalloc(num*sizeof(int), GFP_KERNEL);
+		indices = kcalloc(num, sizeof(int), GFP_KERNEL);
 		if (indices == NULL)
 			return -ENOMEM;
 
-		memset(indices, 0, num*sizeof(int));
-
 		get_port_ifindices(br, indices, num);
 		if (copy_to_user((void __user *)args[1], indices, num*sizeof(int)))
 			num =  -EFAULT;
@@ -327,11 +325,10 @@ static int old_deviceless(void __user *u
 
 		if (args[2] >= 2048)
 			return -ENOMEM;
-		indices = kmalloc(args[2]*sizeof(int), GFP_KERNEL);
+		indices = kcalloc(args[2], sizeof(int), GFP_KERNEL);
 		if (indices == NULL)
 			return -ENOMEM;
 
-		memset(indices, 0, args[2]*sizeof(int));
 		args[2] = get_bridge_ifindices(indices, args[2]);
 
 		ret = copy_to_user((void __user *)args[1], indices, args[2]*sizeof(int))
diff --git a/net/decnet/dn_dev.c b/net/decnet/dn_dev.c
index 98a2520..476455f 100644
--- a/net/decnet/dn_dev.c
+++ b/net/decnet/dn_dev.c
@@ -413,11 +413,7 @@ static struct dn_ifaddr *dn_dev_alloc_if
 {
 	struct dn_ifaddr *ifa;
 
-	ifa = kmalloc(sizeof(*ifa), GFP_KERNEL);
-
-	if (ifa) {
-		memset(ifa, 0, sizeof(*ifa));
-	}
+	ifa = kzalloc(sizeof(*ifa), GFP_KERNEL);
 
 	return ifa;
 }
@@ -1105,10 +1101,9 @@ struct dn_dev *dn_dev_create(struct net_
 		return NULL;
 
 	*err = -ENOBUFS;
-	if ((dn_db = kmalloc(sizeof(struct dn_dev), GFP_ATOMIC)) == NULL)
+	if ((dn_db = kzalloc(sizeof(struct dn_dev), GFP_ATOMIC)) == NULL)
 		return NULL;
 
-	memset(dn_db, 0, sizeof(struct dn_dev));
 	memcpy(&dn_db->parms, p, sizeof(struct dn_dev_parms));
 	smp_wmb();
 	dev->dn_ptr = dn_db;
diff --git a/net/decnet/dn_fib.c b/net/decnet/dn_fib.c
index 0375077..fa20e2e 100644
--- a/net/decnet/dn_fib.c
+++ b/net/decnet/dn_fib.c
@@ -283,11 +283,10 @@ struct dn_fib_info *dn_fib_create_info(c
 			goto err_inval;
 	}
 
-	fi = kmalloc(sizeof(*fi)+nhs*sizeof(struct dn_fib_nh), GFP_KERNEL);
+	fi = kzalloc(sizeof(*fi)+nhs*sizeof(struct dn_fib_nh), GFP_KERNEL);
 	err = -ENOBUFS;
 	if (fi == NULL)
 		goto failure;
-	memset(fi, 0, sizeof(*fi)+nhs*sizeof(struct dn_fib_nh));
 
 	fi->fib_protocol = r->rtm_protocol;
 	fi->fib_nhs = nhs;
diff --git a/net/decnet/dn_neigh.c b/net/decnet/dn_neigh.c
index 5ce9c9e..ff0ebe9 100644
--- a/net/decnet/dn_neigh.c
+++ b/net/decnet/dn_neigh.c
@@ -580,12 +580,11 @@ static int dn_neigh_seq_open(struct inod
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct neigh_seq_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct neigh_seq_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
 
-	memset(s, 0, sizeof(*s));
 	rc = seq_open(file, &dn_neigh_seq_ops);
 	if (rc)
 		goto out_kfree;
diff --git a/net/decnet/dn_rules.c b/net/decnet/dn_rules.c
index 22f321d..6986be7 100644
--- a/net/decnet/dn_rules.c
+++ b/net/decnet/dn_rules.c
@@ -151,10 +151,9 @@ int dn_fib_rtm_newrule(struct sk_buff *s
 		}
 	}
 
-	new_r = kmalloc(sizeof(*new_r), GFP_KERNEL);
+	new_r = kzalloc(sizeof(*new_r), GFP_KERNEL);
 	if (!new_r)
 		return -ENOMEM;
-	memset(new_r, 0, sizeof(*new_r));
 
 	if (rta[RTA_SRC-1])
 		memcpy(&new_r->r_src, RTA_DATA(rta[RTA_SRC-1]), 2);
diff --git a/net/decnet/dn_table.c b/net/decnet/dn_table.c
index 37d9d0a..e926c95 100644
--- a/net/decnet/dn_table.c
+++ b/net/decnet/dn_table.c
@@ -158,12 +158,10 @@ static void dn_rehash_zone(struct dn_zon
 			break;
 	}
 
-	ht = kmalloc(new_divisor*sizeof(struct dn_fib_node*), GFP_KERNEL);
-
+	ht = kcalloc(new_divisor, sizeof(struct dn_fib_node*), GFP_KERNEL);
 	if (ht == NULL)
 		return;
 
-	memset(ht, 0, new_divisor*sizeof(struct dn_fib_node *));
 	write_lock_bh(&dn_fib_tables_lock);
 	old_ht = dz->dz_hash;
 	dz->dz_hash = ht;
@@ -184,11 +182,10 @@ static void dn_free_node(struct dn_fib_n
 static struct dn_zone *dn_new_zone(struct dn_hash *table, int z)
 {
 	int i;
-	struct dn_zone *dz = kmalloc(sizeof(struct dn_zone), GFP_KERNEL);
+	struct dn_zone *dz = kzalloc(sizeof(struct dn_zone), GFP_KERNEL);
 	if (!dz)
 		return NULL;
 
-	memset(dz, 0, sizeof(struct dn_zone));
 	if (z) {
 		dz->dz_divisor = 16;
 		dz->dz_hashmask = 0x0F;
@@ -197,14 +194,12 @@ static struct dn_zone *dn_new_zone(struc
 		dz->dz_hashmask = 0;
 	}
 
-	dz->dz_hash = kmalloc(dz->dz_divisor*sizeof(struct dn_fib_node *), GFP_KERNEL);
-
+	dz->dz_hash = kcalloc(dz->dz_divisor, sizeof(struct dn_fib_node *), GFP_KERNEL);
 	if (!dz->dz_hash) {
 		kfree(dz);
 		return NULL;
 	}
 
-	memset(dz->dz_hash, 0, dz->dz_divisor*sizeof(struct dn_fib_node*));
 	dz->dz_order = z;
 	dz->dz_mask = dnet_make_mask(z);
 
diff --git a/net/econet/af_econet.c b/net/econet/af_econet.c
index 309ae4c..4d66aac 100644
--- a/net/econet/af_econet.c
+++ b/net/econet/af_econet.c
@@ -673,12 +673,11 @@ static int ec_dev_ioctl(struct socket *s
 		edev = dev->ec_ptr;
 		if (edev == NULL) {
 			/* Magic up a new one. */
-			edev = kmalloc(sizeof(struct ec_device), GFP_KERNEL);
+			edev = kzalloc(sizeof(struct ec_device), GFP_KERNEL);
 			if (edev == NULL) {
 				err = -ENOMEM;
 				break;
 			}
-			memset(edev, 0, sizeof(struct ec_device));
 			dev->ec_ptr = edev;
 		} else
 			net2dev_map[edev->net] = NULL;
diff --git a/net/ieee80211/ieee80211_crypt.c b/net/ieee80211/ieee80211_crypt.c
index cb71d79..5ed0a98 100644
--- a/net/ieee80211/ieee80211_crypt.c
+++ b/net/ieee80211/ieee80211_crypt.c
@@ -110,11 +110,10 @@ int ieee80211_register_crypto_ops(struct
 	unsigned long flags;
 	struct ieee80211_crypto_alg *alg;
 
-	alg = kmalloc(sizeof(*alg), GFP_KERNEL);
+	alg = kzalloc(sizeof(*alg), GFP_KERNEL);
 	if (alg == NULL)
 		return -ENOMEM;
 
-	memset(alg, 0, sizeof(*alg));
 	alg->ops = ops;
 
 	spin_lock_irqsave(&ieee80211_crypto_lock, flags);
diff --git a/net/ieee80211/ieee80211_crypt_ccmp.c b/net/ieee80211/ieee80211_crypt_ccmp.c
index 4926473..ed90a8a 100644
--- a/net/ieee80211/ieee80211_crypt_ccmp.c
+++ b/net/ieee80211/ieee80211_crypt_ccmp.c
@@ -76,10 +76,9 @@ static void *ieee80211_ccmp_init(int key
 {
 	struct ieee80211_ccmp_data *priv;
 
-	priv = kmalloc(sizeof(*priv), GFP_ATOMIC);
+	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
 	if (priv == NULL)
 		goto fail;
-	memset(priv, 0, sizeof(*priv));
 	priv->key_idx = key_idx;
 
 	priv->tfm = crypto_alloc_tfm("aes", 0);
diff --git a/net/ieee80211/ieee80211_crypt_wep.c b/net/ieee80211/ieee80211_crypt_wep.c
index c5a8772..0ebf235 100644
--- a/net/ieee80211/ieee80211_crypt_wep.c
+++ b/net/ieee80211/ieee80211_crypt_wep.c
@@ -39,10 +39,9 @@ static void *prism2_wep_init(int keyidx)
 {
 	struct prism2_wep_data *priv;
 
-	priv = kmalloc(sizeof(*priv), GFP_ATOMIC);
+	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
 	if (priv == NULL)
 		goto fail;
-	memset(priv, 0, sizeof(*priv));
 	priv->key_idx = keyidx;
 
 	priv->tfm = crypto_alloc_tfm("arc4", 0);
diff --git a/net/ieee80211/ieee80211_wx.c b/net/ieee80211/ieee80211_wx.c
index a78c4f8..5cb9cfd 100644
--- a/net/ieee80211/ieee80211_wx.c
+++ b/net/ieee80211/ieee80211_wx.c
@@ -369,11 +369,10 @@ int ieee80211_wx_set_encode(struct ieee8
 		struct ieee80211_crypt_data *new_crypt;
 
 		/* take WEP into use */
-		new_crypt = kmalloc(sizeof(struct ieee80211_crypt_data),
+		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data),
 				    GFP_KERNEL);
 		if (new_crypt == NULL)
 			return -ENOMEM;
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ieee80211_get_crypto_ops("WEP");
 		if (!new_crypt->ops) {
 			request_module("ieee80211_crypt_wep");
@@ -616,13 +615,11 @@ int ieee80211_wx_set_encodeext(struct ie
 
 		ieee80211_crypt_delayed_deinit(ieee, crypt);
 
-		new_crypt = (struct ieee80211_crypt_data *)
-		    kmalloc(sizeof(*new_crypt), GFP_KERNEL);
+		new_crypt = kzalloc(sizeof(*new_crypt), GFP_KERNEL);
 		if (new_crypt == NULL) {
 			ret = -ENOMEM;
 			goto done;
 		}
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ops;
 		if (new_crypt->ops && try_module_get(new_crypt->ops->owner))
 			new_crypt->priv = new_crypt->ops->init(idx);
diff --git a/net/ieee80211/softmac/ieee80211softmac_io.c b/net/ieee80211/softmac/ieee80211softmac_io.c
index 8cc8b20..6ae5a1d 100644
--- a/net/ieee80211/softmac/ieee80211softmac_io.c
+++ b/net/ieee80211/softmac/ieee80211softmac_io.c
@@ -96,8 +96,7 @@ ieee80211softmac_alloc_mgt(u32 size)
 	if(size > IEEE80211_DATA_LEN)
 		return NULL;
 	/* Allocate the frame */
-	data = kmalloc(size, GFP_ATOMIC);
-	memset(data, 0, size);
+	data = kzalloc(size, GFP_ATOMIC);
 	return data;
 }
 
diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 8e748be..1366bc6 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -215,12 +215,10 @@ static int ah_init_state(struct xfrm_sta
 	if (x->encap)
 		goto error;
 
-	ahp = kmalloc(sizeof(*ahp), GFP_KERNEL);
+	ahp = kzalloc(sizeof(*ahp), GFP_KERNEL);
 	if (ahp == NULL)
 		return -ENOMEM;
 
-	memset(ahp, 0, sizeof(*ahp));
-
 	ahp->key = x->aalg->alg_key;
 	ahp->key_len = (x->aalg->alg_key_len+7)/8;
 	ahp->tfm = crypto_alloc_tfm(x->aalg->alg_name, 0);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 7b51b3b..c8a3723 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1372,12 +1372,11 @@ static int arp_seq_open(struct inode *in
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct neigh_seq_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct neigh_seq_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
        
 	if (!s)
 		goto out;
 
-	memset(s, 0, sizeof(*s));
 	rc = seq_open(file, &arp_seq_ops);
 	if (rc)
 		goto out_kfree;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a7c65e9..a6cc31d 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -93,10 +93,9 @@ #endif
 
 static struct in_ifaddr *inet_alloc_ifa(void)
 {
-	struct in_ifaddr *ifa = kmalloc(sizeof(*ifa), GFP_KERNEL);
+	struct in_ifaddr *ifa = kzalloc(sizeof(*ifa), GFP_KERNEL);
 
 	if (ifa) {
-		memset(ifa, 0, sizeof(*ifa));
 		INIT_RCU_HEAD(&ifa->rcu_head);
 	}
 
@@ -140,10 +139,9 @@ struct in_device *inetdev_init(struct ne
 
 	ASSERT_RTNL();
 
-	in_dev = kmalloc(sizeof(*in_dev), GFP_KERNEL);
+	in_dev = kzalloc(sizeof(*in_dev), GFP_KERNEL);
 	if (!in_dev)
 		goto out;
-	memset(in_dev, 0, sizeof(*in_dev));
 	INIT_RCU_HEAD(&in_dev->rcu_head);
 	memcpy(&in_dev->cnf, &ipv4_devconf_dflt, sizeof(in_dev->cnf));
 	in_dev->cnf.sysctl = NULL;
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4e11273..fc2f8ce 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -316,12 +316,10 @@ static int esp_init_state(struct xfrm_st
 	if (x->ealg == NULL)
 		goto error;
 
-	esp = kmalloc(sizeof(*esp), GFP_KERNEL);
+	esp = kzalloc(sizeof(*esp), GFP_KERNEL);
 	if (esp == NULL)
 		return -ENOMEM;
 
-	memset(esp, 0, sizeof(*esp));
-
 	if (x->aalg) {
 		struct xfrm_algo_desc *aalg_desc;
 
diff --git a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
index 3c1d32a..72c633b 100644
--- a/net/ipv4/fib_hash.c
+++ b/net/ipv4/fib_hash.c
@@ -204,11 +204,10 @@ static struct fn_zone *
 fn_new_zone(struct fn_hash *table, int z)
 {
 	int i;
-	struct fn_zone *fz = kmalloc(sizeof(struct fn_zone), GFP_KERNEL);
+	struct fn_zone *fz = kzalloc(sizeof(struct fn_zone), GFP_KERNEL);
 	if (!fz)
 		return NULL;
 
-	memset(fz, 0, sizeof(struct fn_zone));
 	if (z) {
 		fz->fz_divisor = 16;
 	} else {
@@ -1046,7 +1045,7 @@ static int fib_seq_open(struct inode *in
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct fib_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct fib_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
        
 	if (!s)
 		goto out;
@@ -1057,7 +1056,6 @@ static int fib_seq_open(struct inode *in
 
 	seq	     = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 773b12b..79b0471 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -196,10 +196,9 @@ int inet_rtm_newrule(struct sk_buff *skb
 		}
 	}
 
-	new_r = kmalloc(sizeof(*new_r), GFP_KERNEL);
+	new_r = kzalloc(sizeof(*new_r), GFP_KERNEL);
 	if (!new_r)
 		return -ENOMEM;
-	memset(new_r, 0, sizeof(*new_r));
 
 	if (rta[RTA_SRC-1])
 		memcpy(&new_r->r_src, RTA_DATA(rta[RTA_SRC-1]), 4);
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 5f87533..63864bb 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -709,11 +709,10 @@ #endif
 			goto failure;
 	}
 
-	fi = kmalloc(sizeof(*fi)+nhs*sizeof(struct fib_nh), GFP_KERNEL);
+	fi = kzalloc(sizeof(*fi)+nhs*sizeof(struct fib_nh), GFP_KERNEL);
 	if (fi == NULL)
 		goto failure;
 	fib_info_cnt++;
-	memset(fi, 0, sizeof(*fi)+nhs*sizeof(struct fib_nh));
 
 	fi->fib_protocol = r->rtm_protocol;
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index d299c8e..9f4b752 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1028,10 +1028,9 @@ static void igmpv3_add_delrec(struct in_
 	 * for deleted items allows change reports to use common code with
 	 * non-deleted or query-response MCA's.
 	 */
-	pmc = kmalloc(sizeof(*pmc), GFP_KERNEL);
+	pmc = kzalloc(sizeof(*pmc), GFP_KERNEL);
 	if (!pmc)
 		return;
-	memset(pmc, 0, sizeof(*pmc));
 	spin_lock_bh(&im->lock);
 	pmc->interface = im->interface;
 	in_dev_hold(in_dev);
@@ -1529,10 +1528,9 @@ static int ip_mc_add1_src(struct ip_mc_l
 		psf_prev = psf;
 	}
 	if (!psf) {
-		psf = kmalloc(sizeof(*psf), GFP_ATOMIC);
+		psf = kzalloc(sizeof(*psf), GFP_ATOMIC);
 		if (!psf)
 			return -ENOBUFS;
-		memset(psf, 0, sizeof(*psf));
 		psf->sf_inaddr = *psfsrc;
 		if (psf_prev) {
 			psf_prev->sf_next = psf;
@@ -2380,7 +2378,7 @@ static int igmp_mc_seq_open(struct inode
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct igmp_mc_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct igmp_mc_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
@@ -2390,7 +2388,6 @@ static int igmp_mc_seq_open(struct inode
 
 	seq = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
@@ -2555,7 +2552,7 @@ static int igmp_mcf_seq_open(struct inod
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct igmp_mcf_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct igmp_mcf_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
@@ -2565,7 +2562,6 @@ static int igmp_mcf_seq_open(struct inod
 
 	seq = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 8e7e41b..492858e 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -909,11 +909,10 @@ static int __init inet_diag_init(void)
 					  sizeof(struct inet_diag_handler *));
 	int err = -ENOMEM;
 
-	inet_diag_table = kmalloc(inet_diag_table_size, GFP_KERNEL);
+	inet_diag_table = kzalloc(inet_diag_table_size, GFP_KERNEL);
 	if (!inet_diag_table)
 		goto out;
 
-	memset(inet_diag_table, 0, inet_diag_table_size);
 	idiagnl = netlink_kernel_create(NETLINK_INET_DIAG, 0, inet_diag_rcv,
 					THIS_MODULE);
 	if (idiagnl == NULL)
diff --git a/net/ipv4/ipcomp.c b/net/ipv4/ipcomp.c
index 8a8b5cf..a0c28b2 100644
--- a/net/ipv4/ipcomp.c
+++ b/net/ipv4/ipcomp.c
@@ -410,11 +410,10 @@ static int ipcomp_init_state(struct xfrm
 		goto out;
 
 	err = -ENOMEM;
-	ipcd = kmalloc(sizeof(*ipcd), GFP_KERNEL);
+	ipcd = kzalloc(sizeof(*ipcd), GFP_KERNEL);
 	if (!ipcd)
 		goto out;
 
-	memset(ipcd, 0, sizeof(*ipcd));
 	x->props.header_len = 0;
 	if (x->props.mode)
 		x->props.header_len += sizeof(struct iphdr);
diff --git a/net/ipv4/ipvs/ip_vs_ctl.c b/net/ipv4/ipvs/ip_vs_ctl.c
index f28ec68..6a28faf 100644
--- a/net/ipv4/ipvs/ip_vs_ctl.c
+++ b/net/ipv4/ipvs/ip_vs_ctl.c
@@ -735,12 +735,11 @@ ip_vs_new_dest(struct ip_vs_service *svc
 	if (atype != RTN_LOCAL && atype != RTN_UNICAST)
 		return -EINVAL;
 
-	dest = kmalloc(sizeof(struct ip_vs_dest), GFP_ATOMIC);
+	dest = kzalloc(sizeof(struct ip_vs_dest), GFP_ATOMIC);
 	if (dest == NULL) {
 		IP_VS_ERR("ip_vs_new_dest: kmalloc failed.\n");
 		return -ENOMEM;
 	}
-	memset(dest, 0, sizeof(struct ip_vs_dest));
 
 	dest->protocol = svc->protocol;
 	dest->vaddr = svc->addr;
@@ -1050,14 +1049,12 @@ ip_vs_add_service(struct ip_vs_service_u
 		goto out_mod_dec;
 	}
 
-	svc = (struct ip_vs_service *)
-		kmalloc(sizeof(struct ip_vs_service), GFP_ATOMIC);
+	svc = kzalloc(sizeof(struct ip_vs_service), GFP_ATOMIC);
 	if (svc == NULL) {
 		IP_VS_DBG(1, "ip_vs_add_service: kmalloc failed.\n");
 		ret = -ENOMEM;
 		goto out_err;
 	}
-	memset(svc, 0, sizeof(struct ip_vs_service));
 
 	/* I'm the first user of the service */
 	atomic_set(&svc->usecnt, 1);
@@ -1797,7 +1794,7 @@ static int ip_vs_info_open(struct inode 
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct ip_vs_iter *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct ip_vs_iter *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
@@ -1808,7 +1805,6 @@ static int ip_vs_info_open(struct inode 
 
 	seq	     = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/ipv4/ipvs/ip_vs_est.c b/net/ipv4/ipvs/ip_vs_est.c
index 4c19403..7d68b80 100644
--- a/net/ipv4/ipvs/ip_vs_est.c
+++ b/net/ipv4/ipvs/ip_vs_est.c
@@ -123,11 +123,10 @@ int ip_vs_new_estimator(struct ip_vs_sta
 {
 	struct ip_vs_estimator *est;
 
-	est = kmalloc(sizeof(*est), GFP_KERNEL);
+	est = kzalloc(sizeof(*est), GFP_KERNEL);
 	if (est == NULL)
 		return -ENOMEM;
 
-	memset(est, 0, sizeof(*est));
 	est->stats = stats;
 	est->last_conns = stats->conns;
 	est->cps = stats->cps<<10;
diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index cbffeae..d994c5f 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -172,11 +172,10 @@ clusterip_config_init(struct ipt_cluster
 	struct clusterip_config *c;
 	char buffer[16];
 
-	c = kmalloc(sizeof(*c), GFP_ATOMIC);
+	c = kzalloc(sizeof(*c), GFP_ATOMIC);
 	if (!c)
 		return NULL;
 
-	memset(c, 0, sizeof(*c));
 	c->dev = dev;
 	c->clusterip = ip;
 	memcpy(&c->clustermac, &i->clustermac, ETH_ALEN);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a891133..f6f39e8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1640,10 +1640,9 @@ static int tcp_seq_open(struct inode *in
 	if (unlikely(afinfo == NULL))
 		return -EINVAL;
 
-	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
-	memset(s, 0, sizeof(*s));
 	s->family		= afinfo->family;
 	s->seq_ops.start	= tcp_seq_start;
 	s->seq_ops.next		= tcp_seq_next;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9bfcdda..f136cec 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1468,11 +1468,10 @@ static int udp_seq_open(struct inode *in
 	struct udp_seq_afinfo *afinfo = PDE(inode)->data;
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct udp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct udp_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
-	memset(s, 0, sizeof(*s));
 	s->family		= afinfo->family;
 	s->seq_ops.start	= udp_seq_start;
 	s->seq_ops.next		= udp_seq_next;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bc77c0e..84d7ebd 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -567,10 +567,9 @@ static inline struct ipv6_txoptions *cre
 
 	int opt_len = sizeof(*opt) + 8;
 
-	if (!(opt = kmalloc(opt_len, GFP_ATOMIC))) {
+	if (!(opt = kzalloc(opt_len, GFP_ATOMIC))) {
 		return NULL;
 	}
-	memset(opt, 0, opt_len);
 	opt->tot_len = opt_len;
 	opt->dst0opt = (struct ipv6_opt_hdr *) (opt + 1);
 	opt->opt_nflen = 8;
diff --git a/net/irda/ircomm/ircomm_core.c b/net/irda/ircomm/ircomm_core.c
index 9c4a902..ad6b6af 100644
--- a/net/irda/ircomm/ircomm_core.c
+++ b/net/irda/ircomm/ircomm_core.c
@@ -115,12 +115,10 @@ struct ircomm_cb *ircomm_open(notify_t *
 
 	IRDA_ASSERT(ircomm != NULL, return NULL;);
 
-	self = kmalloc(sizeof(struct ircomm_cb), GFP_ATOMIC);
+	self = kzalloc(sizeof(struct ircomm_cb), GFP_ATOMIC);
 	if (self == NULL)
 		return NULL;
 
-	memset(self, 0, sizeof(struct ircomm_cb));
-
 	self->notify = *notify;
 	self->magic = IRCOMM_MAGIC;
 
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index b400f27..bbe37f3 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -379,12 +379,11 @@ static int ircomm_tty_open(struct tty_st
 	self = hashbin_lock_find(ircomm_tty, line, NULL);
 	if (!self) {
 		/* No, so make new instance */
-		self = kmalloc(sizeof(struct ircomm_tty_cb), GFP_KERNEL);
+		self = kzalloc(sizeof(struct ircomm_tty_cb), GFP_KERNEL);
 		if (self == NULL) {
 			IRDA_ERROR("%s(), kmalloc failed!\n", __FUNCTION__);
 			return -ENOMEM;
 		}
-		memset(self, 0, sizeof(struct ircomm_tty_cb));
 		
 		self->magic = IRCOMM_TTY_MAGIC;
 		self->flow = FLOW_STOP;
diff --git a/net/irda/irda_device.c b/net/irda/irda_device.c
index ba40e54..7e7a317 100644
--- a/net/irda/irda_device.c
+++ b/net/irda/irda_device.c
@@ -401,12 +401,10 @@ #endif
 	}
 
 	/* Allocate dongle info for this instance */
-	dongle = kmalloc(sizeof(dongle_t), GFP_KERNEL);
+	dongle = kzalloc(sizeof(dongle_t), GFP_KERNEL);
 	if (!dongle)
 		goto out;
 
-	memset(dongle, 0, sizeof(dongle_t));
-
 	/* Bind the registration info to this particular instance */
 	dongle->issue = reg;
 	dongle->dev = dev;
diff --git a/net/irda/irias_object.c b/net/irda/irias_object.c
index 82e665c..a154b1d 100644
--- a/net/irda/irias_object.c
+++ b/net/irda/irias_object.c
@@ -82,13 +82,12 @@ struct ias_object *irias_new_object( cha
 
 	IRDA_DEBUG( 4, "%s()\n", __FUNCTION__);
 
-	obj = kmalloc(sizeof(struct ias_object), GFP_ATOMIC);
+	obj = kzalloc(sizeof(struct ias_object), GFP_ATOMIC);
 	if (obj == NULL) {
 		IRDA_WARNING("%s(), Unable to allocate object!\n",
 			     __FUNCTION__);
 		return NULL;
 	}
-	memset(obj, 0, sizeof( struct ias_object));
 
 	obj->magic = IAS_OBJECT_MAGIC;
 	obj->name = strndup(name, IAS_MAX_CLASSNAME);
@@ -346,13 +345,12 @@ void irias_add_integer_attrib(struct ias
 	IRDA_ASSERT(obj->magic == IAS_OBJECT_MAGIC, return;);
 	IRDA_ASSERT(name != NULL, return;);
 
-	attrib = kmalloc(sizeof(struct ias_attrib), GFP_ATOMIC);
+	attrib = kzalloc(sizeof(struct ias_attrib), GFP_ATOMIC);
 	if (attrib == NULL) {
 		IRDA_WARNING("%s: Unable to allocate attribute!\n",
 			     __FUNCTION__);
 		return;
 	}
-	memset(attrib, 0, sizeof( struct ias_attrib));
 
 	attrib->magic = IAS_ATTRIB_MAGIC;
 	attrib->name = strndup(name, IAS_MAX_ATTRIBNAME);
@@ -382,13 +380,12 @@ void irias_add_octseq_attrib(struct ias_
 	IRDA_ASSERT(name != NULL, return;);
 	IRDA_ASSERT(octets != NULL, return;);
 
-	attrib = kmalloc(sizeof(struct ias_attrib), GFP_ATOMIC);
+	attrib = kzalloc(sizeof(struct ias_attrib), GFP_ATOMIC);
 	if (attrib == NULL) {
 		IRDA_WARNING("%s: Unable to allocate attribute!\n",
 			     __FUNCTION__);
 		return;
 	}
-	memset(attrib, 0, sizeof( struct ias_attrib));
 
 	attrib->magic = IAS_ATTRIB_MAGIC;
 	attrib->name = strndup(name, IAS_MAX_ATTRIBNAME);
@@ -416,13 +413,12 @@ void irias_add_string_attrib(struct ias_
 	IRDA_ASSERT(name != NULL, return;);
 	IRDA_ASSERT(value != NULL, return;);
 
-	attrib = kmalloc(sizeof( struct ias_attrib), GFP_ATOMIC);
+	attrib = kzalloc(sizeof( struct ias_attrib), GFP_ATOMIC);
 	if (attrib == NULL) {
 		IRDA_WARNING("%s: Unable to allocate attribute!\n",
 			     __FUNCTION__);
 		return;
 	}
-	memset(attrib, 0, sizeof( struct ias_attrib));
 
 	attrib->magic = IAS_ATTRIB_MAGIC;
 	attrib->name = strndup(name, IAS_MAX_ATTRIBNAME);
@@ -443,12 +439,11 @@ struct ias_value *irias_new_integer_valu
 {
 	struct ias_value *value;
 
-	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
+	value = kzalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
 		IRDA_WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
-	memset(value, 0, sizeof(struct ias_value));
 
 	value->type = IAS_INTEGER;
 	value->len = 4;
@@ -469,12 +464,11 @@ struct ias_value *irias_new_string_value
 {
 	struct ias_value *value;
 
-	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
+	value = kzalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
 		IRDA_WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
-	memset( value, 0, sizeof( struct ias_value));
 
 	value->type = IAS_STRING;
 	value->charset = CS_ASCII;
@@ -495,12 +489,11 @@ struct ias_value *irias_new_octseq_value
 {
 	struct ias_value *value;
 
-	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
+	value = kzalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
 		IRDA_WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
-	memset(value, 0, sizeof(struct ias_value));
 
 	value->type = IAS_OCT_SEQ;
 	/* Check length */
@@ -522,12 +515,11 @@ struct ias_value *irias_new_missing_valu
 {
 	struct ias_value *value;
 
-	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
+	value = kzalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
 		IRDA_WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
-	memset(value, 0, sizeof(struct ias_value));
 
 	value->type = IAS_MISSING;
 	value->len = 0;
diff --git a/net/irda/irlap.c b/net/irda/irlap.c
index cade355..aab20f4 100644
--- a/net/irda/irlap.c
+++ b/net/irda/irlap.c
@@ -116,11 +116,10 @@ struct irlap_cb *irlap_open(struct net_d
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/* Initialize the irlap structure. */
-	self = kmalloc(sizeof(struct irlap_cb), GFP_KERNEL);
+	self = kzalloc(sizeof(struct irlap_cb), GFP_KERNEL);
 	if (self == NULL)
 		return NULL;
 
-	memset(self, 0, sizeof(struct irlap_cb));
 	self->magic = LAP_MAGIC;
 
 	/* Make a binding between the layers */
@@ -1222,7 +1221,7 @@ static int irlap_seq_open(struct inode *
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct irlap_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct irlap_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
        
 	if (!s)
 		goto out;
@@ -1238,7 +1237,6 @@ static int irlap_seq_open(struct inode *
 
 	seq	     = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/irda/irlap_frame.c b/net/irda/irlap_frame.c
index 3e9a06a..b406945 100644
--- a/net/irda/irlap_frame.c
+++ b/net/irda/irlap_frame.c
@@ -422,11 +422,10 @@ static void irlap_recv_discovery_xid_rsp
 		return;
 	}
 
-	if ((discovery = kmalloc(sizeof(discovery_t), GFP_ATOMIC)) == NULL) {
+	if ((discovery = kzalloc(sizeof(discovery_t), GFP_ATOMIC)) == NULL) {
 		IRDA_WARNING("%s: kmalloc failed!\n", __FUNCTION__);
 		return;
 	}
-	memset(discovery, 0, sizeof(discovery_t));
 
 	discovery->data.daddr = info->daddr;
 	discovery->data.saddr = self->saddr;
diff --git a/net/irda/irlmp.c b/net/irda/irlmp.c
index 129ad64..03ea94a 100644
--- a/net/irda/irlmp.c
+++ b/net/irda/irlmp.c
@@ -78,10 +78,9 @@ int __init irlmp_init(void)
 {
 	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 	/* Initialize the irlmp structure. */
-	irlmp = kmalloc( sizeof(struct irlmp_cb), GFP_KERNEL);
+	irlmp = kzalloc( sizeof(struct irlmp_cb), GFP_KERNEL);
 	if (irlmp == NULL)
 		return -ENOMEM;
-	memset(irlmp, 0, sizeof(struct irlmp_cb));
 
 	irlmp->magic = LMP_MAGIC;
 
@@ -160,12 +159,11 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 		return NULL;
 
 	/* Allocate new instance of a LSAP connection */
-	self = kmalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
+	self = kzalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
 	if (self == NULL) {
 		IRDA_ERROR("%s: can't allocate memory\n", __FUNCTION__);
 		return NULL;
 	}
-	memset(self, 0, sizeof(struct lsap_cb));
 
 	self->magic = LMP_LSAP_MAGIC;
 	self->slsap_sel = slsap_sel;
@@ -288,12 +286,11 @@ void irlmp_register_link(struct irlap_cb
 	/*
 	 *  Allocate new instance of a LSAP connection
 	 */
-	lap = kmalloc(sizeof(struct lap_cb), GFP_KERNEL);
+	lap = kzalloc(sizeof(struct lap_cb), GFP_KERNEL);
 	if (lap == NULL) {
 		IRDA_ERROR("%s: unable to kmalloc\n", __FUNCTION__);
 		return;
 	}
-	memset(lap, 0, sizeof(struct lap_cb));
 
 	lap->irlap = irlap;
 	lap->magic = LMP_LAP_MAGIC;
diff --git a/net/irda/irnet/irnet_ppp.c b/net/irda/irnet/irnet_ppp.c
index e53bf9e..a1e502f 100644
--- a/net/irda/irnet/irnet_ppp.c
+++ b/net/irda/irnet/irnet_ppp.c
@@ -476,11 +476,10 @@ #ifdef SECURE_DEVIRNET
 #endif /* SECURE_DEVIRNET */
 
   /* Allocate a private structure for this IrNET instance */
-  ap = kmalloc(sizeof(*ap), GFP_KERNEL);
+  ap = kzalloc(sizeof(*ap), GFP_KERNEL);
   DABORT(ap == NULL, -ENOMEM, FS_ERROR, "Can't allocate struct irnet...\n");
 
   /* initialize the irnet structure */
-  memset(ap, 0, sizeof(*ap));
   ap->file = file;
 
   /* PPP channel setup */
diff --git a/net/irda/irttp.c b/net/irda/irttp.c
index 49c51c5..1d8a8d1 100644
--- a/net/irda/irttp.c
+++ b/net/irda/irttp.c
@@ -85,10 +85,9 @@ static pi_param_info_t param_info = { pi
  */
 int __init irttp_init(void)
 {
-	irttp = kmalloc(sizeof(struct irttp_cb), GFP_KERNEL);
+	irttp = kzalloc(sizeof(struct irttp_cb), GFP_KERNEL);
 	if (irttp == NULL)
 		return -ENOMEM;
-	memset(irttp, 0, sizeof(struct irttp_cb));
 
 	irttp->magic = TTP_MAGIC;
 
@@ -389,12 +388,11 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 		return NULL;
 	}
 
-	self = kmalloc(sizeof(struct tsap_cb), GFP_ATOMIC);
+	self = kzalloc(sizeof(struct tsap_cb), GFP_ATOMIC);
 	if (self == NULL) {
 		IRDA_DEBUG(0, "%s(), unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
-	memset(self, 0, sizeof(struct tsap_cb));
 	spin_lock_init(&self->lock);
 
 	/* Initialise todo timer */
@@ -1876,7 +1874,7 @@ static int irttp_seq_open(struct inode *
 	int rc = -ENOMEM;
 	struct irttp_iter_state *s;
 
-	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
 		goto out;
 
@@ -1886,7 +1884,6 @@ static int irttp_seq_open(struct inode *
 
 	seq	     = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index aea6616..d504eed 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -115,14 +115,12 @@ static struct lapb_cb *lapb_devtostruct(
  */
 static struct lapb_cb *lapb_create_cb(void)
 {
-	struct lapb_cb *lapb = kmalloc(sizeof(*lapb), GFP_ATOMIC);
+	struct lapb_cb *lapb = kzalloc(sizeof(*lapb), GFP_ATOMIC);
 
 
 	if (!lapb)
 		goto out;
 
-	memset(lapb, 0x00, sizeof(*lapb));
-
 	skb_queue_head_init(&lapb->write_queue);
 	skb_queue_head_init(&lapb->ack_queue);
 
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index bd242a4..d12413c 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -33,10 +33,9 @@ unsigned char llc_station_mac_sa[ETH_ALE
  */
 static struct llc_sap *llc_sap_alloc(void)
 {
-	struct llc_sap *sap = kmalloc(sizeof(*sap), GFP_ATOMIC);
+	struct llc_sap *sap = kzalloc(sizeof(*sap), GFP_ATOMIC);
 
 	if (sap) {
-		memset(sap, 0, sizeof(*sap));
 		sap->state = LLC_SAP_STATE_ACTIVE;
 		memcpy(sap->laddr.mac, llc_station_mac_sa, ETH_ALEN);
 		rwlock_init(&sap->sk_list.lock);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 55c0adc..b85c1f9 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -562,10 +562,9 @@ static int netlink_alloc_groups(struct s
 	if (err)
 		return err;
 
-	nlk->groups = kmalloc(NLGRPSZ(groups), GFP_KERNEL);
+	nlk->groups = kzalloc(NLGRPSZ(groups), GFP_KERNEL);
 	if (nlk->groups == NULL)
 		return -ENOMEM;
-	memset(nlk->groups, 0, NLGRPSZ(groups));
 	nlk->ngroups = groups;
 	return 0;
 }
@@ -1393,11 +1392,10 @@ int netlink_dump_start(struct sock *ssk,
 	struct sock *sk;
 	struct netlink_sock *nlk;
 
-	cb = kmalloc(sizeof(*cb), GFP_KERNEL);
+	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
 	if (cb == NULL)
 		return -ENOBUFS;
 
-	memset(cb, 0, sizeof(*cb));
 	cb->dump = dump;
 	cb->done = done;
 	cb->nlh = nlh;
@@ -1668,7 +1666,7 @@ static int netlink_seq_open(struct inode
 	struct nl_seq_iter *iter;
 	int err;
 
-	iter = kmalloc(sizeof(*iter), GFP_KERNEL);
+	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
 	if (!iter)
 		return -ENOMEM;
 
@@ -1678,7 +1676,6 @@ static int netlink_seq_open(struct inode
 		return err;
 	}
 
-	memset(iter, 0, sizeof(*iter));
 	seq = file->private_data;
 	seq->private = iter;
 	return 0;
@@ -1747,15 +1744,13 @@ static int __init netlink_proto_init(voi
 	if (sizeof(struct netlink_skb_parms) > sizeof(dummy_skb->cb))
 		netlink_skb_parms_too_large();
 
-	nl_table = kmalloc(sizeof(*nl_table) * MAX_LINKS, GFP_KERNEL);
+	nl_table = kcalloc(MAX_LINKS, sizeof(*nl_table), GFP_KERNEL);
 	if (!nl_table) {
 enomem:
 		printk(KERN_CRIT "netlink_init: Cannot allocate nl_table\n");
 		return -ENOMEM;
 	}
 
-	memset(nl_table, 0, sizeof(*nl_table) * MAX_LINKS);
-
 	if (num_physpages >= (128 * 1024))
 		max = num_physpages >> (21 - PAGE_SHIFT);
 	else
diff --git a/net/rxrpc/connection.c b/net/rxrpc/connection.c
index 573b572..93d2c55 100644
--- a/net/rxrpc/connection.c
+++ b/net/rxrpc/connection.c
@@ -58,13 +58,12 @@ static inline int __rxrpc_create_connect
 	_enter("%p",peer);
 
 	/* allocate and initialise a connection record */
-	conn = kmalloc(sizeof(struct rxrpc_connection), GFP_KERNEL);
+	conn = kzalloc(sizeof(struct rxrpc_connection), GFP_KERNEL);
 	if (!conn) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
 	}
 
-	memset(conn, 0, sizeof(struct rxrpc_connection));
 	atomic_set(&conn->usage, 1);
 
 	INIT_LIST_HEAD(&conn->link);
@@ -535,13 +534,12 @@ int rxrpc_conn_newmsg(struct rxrpc_conne
 		return -EINVAL;
 	}
 
-	msg = kmalloc(sizeof(struct rxrpc_message), alloc_flags);
+	msg = kzalloc(sizeof(struct rxrpc_message), alloc_flags);
 	if (!msg) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
 	}
 
-	memset(msg, 0, sizeof(*msg));
 	atomic_set(&msg->usage, 1);
 
 	INIT_LIST_HEAD(&msg->link);
diff --git a/net/rxrpc/peer.c b/net/rxrpc/peer.c
index ed38f5b..8a27515 100644
--- a/net/rxrpc/peer.c
+++ b/net/rxrpc/peer.c
@@ -58,13 +58,12 @@ static int __rxrpc_create_peer(struct rx
 	_enter("%p,%08x", trans, ntohl(addr));
 
 	/* allocate and initialise a peer record */
-	peer = kmalloc(sizeof(struct rxrpc_peer), GFP_KERNEL);
+	peer = kzalloc(sizeof(struct rxrpc_peer), GFP_KERNEL);
 	if (!peer) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
 	}
 
-	memset(peer, 0, sizeof(struct rxrpc_peer));
 	atomic_set(&peer->usage, 1);
 
 	INIT_LIST_HEAD(&peer->link);
diff --git a/net/rxrpc/transport.c b/net/rxrpc/transport.c
index dbe6105..465efc8 100644
--- a/net/rxrpc/transport.c
+++ b/net/rxrpc/transport.c
@@ -68,11 +68,10 @@ int rxrpc_create_transport(unsigned shor
 
 	_enter("%hu", port);
 
-	trans = kmalloc(sizeof(struct rxrpc_transport), GFP_KERNEL);
+	trans = kzalloc(sizeof(struct rxrpc_transport), GFP_KERNEL);
 	if (!trans)
 		return -ENOMEM;
 
-	memset(trans, 0, sizeof(struct rxrpc_transport));
 	atomic_set(&trans->usage, 1);
 	INIT_LIST_HEAD(&trans->services);
 	INIT_LIST_HEAD(&trans->link);
@@ -312,13 +311,12 @@ static int rxrpc_incoming_msg(struct rxr
 
 	_enter("");
 
-	msg = kmalloc(sizeof(struct rxrpc_message), GFP_KERNEL);
+	msg = kzalloc(sizeof(struct rxrpc_message), GFP_KERNEL);
 	if (!msg) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
 	}
 
-	memset(msg, 0, sizeof(*msg));
 	atomic_set(&msg->usage, 1);
 	list_add_tail(&msg->link,msgq);
 
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9affeee..a2587b5 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -312,10 +312,9 @@ #endif
 	}
 
 	*err = -ENOMEM;
-	a = kmalloc(sizeof(*a), GFP_KERNEL);
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
 	if (a == NULL)
 		goto err_mod;
-	memset(a, 0, sizeof(*a));
 
 	/* backward compatibility for policer */
 	if (name == NULL)
@@ -492,10 +491,9 @@ tcf_action_get_1(struct rtattr *rta, str
 	index = *(int *)RTA_DATA(tb[TCA_ACT_INDEX - 1]);
 
 	*err = -ENOMEM;
-	a = kmalloc(sizeof(struct tc_action), GFP_KERNEL);
+	a = kzalloc(sizeof(struct tc_action), GFP_KERNEL);
 	if (a == NULL)
 		return NULL;
-	memset(a, 0, sizeof(struct tc_action));
 
 	*err = -EINVAL;
 	a->ops = tc_lookup_action(tb[TCA_ACT_KIND - 1]);
@@ -531,12 +529,11 @@ static struct tc_action *create_a(int i)
 {
 	struct tc_action *act;
 
-	act = kmalloc(sizeof(*act), GFP_KERNEL);
+	act = kzalloc(sizeof(*act), GFP_KERNEL);
 	if (act == NULL) {
 		printk("create_a: failed to alloc!\n");
 		return NULL;
 	}
-	memset(act, 0, sizeof(*act));
 	act->order = i;
 	return act;
 }
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 58b3a86..f257475 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -209,10 +209,9 @@ tcf_pedit_dump(struct sk_buff *skb, stru
 	s = sizeof(*opt) + p->nkeys * sizeof(struct tc_pedit_key);
 
 	/* netlink spinlocks held above us - must use ATOMIC */
-	opt = kmalloc(s, GFP_ATOMIC);
+	opt = kzalloc(s, GFP_ATOMIC);
 	if (opt == NULL)
 		return -ENOBUFS;
-	memset(opt, 0, s);
 
 	memcpy(opt->keys, p->keys, p->nkeys * sizeof(struct tc_pedit_key));
 	opt->index = p->index;
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 47e00bd..da905d7 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -196,10 +196,9 @@ static int tcf_act_police_locate(struct 
 		return ret;
 	}
 
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
 		return -ENOMEM;
-	memset(p, 0, sizeof(*p));
 
 	ret = ACT_P_CREATED;
 	p->refcnt = 1;
@@ -429,11 +428,10 @@ struct tcf_police * tcf_police_locate(st
 		return p;
 	}
 
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
 		return NULL;
 
-	memset(p, 0, sizeof(*p));
 	p->refcnt = 1;
 	spin_lock_init(&p->lock);
 	p->stats_lock = &p->lock;
diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index 61507f0..86cac49 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -178,19 +178,17 @@ static int basic_change(struct tcf_proto
 
 	err = -ENOBUFS;
 	if (head == NULL) {
-		head = kmalloc(sizeof(*head), GFP_KERNEL);
+		head = kzalloc(sizeof(*head), GFP_KERNEL);
 		if (head == NULL)
 			goto errout;
 
-		memset(head, 0, sizeof(*head));
 		INIT_LIST_HEAD(&head->flist);
 		tp->root = head;
 	}
 
-	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	f = kzalloc(sizeof(*f), GFP_KERNEL);
 	if (f == NULL)
 		goto errout;
-	memset(f, 0, sizeof(*f));
 
 	err = -EINVAL;
 	if (handle)
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index d41de91..e6973d9 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -267,20 +267,18 @@ static int fw_change(struct tcf_proto *t
 		return -EINVAL;
 
 	if (head == NULL) {
-		head = kmalloc(sizeof(struct fw_head), GFP_KERNEL);
+		head = kzalloc(sizeof(struct fw_head), GFP_KERNEL);
 		if (head == NULL)
 			return -ENOBUFS;
-		memset(head, 0, sizeof(*head));
 
 		tcf_tree_lock(tp);
 		tp->root = head;
 		tcf_tree_unlock(tp);
 	}
 
-	f = kmalloc(sizeof(struct fw_filter), GFP_KERNEL);
+	f = kzalloc(sizeof(struct fw_filter), GFP_KERNEL);
 	if (f == NULL)
 		return -ENOBUFS;
-	memset(f, 0, sizeof(*f));
 
 	f->id = handle;
 
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index c2e7190..d3aea73 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -396,10 +396,9 @@ static int route4_set_parms(struct tcf_p
 	h1 = to_hash(nhandle);
 	if ((b = head->table[h1]) == NULL) {
 		err = -ENOBUFS;
-		b = kmalloc(sizeof(struct route4_bucket), GFP_KERNEL);
+		b = kzalloc(sizeof(struct route4_bucket), GFP_KERNEL);
 		if (b == NULL)
 			goto errout;
-		memset(b, 0, sizeof(*b));
 
 		tcf_tree_lock(tp);
 		head->table[h1] = b;
@@ -475,20 +474,18 @@ static int route4_change(struct tcf_prot
 
 	err = -ENOBUFS;
 	if (head == NULL) {
-		head = kmalloc(sizeof(struct route4_head), GFP_KERNEL);
+		head = kzalloc(sizeof(struct route4_head), GFP_KERNEL);
 		if (head == NULL)
 			goto errout;
-		memset(head, 0, sizeof(struct route4_head));
 
 		tcf_tree_lock(tp);
 		tp->root = head;
 		tcf_tree_unlock(tp);
 	}
 
-	f = kmalloc(sizeof(struct route4_filter), GFP_KERNEL);
+	f = kzalloc(sizeof(struct route4_filter), GFP_KERNEL);
 	if (f == NULL)
 		goto errout;
-	memset(f, 0, sizeof(*f));
 
 	err = route4_set_parms(tp, base, f, handle, head, tb,
 		tca[TCA_RATE-1], 1);
diff --git a/net/sched/cls_rsvp.h b/net/sched/cls_rsvp.h
index ba87419..6e230ec 100644
--- a/net/sched/cls_rsvp.h
+++ b/net/sched/cls_rsvp.h
@@ -240,9 +240,8 @@ static int rsvp_init(struct tcf_proto *t
 {
 	struct rsvp_head *data;
 
-	data = kmalloc(sizeof(struct rsvp_head), GFP_KERNEL);
+	data = kzalloc(sizeof(struct rsvp_head), GFP_KERNEL);
 	if (data) {
-		memset(data, 0, sizeof(struct rsvp_head));
 		tp->root = data;
 		return 0;
 	}
@@ -446,11 +445,10 @@ static int rsvp_change(struct tcf_proto 
 		goto errout2;
 
 	err = -ENOBUFS;
-	f = kmalloc(sizeof(struct rsvp_filter), GFP_KERNEL);
+	f = kzalloc(sizeof(struct rsvp_filter), GFP_KERNEL);
 	if (f == NULL)
 		goto errout2;
 
-	memset(f, 0, sizeof(*f));
 	h2 = 16;
 	if (tb[TCA_RSVP_SRC-1]) {
 		err = -EINVAL;
@@ -532,10 +530,9 @@ insert:
 	/* No session found. Create new one. */
 
 	err = -ENOBUFS;
-	s = kmalloc(sizeof(struct rsvp_session), GFP_KERNEL);
+	s = kzalloc(sizeof(struct rsvp_session), GFP_KERNEL);
 	if (s == NULL)
 		goto errout;
-	memset(s, 0, sizeof(*s));
 	memcpy(s->dst, dst, sizeof(s->dst));
 
 	if (pinfo) {
diff --git a/net/sched/cls_tcindex.c b/net/sched/cls_tcindex.c
index 7870e7b..5af8a59 100644
--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -148,11 +148,10 @@ static int tcindex_init(struct tcf_proto
 	struct tcindex_data *p;
 
 	DPRINTK("tcindex_init(tp %p)\n",tp);
-	p = kmalloc(sizeof(struct tcindex_data),GFP_KERNEL);
+	p = kzalloc(sizeof(struct tcindex_data),GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
-	memset(p, 0, sizeof(*p));
 	p->mask = 0xffff;
 	p->hash = DEFAULT_HASH_SIZE;
 	p->fall_through = 1;
@@ -296,16 +295,14 @@ tcindex_set_parms(struct tcf_proto *tp, 
 	err = -ENOMEM;
 	if (!cp.perfect && !cp.h) {
 		if (valid_perfect_hash(&cp)) {
-			cp.perfect = kmalloc(cp.hash * sizeof(*r), GFP_KERNEL);
+			cp.perfect = kcalloc(cp.hash, sizeof(*r), GFP_KERNEL);
 			if (!cp.perfect)
 				goto errout;
-			memset(cp.perfect, 0, cp.hash * sizeof(*r));
 			balloc = 1;
 		} else {
-			cp.h = kmalloc(cp.hash * sizeof(f), GFP_KERNEL);
+			cp.h = kcalloc(cp.hash, sizeof(f), GFP_KERNEL);
 			if (!cp.h)
 				goto errout;
-			memset(cp.h, 0, cp.hash * sizeof(f));
 			balloc = 2;
 		}
 	}
@@ -316,10 +313,9 @@ tcindex_set_parms(struct tcf_proto *tp, 
 		r = tcindex_lookup(&cp, handle) ? : &new_filter_result;
 
 	if (r == &new_filter_result) {
-		f = kmalloc(sizeof(*f), GFP_KERNEL);
+		f = kzalloc(sizeof(*f), GFP_KERNEL);
 		if (!f)
 			goto errout_alloc;
-		memset(f, 0, sizeof(*f));
  	}
 
 	if (tb[TCA_TCINDEX_CLASSID-1]) {
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d712edc..eea3669 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -307,23 +307,21 @@ static int u32_init(struct tcf_proto *tp
 		if (tp_c->q == tp->q)
 			break;
 
-	root_ht = kmalloc(sizeof(*root_ht), GFP_KERNEL);
+	root_ht = kzalloc(sizeof(*root_ht), GFP_KERNEL);
 	if (root_ht == NULL)
 		return -ENOBUFS;
 
-	memset(root_ht, 0, sizeof(*root_ht));
 	root_ht->divisor = 0;
 	root_ht->refcnt++;
 	root_ht->handle = tp_c ? gen_new_htid(tp_c) : 0x80000000;
 	root_ht->prio = tp->prio;
 
 	if (tp_c == NULL) {
-		tp_c = kmalloc(sizeof(*tp_c), GFP_KERNEL);
+		tp_c = kzalloc(sizeof(*tp_c), GFP_KERNEL);
 		if (tp_c == NULL) {
 			kfree(root_ht);
 			return -ENOBUFS;
 		}
-		memset(tp_c, 0, sizeof(*tp_c));
 		tp_c->q = tp->q;
 		tp_c->next = u32_list;
 		u32_list = tp_c;
@@ -571,10 +569,9 @@ static int u32_change(struct tcf_proto *
 			if (handle == 0)
 				return -ENOMEM;
 		}
-		ht = kmalloc(sizeof(*ht) + divisor*sizeof(void*), GFP_KERNEL);
+		ht = kzalloc(sizeof(*ht) + divisor*sizeof(void*), GFP_KERNEL);
 		if (ht == NULL)
 			return -ENOBUFS;
-		memset(ht, 0, sizeof(*ht) + divisor*sizeof(void*));
 		ht->tp_c = tp_c;
 		ht->refcnt = 0;
 		ht->divisor = divisor;
@@ -617,18 +614,16 @@ static int u32_change(struct tcf_proto *
 
 	s = RTA_DATA(tb[TCA_U32_SEL-1]);
 
-	n = kmalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
+	n = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
 	if (n == NULL)
 		return -ENOBUFS;
 
-	memset(n, 0, sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key));
 #ifdef CONFIG_CLS_U32_PERF
-	n->pf = kmalloc(sizeof(struct tc_u32_pcnt) + s->nkeys*sizeof(u64), GFP_KERNEL);
+	n->pf = kzalloc(sizeof(struct tc_u32_pcnt) + s->nkeys*sizeof(u64), GFP_KERNEL);
 	if (n->pf == NULL) {
 		kfree(n);
 		return -ENOBUFS;
 	}
-	memset(n->pf, 0, sizeof(struct tc_u32_pcnt) + s->nkeys*sizeof(u64));
 #endif
 
 	memcpy(&n->sel, s, sizeof(*s) + s->nkeys*sizeof(struct tc_u32_key));
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 6983729..61e3b74 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -773,10 +773,9 @@ static int em_meta_change(struct tcf_pro
 	    TCF_META_ID(hdr->right.kind) > TCF_META_ID_MAX)
 		goto errout;
 
-	meta = kmalloc(sizeof(*meta), GFP_KERNEL);
+	meta = kzalloc(sizeof(*meta), GFP_KERNEL);
 	if (meta == NULL)
 		goto errout;
-	memset(meta, 0, sizeof(*meta));
 
 	memcpy(&meta->lvalue.hdr, &hdr->left, sizeof(hdr->left));
 	memcpy(&meta->rvalue.hdr, &hdr->right, sizeof(hdr->right));
diff --git a/net/sched/ematch.c b/net/sched/ematch.c
index 2405a86..0fd0768 100644
--- a/net/sched/ematch.c
+++ b/net/sched/ematch.c
@@ -321,10 +321,9 @@ int tcf_em_tree_validate(struct tcf_prot
 	list_len = RTA_PAYLOAD(rt_list);
 	matches_len = tree_hdr->nmatches * sizeof(*em);
 
-	tree->matches = kmalloc(matches_len, GFP_KERNEL);
+	tree->matches = kzalloc(matches_len, GFP_KERNEL);
 	if (tree->matches == NULL)
 		goto errout;
-	memset(tree->matches, 0, matches_len);
 
 	/* We do not use rtattr_parse_nested here because the maximum
 	 * number of attributes is unknown. This saves us the allocation
diff --git a/net/sched/estimator.c b/net/sched/estimator.c
index 5d3ae03..0ebc98e 100644
--- a/net/sched/estimator.c
+++ b/net/sched/estimator.c
@@ -139,11 +139,10 @@ int qdisc_new_estimator(struct tc_stats 
 	if (parm->interval < -2 || parm->interval > 3)
 		return -EINVAL;
 
-	est = kmalloc(sizeof(*est), GFP_KERNEL);
+	est = kzalloc(sizeof(*est), GFP_KERNEL);
 	if (est == NULL)
 		return -ENOBUFS;
 
-	memset(est, 0, sizeof(*est));
 	est->interval = parm->interval + 2;
 	est->stats = stats;
 	est->stats_lock = stats_lock;
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
index 80b7f6a..bac881b 100644
--- a/net/sched/sch_cbq.c
+++ b/net/sched/sch_cbq.c
@@ -1926,10 +1926,9 @@ #endif
 	}
 
 	err = -ENOBUFS;
-	cl = kmalloc(sizeof(*cl), GFP_KERNEL);
+	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
 	if (cl == NULL)
 		goto failure;
-	memset(cl, 0, sizeof(*cl));
 	cl->R_tab = rtab;
 	rtab = NULL;
 	cl->refcnt = 1;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index d735f51..0834c2e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -432,10 +432,9 @@ struct Qdisc *qdisc_alloc(struct net_dev
 	size = QDISC_ALIGN(sizeof(*sch));
 	size += ops->priv_size + (QDISC_ALIGNTO - 1);
 
-	p = kmalloc(size, GFP_KERNEL);
+	p = kzalloc(size, GFP_KERNEL);
 	if (!p)
 		goto errout;
-	memset(p, 0, size);
 	sch = (struct Qdisc *) QDISC_ALIGN((unsigned long) p);
 	sch->padded = (char *) sch - (char *) p;
 
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 0cafdd5..18e81a8 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -406,10 +406,9 @@ static inline int gred_change_vq(struct 
 	struct gred_sched_data *q;
 
 	if (table->tab[dp] == NULL) {
-		table->tab[dp] = kmalloc(sizeof(*q), GFP_KERNEL);
+		table->tab[dp] = kzalloc(sizeof(*q), GFP_KERNEL);
 		if (table->tab[dp] == NULL)
 			return -ENOMEM;
-		memset(table->tab[dp], 0, sizeof(*q));
 	}
 
 	q = table->tab[dp];
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 6b1b4a9..6a6735a 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1123,10 +1123,9 @@ #endif
 	if (rsc == NULL && fsc == NULL)
 		return -EINVAL;
 
-	cl = kmalloc(sizeof(struct hfsc_class), GFP_KERNEL);
+	cl = kzalloc(sizeof(struct hfsc_class), GFP_KERNEL);
 	if (cl == NULL)
 		return -ENOBUFS;
-	memset(cl, 0, sizeof(struct hfsc_class));
 
 	if (rsc != NULL)
 		hfsc_change_rsc(cl, rsc, 0);
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index cc5f339..880a339 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1559,10 +1559,9 @@ static int htb_change_class(struct Qdisc
 			goto failure;
 		}
 		err = -ENOBUFS;
-		if ((cl = kmalloc(sizeof(*cl), GFP_KERNEL)) == NULL)
+		if ((cl = kzalloc(sizeof(*cl), GFP_KERNEL)) == NULL)
 			goto failure;
 		
-		memset(cl, 0, sizeof(*cl));
 		cl->refcnt = 1;
 		INIT_LIST_HEAD(&cl->sibling);
 		INIT_LIST_HEAD(&cl->hlist);
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 519ebc1..4a9aa93 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -225,9 +225,8 @@ gss_alloc_context(void)
 {
 	struct gss_cl_ctx *ctx;
 
-	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (ctx != NULL) {
-		memset(ctx, 0, sizeof(*ctx));
 		ctx->gc_proc = RPC_GSS_PROC_DATA;
 		ctx->gc_seq = 1;	/* NetApp 6.4R1 doesn't accept seq. no. 0 */
 		spin_lock_init(&ctx->gc_seq_lock);
@@ -391,9 +390,8 @@ gss_alloc_msg(struct gss_auth *gss_auth,
 {
 	struct gss_upcall_msg *gss_msg;
 
-	gss_msg = kmalloc(sizeof(*gss_msg), GFP_KERNEL);
+	gss_msg = kzalloc(sizeof(*gss_msg), GFP_KERNEL);
 	if (gss_msg != NULL) {
-		memset(gss_msg, 0, sizeof(*gss_msg));
 		INIT_LIST_HEAD(&gss_msg->list);
 		rpc_init_wait_queue(&gss_msg->rpc_waitqueue, "RPCSEC_GSS upcall waitq");
 		init_waitqueue_head(&gss_msg->waitqueue);
@@ -776,10 +774,9 @@ gss_create_cred(struct rpc_auth *auth, s
 	dprintk("RPC:      gss_create_cred for uid %d, flavor %d\n",
 		acred->uid, auth->au_flavor);
 
-	if (!(cred = kmalloc(sizeof(*cred), GFP_KERNEL)))
+	if (!(cred = kzalloc(sizeof(*cred), GFP_KERNEL)))
 		goto out_err;
 
-	memset(cred, 0, sizeof(*cred));
 	atomic_set(&cred->gc_count, 1);
 	cred->gc_uid = acred->uid;
 	/*
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index b8714a8..70e1e53 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -129,9 +129,8 @@ gss_import_sec_context_kerberos(const vo
 	const void *end = (const void *)((const char *)p + len);
 	struct	krb5_ctx *ctx;
 
-	if (!(ctx = kmalloc(sizeof(*ctx), GFP_KERNEL)))
+	if (!(ctx = kzalloc(sizeof(*ctx), GFP_KERNEL)))
 		goto out_err;
-	memset(ctx, 0, sizeof(*ctx));
 
 	p = simple_get_bytes(p, end, &ctx->initiate, sizeof(ctx->initiate));
 	if (IS_ERR(p))
diff --git a/net/sunrpc/auth_gss/gss_mech_switch.c b/net/sunrpc/auth_gss/gss_mech_switch.c
index d88468d..3db7453 100644
--- a/net/sunrpc/auth_gss/gss_mech_switch.c
+++ b/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -237,9 +237,8 @@ gss_import_sec_context(const void *input
 		       struct gss_api_mech	*mech,
 		       struct gss_ctx		**ctx_id)
 {
-	if (!(*ctx_id = kmalloc(sizeof(**ctx_id), GFP_KERNEL)))
+	if (!(*ctx_id = kzalloc(sizeof(**ctx_id), GFP_KERNEL)))
 		return GSS_S_FAILURE;
-	memset(*ctx_id, 0, sizeof(**ctx_id));
 	(*ctx_id)->mech_type = gss_mech_get(mech);
 
 	return mech->gm_ops
diff --git a/net/sunrpc/auth_gss/gss_spkm3_mech.c b/net/sunrpc/auth_gss/gss_spkm3_mech.c
index 3d0432a..88dcb52 100644
--- a/net/sunrpc/auth_gss/gss_spkm3_mech.c
+++ b/net/sunrpc/auth_gss/gss_spkm3_mech.c
@@ -152,9 +152,8 @@ gss_import_sec_context_spkm3(const void 
 	const void *end = (const void *)((const char *)p + len);
 	struct	spkm3_ctx *ctx;
 
-	if (!(ctx = kmalloc(sizeof(*ctx), GFP_KERNEL)))
+	if (!(ctx = kzalloc(sizeof(*ctx), GFP_KERNEL)))
 		goto out_err;
-	memset(ctx, 0, sizeof(*ctx));
 
 	p = simple_get_netobj(p, end, &ctx->ctx_id);
 	if (IS_ERR(p))
diff --git a/net/sunrpc/auth_gss/gss_spkm3_token.c b/net/sunrpc/auth_gss/gss_spkm3_token.c
index af0d7ce..854a983 100644
--- a/net/sunrpc/auth_gss/gss_spkm3_token.c
+++ b/net/sunrpc/auth_gss/gss_spkm3_token.c
@@ -90,10 +90,9 @@ asn1_bitstring_len(struct xdr_netobj *in
 int
 decode_asn1_bitstring(struct xdr_netobj *out, char *in, int enclen, int explen)
 {
-	if (!(out->data = kmalloc(explen,GFP_KERNEL)))
+	if (!(out->data = kzalloc(explen,GFP_KERNEL)))
 		return 0;
 	out->len = explen;
-	memset(out->data, 0, explen);
 	memcpy(out->data, in, enclen);
 	return 1;
 }
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index aa8965e..4ba271f 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -125,10 +125,9 @@ rpc_new_client(struct rpc_xprt *xprt, ch
 		goto out_err;
 
 	err = -ENOMEM;
-	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
+	clnt = kzalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
 		goto out_err;
-	memset(clnt, 0, sizeof(*clnt));
 	atomic_set(&clnt->cl_users, 0);
 	atomic_set(&clnt->cl_count, 1);
 	clnt->cl_parent = clnt;
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 15c2db2..bd98124 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -114,13 +114,8 @@ void svc_seq_show(struct seq_file *seq, 
  */
 struct rpc_iostats *rpc_alloc_iostats(struct rpc_clnt *clnt)
 {
-	unsigned int ops = clnt->cl_maxproc;
-	size_t size = ops * sizeof(struct rpc_iostats);
 	struct rpc_iostats *new;
-
-	new = kmalloc(size, GFP_KERNEL);
-	if (new)
-		memset(new, 0 , size);
+	new = kcalloc(clnt->cl_maxproc, sizeof(struct rpc_iostats), GFP_KERNEL);
 	return new;
 }
 EXPORT_SYMBOL(rpc_alloc_iostats);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 01ba60a..b76a227 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -32,9 +32,8 @@ svc_create(struct svc_program *prog, uns
 	int vers;
 	unsigned int xdrsize;
 
-	if (!(serv = kmalloc(sizeof(*serv), GFP_KERNEL)))
+	if (!(serv = kzalloc(sizeof(*serv), GFP_KERNEL)))
 		return NULL;
-	memset(serv, 0, sizeof(*serv));
 	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
 	serv->sv_nrthreads = 1;
@@ -159,11 +158,10 @@ svc_create_thread(svc_thread_fn func, st
 	struct svc_rqst	*rqstp;
 	int		error = -ENOMEM;
 
-	rqstp = kmalloc(sizeof(*rqstp), GFP_KERNEL);
+	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
 	if (!rqstp)
 		goto out;
 
-	memset(rqstp, 0, sizeof(*rqstp));
 	init_waitqueue_head(&rqstp->rq_wait);
 
 	if (!(rqstp->rq_argp = kmalloc(serv->sv_xdrsize, GFP_KERNEL))
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index a27905a..d9a9573 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1322,11 +1322,10 @@ svc_setup_socket(struct svc_serv *serv, 
 	struct sock	*inet;
 
 	dprintk("svc: svc_setup_socket %p\n", sock);
-	if (!(svsk = kmalloc(sizeof(*svsk), GFP_KERNEL))) {
+	if (!(svsk = kzalloc(sizeof(*svsk), GFP_KERNEL))) {
 		*errp = -ENOMEM;
 		return NULL;
 	}
-	memset(svsk, 0, sizeof(*svsk));
 
 	inet = sock->sk;
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 02060d0..313b68d 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -908,9 +908,8 @@ static struct rpc_xprt *xprt_setup(int p
 	struct rpc_xprt	*xprt;
 	struct rpc_rqst	*req;
 
-	if ((xprt = kmalloc(sizeof(struct rpc_xprt), GFP_KERNEL)) == NULL)
+	if ((xprt = kzalloc(sizeof(struct rpc_xprt), GFP_KERNEL)) == NULL)
 		return ERR_PTR(-ENOMEM);
-	memset(xprt, 0, sizeof(*xprt)); /* Nnnngh! */
 
 	xprt->addr = *ap;
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 21006b1..ee678ed 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1276,10 +1276,9 @@ int xs_setup_udp(struct rpc_xprt *xprt, 
 
 	xprt->max_reqs = xprt_udp_slot_table_entries;
 	slot_table_size = xprt->max_reqs * sizeof(xprt->slot[0]);
-	xprt->slot = kmalloc(slot_table_size, GFP_KERNEL);
+	xprt->slot = kzalloc(slot_table_size, GFP_KERNEL);
 	if (xprt->slot == NULL)
 		return -ENOMEM;
-	memset(xprt->slot, 0, slot_table_size);
 
 	xprt->prot = IPPROTO_UDP;
 	xprt->port = xs_get_random_port();
@@ -1318,10 +1317,9 @@ int xs_setup_tcp(struct rpc_xprt *xprt, 
 
 	xprt->max_reqs = xprt_tcp_slot_table_entries;
 	slot_table_size = xprt->max_reqs * sizeof(xprt->slot[0]);
-	xprt->slot = kmalloc(slot_table_size, GFP_KERNEL);
+	xprt->slot = kzalloc(slot_table_size, GFP_KERNEL);
 	if (xprt->slot == NULL)
 		return -ENOMEM;
-	memset(xprt->slot, 0, slot_table_size);
 
 	xprt->prot = IPPROTO_TCP;
 	xprt->port = xs_get_random_port();
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 7ef17a4..75a5968 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -665,11 +665,9 @@ int tipc_bearer_init(void)
 	int res;
 
 	write_lock_bh(&tipc_net_lock);
-	tipc_bearers = kmalloc(MAX_BEARERS * sizeof(struct bearer), GFP_ATOMIC);
-	media_list = kmalloc(MAX_MEDIA * sizeof(struct media), GFP_ATOMIC);
+	tipc_bearers = kcalloc(MAX_BEARERS, sizeof(struct bearer), GFP_ATOMIC);
+	media_list = kcalloc(MAX_MEDIA, sizeof(struct media), GFP_ATOMIC);
 	if (tipc_bearers && media_list) {
-		memset(tipc_bearers, 0, MAX_BEARERS * sizeof(struct bearer));
-		memset(media_list, 0, MAX_MEDIA * sizeof(struct media));
 		res = TIPC_OK;
 	} else {
 		kfree(tipc_bearers);
diff --git a/net/tipc/cluster.c b/net/tipc/cluster.c
index 1dcb694..b46b518 100644
--- a/net/tipc/cluster.c
+++ b/net/tipc/cluster.c
@@ -57,29 +57,25 @@ struct cluster *tipc_cltr_create(u32 add
 	struct _zone *z_ptr;
 	struct cluster *c_ptr;
 	int max_nodes; 
-	int alloc;
 
-	c_ptr = (struct cluster *)kmalloc(sizeof(*c_ptr), GFP_ATOMIC);
+	c_ptr = kzalloc(sizeof(*c_ptr), GFP_ATOMIC);
 	if (c_ptr == NULL) {
 		warn("Cluster creation failure, no memory\n");
 		return NULL;
 	}
-	memset(c_ptr, 0, sizeof(*c_ptr));
 
 	c_ptr->addr = tipc_addr(tipc_zone(addr), tipc_cluster(addr), 0);
 	if (in_own_cluster(addr))
 		max_nodes = LOWEST_SLAVE + tipc_max_slaves;
 	else
 		max_nodes = tipc_max_nodes + 1;
-	alloc = sizeof(void *) * (max_nodes + 1);
 
-	c_ptr->nodes = (struct node **)kmalloc(alloc, GFP_ATOMIC);
+	c_ptr->nodes = kcalloc(max_nodes + 1, sizeof(void*), GFP_ATOMIC);
 	if (c_ptr->nodes == NULL) {
 		warn("Cluster creation failure, no memory for node area\n");
 		kfree(c_ptr);
 		return NULL;
 	}
-	memset(c_ptr->nodes, 0, alloc);
 
 	if (in_own_cluster(addr))
 		tipc_local_nodes = c_ptr->nodes;
diff --git a/net/tipc/link.c b/net/tipc/link.c
index c10e18a..693f02e 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -417,12 +417,11 @@ struct link *tipc_link_create(struct bea
 	struct tipc_msg *msg;
 	char *if_name;
 
-	l_ptr = (struct link *)kmalloc(sizeof(*l_ptr), GFP_ATOMIC);
+	l_ptr = kzalloc(sizeof(*l_ptr), GFP_ATOMIC);
 	if (!l_ptr) {
 		warn("Link creation failed, no memory\n");
 		return NULL;
 	}
-	memset(l_ptr, 0, sizeof(*l_ptr));
 
 	l_ptr->addr = peer;
 	if_name = strchr(b_ptr->publ.name, ':') + 1;
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index a6926ff..049242e 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -117,14 +117,12 @@ static struct publication *publ_create(u
 				       u32 scope, u32 node, u32 port_ref,   
 				       u32 key)
 {
-	struct publication *publ =
-		(struct publication *)kmalloc(sizeof(*publ), GFP_ATOMIC);
+	struct publication *publ = kzalloc(sizeof(*publ), GFP_ATOMIC);
 	if (publ == NULL) {
 		warn("Publication creation failure, no memory\n");
 		return NULL;
 	}
 
-	memset(publ, 0, sizeof(*publ));
 	publ->type = type;
 	publ->lower = lower;
 	publ->upper = upper;
@@ -144,11 +142,7 @@ static struct publication *publ_create(u
 
 static struct sub_seq *tipc_subseq_alloc(u32 cnt)
 {
-	u32 sz = cnt * sizeof(struct sub_seq);
-	struct sub_seq *sseq = (struct sub_seq *)kmalloc(sz, GFP_ATOMIC);
-
-	if (sseq)
-		memset(sseq, 0, sz);
+	struct sub_seq *sseq = kcalloc(cnt, sizeof(struct sub_seq), GFP_ATOMIC);
 	return sseq;
 }
 
@@ -160,8 +154,7 @@ static struct sub_seq *tipc_subseq_alloc
 
 static struct name_seq *tipc_nameseq_create(u32 type, struct hlist_head *seq_head)
 {
-	struct name_seq *nseq = 
-		(struct name_seq *)kmalloc(sizeof(*nseq), GFP_ATOMIC);
+	struct name_seq *nseq = kzalloc(sizeof(*nseq), GFP_ATOMIC);
 	struct sub_seq *sseq = tipc_subseq_alloc(1);
 
 	if (!nseq || !sseq) {
@@ -171,7 +164,6 @@ static struct name_seq *tipc_nameseq_cre
 		return NULL;
 	}
 
-	memset(nseq, 0, sizeof(*nseq));
 	spin_lock_init(&nseq->lock);
 	nseq->type = type;
 	nseq->sseqs = sseq;
@@ -1060,7 +1052,7 @@ int tipc_nametbl_init(void)
 {
 	int array_size = sizeof(struct hlist_head) * tipc_nametbl_size;
 
-	table.types = (struct hlist_head *)kmalloc(array_size, GFP_ATOMIC);
+	table.types = kmalloc(array_size, GFP_ATOMIC);
 	if (!table.types)
 		return -ENOMEM;
 
diff --git a/net/tipc/net.c b/net/tipc/net.c
index e5a359a..a991bf8 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -160,14 +160,11 @@ void tipc_net_send_external_routes(u32 d
 
 static int net_init(void)
 {
-	u32 sz = sizeof(struct _zone *) * (tipc_max_zones + 1);
-
 	memset(&tipc_net, 0, sizeof(tipc_net));
-	tipc_net.zones = (struct _zone **)kmalloc(sz, GFP_ATOMIC);
+	tipc_net.zones = kcalloc(tipc_max_zones + 1, sizeof(struct _zone *), GFP_ATOMIC);
 	if (!tipc_net.zones) {
 		return -ENOMEM;
 	}
-	memset(tipc_net.zones, 0, sz);
 	return TIPC_OK;
 }
 
diff --git a/net/tipc/port.c b/net/tipc/port.c
index 3251c8d..b9c8c6b 100644
--- a/net/tipc/port.c
+++ b/net/tipc/port.c
@@ -226,12 +226,11 @@ u32 tipc_createport_raw(void *usr_handle
 	struct tipc_msg *msg;
 	u32 ref;
 
-	p_ptr = kmalloc(sizeof(*p_ptr), GFP_ATOMIC);
+	p_ptr = kzalloc(sizeof(*p_ptr), GFP_ATOMIC);
 	if (!p_ptr) {
 		warn("Port creation failed, no memory\n");
 		return 0;
 	}
-	memset(p_ptr, 0, sizeof(*p_ptr));
 	ref = tipc_ref_acquire(p_ptr, &p_ptr->publ.lock);
 	if (!ref) {
 		warn("Port creation failed, reference table exhausted\n");
@@ -1058,7 +1057,7 @@ int tipc_createport(u32 user_ref, 
 	struct port *p_ptr; 
 	u32 ref;
 
-	up_ptr = (struct user_port *)kmalloc(sizeof(*up_ptr), GFP_ATOMIC);
+	up_ptr = kmalloc(sizeof(*up_ptr), GFP_ATOMIC);
 	if (!up_ptr) {
 		warn("Port creation failed, no memory\n");
 		return -ENOMEM;
diff --git a/net/tipc/subscr.c b/net/tipc/subscr.c
index e19b4bc..c51600b 100644
--- a/net/tipc/subscr.c
+++ b/net/tipc/subscr.c
@@ -393,12 +393,11 @@ static void subscr_named_msg_event(void 
 
 	/* Create subscriber object */
 
-	subscriber = kmalloc(sizeof(struct subscriber), GFP_ATOMIC);
+	subscriber = kzalloc(sizeof(struct subscriber), GFP_ATOMIC);
 	if (subscriber == NULL) {
 		warn("Subscriber rejected, no memory\n");
 		return;
 	}
-	memset(subscriber, 0, sizeof(struct subscriber));
 	INIT_LIST_HEAD(&subscriber->subscription_list);
 	INIT_LIST_HEAD(&subscriber->subscriber_list);
 	subscriber->ref = tipc_ref_acquire(subscriber, &subscriber->lock);
diff --git a/net/tipc/user_reg.c b/net/tipc/user_reg.c
index 1e3ae57..04d1b9b 100644
--- a/net/tipc/user_reg.c
+++ b/net/tipc/user_reg.c
@@ -82,9 +82,8 @@ static int reg_init(void)
 	
 	spin_lock_bh(&reg_lock);
 	if (!users) {
-		users = (struct tipc_user *)kmalloc(USER_LIST_SIZE, GFP_ATOMIC);
+		users = kzalloc(USER_LIST_SIZE, GFP_ATOMIC);
 		if (users) {
-			memset(users, 0, USER_LIST_SIZE);
 			for (i = 1; i <= MAX_USERID; i++) {
 				users[i].next = i - 1;
 			}
diff --git a/net/tipc/zone.c b/net/tipc/zone.c
index 316c487..f5b00ea 100644
--- a/net/tipc/zone.c
+++ b/net/tipc/zone.c
@@ -52,13 +52,12 @@ struct _zone *tipc_zone_create(u32 addr)
 		return NULL;
 	}
 
-	z_ptr = (struct _zone *)kmalloc(sizeof(*z_ptr), GFP_ATOMIC);
+	z_ptr = kzalloc(sizeof(*z_ptr), GFP_ATOMIC);
 	if (!z_ptr) {
 		warn("Zone creation failed, insufficient memory\n");
 		return NULL;
 	}
 
-	memset(z_ptr, 0, sizeof(*z_ptr));
 	z_num = tipc_zone(addr);
 	z_ptr->addr = tipc_addr(z_num, 0, 0);
 	tipc_net.zones[z_num] = z_ptr;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f70475b..6f29092 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -663,11 +663,10 @@ static int unix_autobind(struct socket *
 		goto out;
 
 	err = -ENOMEM;
-	addr = kmalloc(sizeof(*addr) + sizeof(short) + 16, GFP_KERNEL);
+	addr = kzalloc(sizeof(*addr) + sizeof(short) + 16, GFP_KERNEL);
 	if (!addr)
 		goto out;
 
-	memset(addr, 0, sizeof(*addr) + sizeof(short) + 16);
 	addr->name->sun_family = AF_UNIX;
 	atomic_set(&addr->refcnt, 1);
 
diff --git a/net/wanrouter/af_wanpipe.c b/net/wanrouter/af_wanpipe.c
index a690cf7..6f39faa 100644
--- a/net/wanrouter/af_wanpipe.c
+++ b/net/wanrouter/af_wanpipe.c
@@ -370,12 +370,11 @@ static int wanpipe_listen_rcv (struct sk
          * used by the ioctl call to read call information
          * and to execute commands. 
          */	
-	if ((mbox_ptr = kmalloc(sizeof(mbox_cmd_t), GFP_ATOMIC)) == NULL) {
+	if ((mbox_ptr = kzalloc(sizeof(mbox_cmd_t), GFP_ATOMIC)) == NULL) {
 		wanpipe_kill_sock_irq (newsk);
 		release_device(dev);		
 		return -ENOMEM;
 	}
-	memset(mbox_ptr, 0, sizeof(mbox_cmd_t));
 	memcpy(mbox_ptr,skb->data,skb->len);
 
 	/* Register the lcn on which incoming call came
@@ -507,11 +506,10 @@ static struct sock *wanpipe_alloc_socket
 	if ((sk = sk_alloc(PF_WANPIPE, GFP_ATOMIC, &wanpipe_proto, 1)) == NULL)
 		return NULL;
 
-	if ((wan_opt = kmalloc(sizeof(struct wanpipe_opt), GFP_ATOMIC)) == NULL) {
+	if ((wan_opt = kzalloc(sizeof(struct wanpipe_opt), GFP_ATOMIC)) == NULL) {
 		sk_free(sk);
 		return NULL;
 	}
-	memset(wan_opt, 0x00, sizeof(struct wanpipe_opt));
 
 	wp_sk(sk) = wan_opt;
 
@@ -2011,10 +2009,9 @@ static int set_ioctl_cmd (struct sock *s
 
 		dev_put(dev);
 		
-		if ((mbox_ptr = kmalloc(sizeof(mbox_cmd_t), GFP_ATOMIC)) == NULL)
+		if ((mbox_ptr = kzalloc(sizeof(mbox_cmd_t), GFP_ATOMIC)) == NULL)
 			return -ENOMEM;
 
-		memset(mbox_ptr, 0, sizeof(mbox_cmd_t));
 		wp_sk(sk)->mbox = mbox_ptr;
 
 		wanpipe_link_driver(dev,sk);
diff --git a/net/wanrouter/wanmain.c b/net/wanrouter/wanmain.c
index ad8e8a7..9479659 100644
--- a/net/wanrouter/wanmain.c
+++ b/net/wanrouter/wanmain.c
@@ -642,18 +642,16 @@ #endif
 
 	if (cnf->config_id == WANCONFIG_MPPP) {
 #ifdef CONFIG_WANPIPE_MULTPPP
-		pppdev = kmalloc(sizeof(struct ppp_device), GFP_KERNEL);
+		pppdev = kzalloc(sizeof(struct ppp_device), GFP_KERNEL);
 		err = -ENOBUFS;
 		if (pppdev == NULL)
 			goto out;
-		memset(pppdev, 0, sizeof(struct ppp_device));
-		pppdev->dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
+		pppdev->dev = kzalloc(sizeof(struct net_device), GFP_KERNEL);
 		if (pppdev->dev == NULL) {
 			kfree(pppdev);
 			err = -ENOBUFS;
 			goto out;
 		}
-		memset(pppdev->dev, 0, sizeof(struct net_device));
 		err = wandev->new_if(wandev, (struct net_device *)pppdev, cnf);
 		dev = pppdev->dev;
 #else
@@ -663,11 +661,10 @@ #else
 		goto out;
 #endif
 	} else {
-		dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
+		dev = kzalloc(sizeof(struct net_device), GFP_KERNEL);
 		err = -ENOBUFS;
 		if (dev == NULL)
 			goto out;
-		memset(dev, 0, sizeof(struct net_device));
 		err = wandev->new_if(wandev, dev, cnf);
 	}
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 405b741..f35bc67 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -307,10 +307,9 @@ struct xfrm_policy *xfrm_policy_alloc(gf
 {
 	struct xfrm_policy *policy;
 
-	policy = kmalloc(sizeof(struct xfrm_policy), gfp);
+	policy = kzalloc(sizeof(struct xfrm_policy), gfp);
 
 	if (policy) {
-		memset(policy, 0, sizeof(struct xfrm_policy));
 		atomic_set(&policy->refcnt, 1);
 		rwlock_init(&policy->lock);
 		init_timer(&policy->timer);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 43f00fc..0021aad 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -194,10 +194,9 @@ struct xfrm_state *xfrm_state_alloc(void
 {
 	struct xfrm_state *x;
 
-	x = kmalloc(sizeof(struct xfrm_state), GFP_ATOMIC);
+	x = kzalloc(sizeof(struct xfrm_state), GFP_ATOMIC);
 
 	if (x) {
-		memset(x, 0, sizeof(struct xfrm_state));
 		atomic_set(&x->refcnt, 1);
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->bydst);
-- 
1.4.1.gd3ba6
