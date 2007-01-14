Return-Path: <linux-kernel-owner+w=401wt.eu-S1751009AbXANBCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXANBCb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbXANBCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:02:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52777 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbXANBC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:02:26 -0500
Subject: [patch 08/12] mark struct file_operations const 8
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:56:33 -0800
Message-Id: <1168736193.3123.333.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 08/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/net/irda/ircomm/ircomm_core.c
===================================================================
--- linux-2.6.orig/net/irda/ircomm/ircomm_core.c
+++ linux-2.6/net/irda/ircomm/ircomm_core.c
@@ -56,7 +56,7 @@ static void ircomm_control_indication(st
 extern struct proc_dir_entry *proc_irda;
 static int ircomm_seq_open(struct inode *, struct file *);
 
-static struct file_operations ircomm_proc_fops = {
+static const struct file_operations ircomm_proc_fops = {
 	.owner		= THIS_MODULE,
 	.open           = ircomm_seq_open,
 	.read           = seq_read,
Index: linux-2.6/net/irda/iriap.c
===================================================================
--- linux-2.6.orig/net/irda/iriap.c
+++ linux-2.6/net/irda/iriap.c
@@ -1080,7 +1080,7 @@ static int irias_seq_open(struct inode *
 	return seq_open(file, &irias_seq_ops);
 }
 
-struct file_operations irias_seq_fops = {
+const struct file_operations irias_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open           = irias_seq_open,
 	.read           = seq_read,
Index: linux-2.6/net/irda/irlan/irlan_common.c
===================================================================
--- linux-2.6.orig/net/irda/irlan/irlan_common.c
+++ linux-2.6/net/irda/irlan/irlan_common.c
@@ -93,7 +93,7 @@ extern struct proc_dir_entry *proc_irda;
 
 static int irlan_seq_open(struct inode *inode, struct file *file);
 
-static struct file_operations irlan_fops = {
+static const struct file_operations irlan_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = irlan_seq_open,
 	.read    = seq_read,
Index: linux-2.6/net/irda/irlap.c
===================================================================
--- linux-2.6.orig/net/irda/irlap.c
+++ linux-2.6/net/irda/irlap.c
@@ -1244,7 +1244,7 @@ out_kfree:
 	goto out;
 }
 
-struct file_operations irlap_seq_fops = {
+const struct file_operations irlap_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open           = irlap_seq_open,
 	.read           = seq_read,
Index: linux-2.6/net/irda/irlmp.c
===================================================================
--- linux-2.6.orig/net/irda/irlmp.c
+++ linux-2.6/net/irda/irlmp.c
@@ -2026,7 +2026,7 @@ out_kfree:
 	goto out;
 }
 
-struct file_operations irlmp_seq_fops = {
+const struct file_operations irlmp_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open           = irlmp_seq_open,
 	.read           = seq_read,
Index: linux-2.6/net/irda/irttp.c
===================================================================
--- linux-2.6.orig/net/irda/irttp.c
+++ linux-2.6/net/irda/irttp.c
@@ -1895,7 +1895,7 @@ out_kfree:
 	goto out;
 }
 
-struct file_operations irttp_seq_fops = {
+const struct file_operations irttp_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open           = irttp_seq_open,
 	.read           = seq_read,
Index: linux-2.6/net/llc/llc_proc.c
===================================================================
--- linux-2.6.orig/net/llc/llc_proc.c
+++ linux-2.6/net/llc/llc_proc.c
@@ -208,7 +208,7 @@ static int llc_seq_core_open(struct inod
 	return seq_open(file, &llc_seq_core_ops);
 }
 
-static struct file_operations llc_seq_socket_fops = {
+static const struct file_operations llc_seq_socket_fops = {
 	.owner		= THIS_MODULE,
 	.open		= llc_seq_socket_open,
 	.read		= seq_read,
@@ -216,7 +216,7 @@ static struct file_operations llc_seq_so
 	.release	= seq_release,
 };
 
-static struct file_operations llc_seq_core_fops = {
+static const struct file_operations llc_seq_core_fops = {
 	.owner		= THIS_MODULE,
 	.open		= llc_seq_core_open,
 	.read		= seq_read,
Index: linux-2.6/net/netfilter/nf_conntrack_expect.c
===================================================================
--- linux-2.6.orig/net/netfilter/nf_conntrack_expect.c
+++ linux-2.6/net/netfilter/nf_conntrack_expect.c
@@ -435,7 +435,7 @@ static int exp_open(struct inode *inode,
 	return seq_open(file, &exp_seq_ops);
 }
 
-struct file_operations exp_file_ops = {
+const struct file_operations exp_file_ops = {
 	.owner   = THIS_MODULE,
 	.open    = exp_open,
 	.read    = seq_read,
Index: linux-2.6/net/netfilter/nf_conntrack_standalone.c
===================================================================
--- linux-2.6.orig/net/netfilter/nf_conntrack_standalone.c
+++ linux-2.6/net/netfilter/nf_conntrack_standalone.c
@@ -229,7 +229,7 @@ out_free:
 	return ret;
 }
 
-static struct file_operations ct_file_ops = {
+static const struct file_operations ct_file_ops = {
 	.owner   = THIS_MODULE,
 	.open    = ct_open,
 	.read    = seq_read,
@@ -317,7 +317,7 @@ static int ct_cpu_seq_open(struct inode 
 	return seq_open(file, &ct_cpu_seq_ops);
 }
 
-static struct file_operations ct_cpu_seq_fops = {
+static const struct file_operations ct_cpu_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = ct_cpu_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/net/netfilter/nf_log.c
===================================================================
--- linux-2.6.orig/net/netfilter/nf_log.c
+++ linux-2.6/net/netfilter/nf_log.c
@@ -151,7 +151,7 @@ static int nflog_open(struct inode *inod
 	return seq_open(file, &nflog_seq_ops);
 }
 
-static struct file_operations nflog_file_ops = {
+static const struct file_operations nflog_file_ops = {
 	.owner	 = THIS_MODULE,
 	.open	 = nflog_open,
 	.read	 = seq_read,
Index: linux-2.6/net/netfilter/nfnetlink_log.c
===================================================================
--- linux-2.6.orig/net/netfilter/nfnetlink_log.c
+++ linux-2.6/net/netfilter/nfnetlink_log.c
@@ -1025,7 +1025,7 @@ out_free:
 	return ret;
 }
 
-static struct file_operations nful_file_ops = {
+static const struct file_operations nful_file_ops = {
 	.owner	 = THIS_MODULE,
 	.open	 = nful_open,
 	.read	 = seq_read,
Index: linux-2.6/net/netfilter/nfnetlink_queue.c
===================================================================
--- linux-2.6.orig/net/netfilter/nfnetlink_queue.c
+++ linux-2.6/net/netfilter/nfnetlink_queue.c
@@ -1077,7 +1077,7 @@ out_free:
 	return ret;
 }
 
-static struct file_operations nfqnl_file_ops = {
+static const struct file_operations nfqnl_file_ops = {
 	.owner	 = THIS_MODULE,
 	.open	 = nfqnl_open,
 	.read	 = seq_read,
Index: linux-2.6/net/netfilter/nf_queue.c
===================================================================
--- linux-2.6.orig/net/netfilter/nf_queue.c
+++ linux-2.6/net/netfilter/nf_queue.c
@@ -331,7 +331,7 @@ static int nfqueue_open(struct inode *in
 	return seq_open(file, &nfqueue_seq_ops);
 }
 
-static struct file_operations nfqueue_file_ops = {
+static const struct file_operations nfqueue_file_ops = {
 	.owner	 = THIS_MODULE,
 	.open	 = nfqueue_open,
 	.read	 = seq_read,
Index: linux-2.6/net/netfilter/x_tables.c
===================================================================
--- linux-2.6.orig/net/netfilter/x_tables.c
+++ linux-2.6/net/netfilter/x_tables.c
@@ -772,7 +772,7 @@ static int xt_tgt_open(struct inode *ino
 	return ret;
 }
 
-static struct file_operations xt_file_ops = {
+static const struct file_operations xt_file_ops = {
 	.owner	 = THIS_MODULE,
 	.open	 = xt_tgt_open,
 	.read	 = seq_read,
Index: linux-2.6/net/netfilter/xt_hashlimit.c
===================================================================
--- linux-2.6.orig/net/netfilter/xt_hashlimit.c
+++ linux-2.6/net/netfilter/xt_hashlimit.c
@@ -37,7 +37,7 @@ MODULE_ALIAS("ip6t_hashlimit");
 /* need to declare this at the top */
 static struct proc_dir_entry *hashlimit_procdir4;
 static struct proc_dir_entry *hashlimit_procdir6;
-static struct file_operations dl_file_ops;
+static const struct file_operations dl_file_ops;
 
 /* hash table crap */
 struct dsthash_dst {
@@ -713,7 +713,7 @@ static int dl_proc_open(struct inode *in
 	return ret;
 }
 
-static struct file_operations dl_file_ops = {
+static const struct file_operations dl_file_ops = {
 	.owner   = THIS_MODULE,
 	.open    = dl_proc_open,
 	.read    = seq_read,
Index: linux-2.6/net/netlink/af_netlink.c
===================================================================
--- linux-2.6.orig/net/netlink/af_netlink.c
+++ linux-2.6/net/netlink/af_netlink.c
@@ -1713,7 +1713,7 @@ static int netlink_seq_open(struct inode
 	return 0;
 }
 
-static struct file_operations netlink_seq_fops = {
+static const struct file_operations netlink_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= netlink_seq_open,
 	.read		= seq_read,
Index: linux-2.6/net/netrom/af_netrom.c
===================================================================
--- linux-2.6.orig/net/netrom/af_netrom.c
+++ linux-2.6/net/netrom/af_netrom.c
@@ -1335,7 +1335,7 @@ static int nr_info_open(struct inode *in
 	return seq_open(file, &nr_info_seqops);
 }
  
-static struct file_operations nr_info_fops = {
+static const struct file_operations nr_info_fops = {
 	.owner = THIS_MODULE,
 	.open = nr_info_open,
 	.read = seq_read,
Index: linux-2.6/net/netrom/nr_route.c
===================================================================
--- linux-2.6.orig/net/netrom/nr_route.c
+++ linux-2.6/net/netrom/nr_route.c
@@ -934,7 +934,7 @@ static int nr_node_info_open(struct inod
 	return seq_open(file, &nr_node_seqops);
 }
 
-struct file_operations nr_nodes_fops = {
+const struct file_operations nr_nodes_fops = {
 	.owner = THIS_MODULE,
 	.open = nr_node_info_open,
 	.read = seq_read,
@@ -1018,7 +1018,7 @@ static int nr_neigh_info_open(struct ino
 	return seq_open(file, &nr_neigh_seqops);
 }
 
-struct file_operations nr_neigh_fops = {
+const struct file_operations nr_neigh_fops = {
 	.owner = THIS_MODULE,
 	.open = nr_neigh_info_open,
 	.read = seq_read,
Index: linux-2.6/net/packet/af_packet.c
===================================================================
--- linux-2.6.orig/net/packet/af_packet.c
+++ linux-2.6/net/packet/af_packet.c
@@ -1899,7 +1899,7 @@ static int packet_seq_open(struct inode 
 	return seq_open(file, &packet_seq_ops);
 }
 
-static struct file_operations packet_seq_fops = {
+static const struct file_operations packet_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= packet_seq_open,
 	.read		= seq_read,
Index: linux-2.6/net/rose/af_rose.c
===================================================================
--- linux-2.6.orig/net/rose/af_rose.c
+++ linux-2.6/net/rose/af_rose.c
@@ -1440,7 +1440,7 @@ static int rose_info_open(struct inode *
 	return seq_open(file, &rose_info_seqops);
 }
 
-static struct file_operations rose_info_fops = {
+static const struct file_operations rose_info_fops = {
 	.owner = THIS_MODULE,
 	.open = rose_info_open,
 	.read = seq_read,
Index: linux-2.6/net/rose/rose_route.c
===================================================================
--- linux-2.6.orig/net/rose/rose_route.c
+++ linux-2.6/net/rose/rose_route.c
@@ -1129,7 +1129,7 @@ static int rose_nodes_open(struct inode 
 	return seq_open(file, &rose_node_seqops);
 }
 
-struct file_operations rose_nodes_fops = {
+const struct file_operations rose_nodes_fops = {
 	.owner = THIS_MODULE,
 	.open = rose_nodes_open,
 	.read = seq_read,
@@ -1211,7 +1211,7 @@ static int rose_neigh_open(struct inode 
 	return seq_open(file, &rose_neigh_seqops);
 }
 
-struct file_operations rose_neigh_fops = {
+const struct file_operations rose_neigh_fops = {
 	.owner = THIS_MODULE,
 	.open = rose_neigh_open,
 	.read = seq_read,
@@ -1295,7 +1295,7 @@ static int rose_route_open(struct inode 
 	return seq_open(file, &rose_route_seqops);
 }
 
-struct file_operations rose_routes_fops = {
+const struct file_operations rose_routes_fops = {
 	.owner = THIS_MODULE,
 	.open = rose_route_open,
 	.read = seq_read,
Index: linux-2.6/net/rxrpc/proc.c
===================================================================
--- linux-2.6.orig/net/rxrpc/proc.c
+++ linux-2.6/net/rxrpc/proc.c
@@ -37,7 +37,7 @@ static struct seq_operations rxrpc_proc_
 	.show	= rxrpc_proc_transports_show,
 };
 
-static struct file_operations rxrpc_proc_transports_fops = {
+static const struct file_operations rxrpc_proc_transports_fops = {
 	.open		= rxrpc_proc_transports_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -57,7 +57,7 @@ static struct seq_operations rxrpc_proc_
 	.show	= rxrpc_proc_peers_show,
 };
 
-static struct file_operations rxrpc_proc_peers_fops = {
+static const struct file_operations rxrpc_proc_peers_fops = {
 	.open		= rxrpc_proc_peers_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -77,7 +77,7 @@ static struct seq_operations rxrpc_proc_
 	.show	= rxrpc_proc_conns_show,
 };
 
-static struct file_operations rxrpc_proc_conns_fops = {
+static const struct file_operations rxrpc_proc_conns_fops = {
 	.open		= rxrpc_proc_conns_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -97,7 +97,7 @@ static struct seq_operations rxrpc_proc_
 	.show	= rxrpc_proc_calls_show,
 };
 
-static struct file_operations rxrpc_proc_calls_fops = {
+static const struct file_operations rxrpc_proc_calls_fops = {
 	.open		= rxrpc_proc_calls_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/net/sched/sch_api.c
===================================================================
--- linux-2.6.orig/net/sched/sch_api.c
+++ linux-2.6/net/sched/sch_api.c
@@ -1194,7 +1194,7 @@ static int psched_open(struct inode *ino
 	return single_open(file, psched_show, PDE(inode)->data);
 }
 
-static struct file_operations psched_fops = {
+static const struct file_operations psched_fops = {
 	.owner = THIS_MODULE,
 	.open = psched_open,
 	.read  = seq_read,
Index: linux-2.6/net/sctp/proc.c
===================================================================
--- linux-2.6.orig/net/sctp/proc.c
+++ linux-2.6/net/sctp/proc.c
@@ -114,7 +114,7 @@ static int sctp_snmp_seq_open(struct ino
 	return single_open(file, sctp_snmp_seq_show, NULL);
 }
 
-static struct file_operations sctp_snmp_seq_fops = {
+static const struct file_operations sctp_snmp_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = sctp_snmp_seq_open,
 	.read	 = seq_read,
@@ -264,7 +264,7 @@ static int sctp_eps_seq_open(struct inod
 	return seq_open(file, &sctp_eps_ops);
 }
 
-static struct file_operations sctp_eps_seq_fops = {
+static const struct file_operations sctp_eps_seq_fops = {
 	.open	 = sctp_eps_seq_open,
 	.read	 = seq_read,
 	.llseek	 = seq_lseek,
@@ -374,7 +374,7 @@ static int sctp_assocs_seq_open(struct i
 	return seq_open(file, &sctp_assoc_ops);
 }
 
-static struct file_operations sctp_assocs_seq_fops = {
+static const struct file_operations sctp_assocs_seq_fops = {
 	.open	 = sctp_assocs_seq_open,
 	.read	 = seq_read,
 	.llseek	 = seq_lseek,
Index: linux-2.6/net/socket.c
===================================================================
--- linux-2.6.orig/net/socket.c
+++ linux-2.6/net/socket.c
@@ -117,7 +117,7 @@ static ssize_t sock_sendpage(struct file
  *	in the operation structures but are done directly via the socketcall() multiplexor.
  */
 
-static struct file_operations socket_file_ops = {
+static const struct file_operations socket_file_ops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.aio_read =	sock_aio_read,
Index: linux-2.6/net/sunrpc/cache.c
===================================================================
--- linux-2.6.orig/net/sunrpc/cache.c
+++ linux-2.6/net/sunrpc/cache.c
@@ -282,9 +282,9 @@ static DEFINE_SPINLOCK(cache_list_lock);
 static struct cache_detail *current_detail;
 static int current_index;
 
-static struct file_operations cache_file_operations;
-static struct file_operations content_file_operations;
-static struct file_operations cache_flush_operations;
+static const struct file_operations cache_file_operations;
+static const struct file_operations content_file_operations;
+static const struct file_operations cache_flush_operations;
 
 static void do_cache_clean(struct work_struct *work);
 static DECLARE_DELAYED_WORK(cache_cleaner, do_cache_clean);
@@ -887,7 +887,7 @@ cache_release(struct inode *inode, struc
 
 
 
-static struct file_operations cache_file_operations = {
+static const struct file_operations cache_file_operations = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= cache_read,
@@ -1245,7 +1245,7 @@ static int content_release(struct inode 
 	return seq_release(inode, file);
 }
 
-static struct file_operations content_file_operations = {
+static const struct file_operations content_file_operations = {
 	.open		= content_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -1297,7 +1297,7 @@ static ssize_t write_flush(struct file *
 	return count;
 }
 
-static struct file_operations cache_flush_operations = {
+static const struct file_operations cache_flush_operations = {
 	.open		= nonseekable_open,
 	.read		= read_flush,
 	.write		= write_flush,
Index: linux-2.6/net/sunrpc/rpc_pipe.c
===================================================================
--- linux-2.6.orig/net/sunrpc/rpc_pipe.c
+++ linux-2.6/net/sunrpc/rpc_pipe.c
@@ -309,7 +309,7 @@ rpc_pipe_ioctl(struct inode *ino, struct
 	}
 }
 
-static struct file_operations rpc_pipe_fops = {
+static const struct file_operations rpc_pipe_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= rpc_pipe_read,
@@ -366,7 +366,7 @@ rpc_info_release(struct inode *inode, st
 	return single_release(inode, file);
 }
 
-static struct file_operations rpc_info_operations = {
+static const struct file_operations rpc_info_operations = {
 	.owner		= THIS_MODULE,
 	.open		= rpc_info_open,
 	.read		= seq_read,
Index: linux-2.6/net/sunrpc/stats.c
===================================================================
--- linux-2.6.orig/net/sunrpc/stats.c
+++ linux-2.6/net/sunrpc/stats.c
@@ -66,7 +66,7 @@ static int rpc_proc_open(struct inode *i
 	return single_open(file, rpc_proc_show, PDE(inode)->data);
 }
 
-static struct file_operations rpc_proc_fops = {
+static const struct file_operations rpc_proc_fops = {
 	.owner = THIS_MODULE,
 	.open = rpc_proc_open,
 	.read  = seq_read,
Index: linux-2.6/net/unix/af_unix.c
===================================================================
--- linux-2.6.orig/net/unix/af_unix.c
+++ linux-2.6/net/unix/af_unix.c
@@ -2040,7 +2040,7 @@ out_kfree:
 	goto out;
 }
 
-static struct file_operations unix_seq_fops = {
+static const struct file_operations unix_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= unix_seq_open,
 	.read		= seq_read,
Index: linux-2.6/net/wanrouter/wanproc.c
===================================================================
--- linux-2.6.orig/net/wanrouter/wanproc.c
+++ linux-2.6/net/wanrouter/wanproc.c
@@ -188,7 +188,7 @@ static int status_open(struct inode *ino
 	return seq_open(file, &status_op);
 }
 
-static struct file_operations config_fops = {
+static const struct file_operations config_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = config_open,
 	.read	 = seq_read,
@@ -196,7 +196,7 @@ static struct file_operations config_fop
 	.release = seq_release,
 };
 
-static struct file_operations status_fops = {
+static const struct file_operations status_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = status_open,
 	.read	 = seq_read,
@@ -271,7 +271,7 @@ static int wandev_open(struct inode *ino
 	return single_open(file, wandev_show, PDE(inode)->data);
 }
 
-static struct file_operations wandev_fops = {
+static const struct file_operations wandev_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = wandev_open,
 	.read	 = seq_read,
Index: linux-2.6/net/x25/x25_proc.c
===================================================================
--- linux-2.6.orig/net/x25/x25_proc.c
+++ linux-2.6/net/x25/x25_proc.c
@@ -189,7 +189,7 @@ static int x25_seq_route_open(struct ino
 	return seq_open(file, &x25_seq_route_ops);
 }
 
-static struct file_operations x25_seq_socket_fops = {
+static const struct file_operations x25_seq_socket_fops = {
 	.owner		= THIS_MODULE,
 	.open		= x25_seq_socket_open,
 	.read		= seq_read,
@@ -197,7 +197,7 @@ static struct file_operations x25_seq_so
 	.release	= seq_release,
 };
 
-static struct file_operations x25_seq_route_fops = {
+static const struct file_operations x25_seq_route_fops = {
 	.owner		= THIS_MODULE,
 	.open		= x25_seq_route_open,
 	.read		= seq_read,


