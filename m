Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265426AbUGDG66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbUGDG66 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUGDG66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:58:58 -0400
Received: from ozlabs.org ([203.10.76.45]:50566 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265426AbUGDG6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:58:53 -0400
Date: Sun, 4 Jul 2004 16:58:12 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] gcc 3.5 fixes
Message-ID: <20040704065811.GA4923@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc 3.5 is warning about static vs non static function declarations. The
following patch removes function prototypes in .h files where possible
and changes prototypes to be static elsewhere.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -ur /root/toolchain/linux-2.5-bk/drivers/net/pppoe.c linux-2.5-bk/drivers/net/pppoe.c
--- /root/toolchain/linux-2.5-bk/drivers/net/pppoe.c	2004-06-25 09:13:14.000000000 +0000
+++ linux-2.5-bk/drivers/net/pppoe.c	2004-07-03 11:20:06.780997728 +0000
@@ -86,6 +86,7 @@
 static struct proto_ops pppoe_ops;
 static rwlock_t pppoe_hash_lock = RW_LOCK_UNLOCKED;
 
+static struct ppp_channel_ops pppoe_chan_ops;
 
 static inline int cmp_2_addr(struct pppoe_addr *a, struct pppoe_addr *b)
 {
diff -ur /root/toolchain/linux-2.5-bk/drivers/serial/8250.c linux-2.5-bk/drivers/serial/8250.c
--- /root/toolchain/linux-2.5-bk/drivers/serial/8250.c	2004-04-20 02:56:09.000000000 +0000
+++ linux-2.5-bk/drivers/serial/8250.c	2004-07-03 11:23:07.247987240 +0000
@@ -2013,7 +2013,7 @@
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-extern struct uart_driver serial8250_reg;
+static struct uart_driver serial8250_reg;
 static struct console serial8250_console = {
 	.name		= "ttyS",
 	.write		= serial8250_console_write,
diff -ur /root/toolchain/linux-2.5-bk/drivers/usb/input/hiddev.c linux-2.5-bk/drivers/usb/input/hiddev.c
--- /root/toolchain/linux-2.5-bk/drivers/usb/input/hiddev.c	2004-06-19 05:48:19.000000000 +0000
+++ linux-2.5-bk/drivers/usb/input/hiddev.c	2004-07-03 11:22:28.699984216 +0000
@@ -66,9 +66,6 @@
 
 static struct hiddev *hiddev_table[HIDDEV_MINORS];
 
-/* forward reference to make our lives easier */
-extern struct usb_driver hiddev_driver;
-
 /*
  * Find a report, given the report's type and ID.  The ID can be specified
  * indirectly by REPORT_ID_FIRST (which returns the first report of the given
diff -ur /root/toolchain/linux-2.5-bk/fs/cifs/cifsfs.c linux-2.5-bk/fs/cifs/cifsfs.c
--- /root/toolchain/linux-2.5-bk/fs/cifs/cifsfs.c	2004-06-16 06:27:55.000000000 +0000
+++ linux-2.5-bk/fs/cifs/cifsfs.c	2004-07-03 11:04:41.790902048 +0000
@@ -48,8 +48,6 @@
 static struct quotactl_ops cifs_quotactl_ops;
 #endif
 
-extern struct file_system_type cifs_fs_type;
-
 int cifsFYI = 0;
 int cifsERROR = 1;
 int traceSMB = 0;
diff -ur /root/toolchain/linux-2.5-bk/include/linux/idr.h linux-2.5-bk/include/linux/idr.h
--- /root/toolchain/linux-2.5-bk/include/linux/idr.h	2004-06-21 13:50:10.000000000 +0000
+++ linux-2.5-bk/include/linux/idr.h	2004-07-03 11:16:54.561931696 +0000
@@ -76,5 +76,3 @@
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
 void idr_remove(struct idr *idp, int id);
 void idr_init(struct idr *idp);
-
-extern kmem_cache_t *idr_layer_cache;
diff -ur /root/toolchain/linux-2.5-bk/include/linux/if_pppox.h linux-2.5-bk/include/linux/if_pppox.h
--- /root/toolchain/linux-2.5-bk/include/linux/if_pppox.h	2004-02-22 13:48:05.000000000 +0000
+++ linux-2.5-bk/include/linux/if_pppox.h	2004-07-03 11:20:12.454966584 +0000
@@ -159,8 +159,6 @@
     PPPOX_DEAD		= 16  /* dead, useless, please clean me up!*/
 };
 
-extern struct ppp_channel_ops pppoe_chan_ops;
-
 #endif /* __KERNEL__ */
 
 #endif /* !(__LINUX_IF_PPPOX_H) */
diff -ur /root/toolchain/linux-2.5-bk/include/linux/netfilter_ipv4/ip_tables.h linux-2.5-bk/include/linux/netfilter_ipv4/ip_tables.h
--- /root/toolchain/linux-2.5-bk/include/linux/netfilter_ipv4/ip_tables.h	2004-06-21 13:50:10.000000000 +0000
+++ linux-2.5-bk/include/linux/netfilter_ipv4/ip_tables.h	2004-07-03 11:18:47.644908672 +0000
@@ -284,8 +284,6 @@
 	struct ipt_entry entrytable[0];
 };
 
-extern struct semaphore ipt_mutex;
-
 /* Standard return verdict, or do jump. */
 #define IPT_STANDARD_TARGET ""
 /* Error verdict. */
diff -ur /root/toolchain/linux-2.5-bk/include/linux/sunrpc/svcauth.h linux-2.5-bk/include/linux/sunrpc/svcauth.h
--- /root/toolchain/linux-2.5-bk/include/linux/sunrpc/svcauth.h	2004-06-13 14:37:00.000000000 +0000
+++ linux-2.5-bk/include/linux/sunrpc/svcauth.h	2004-07-03 11:27:44.772992792 +0000
@@ -93,7 +93,6 @@
 	int	(*release)(struct svc_rqst *rq);
 	void	(*domain_release)(struct auth_domain *);
 };
-extern struct auth_ops	*authtab[RPC_AUTH_MAXFLAVOR];
 
 #define	SVC_GARBAGE	1
 #define	SVC_SYSERR	2
diff -ur /root/toolchain/linux-2.5-bk/net/ipv4/xfrm4_state.c linux-2.5-bk/net/ipv4/xfrm4_state.c
--- /root/toolchain/linux-2.5-bk/net/ipv4/xfrm4_state.c	2004-05-26 04:15:19.000000000 +0000
+++ linux-2.5-bk/net/ipv4/xfrm4_state.c	2004-07-03 11:21:27.492969016 +0000
@@ -11,7 +11,7 @@
 #include <linux/pfkeyv2.h>
 #include <linux/ipsec.h>
 
-extern struct xfrm_state_afinfo xfrm4_state_afinfo;
+static struct xfrm_state_afinfo xfrm4_state_afinfo;
 
 static void
 __xfrm4_init_tempsel(struct xfrm_state *x, struct flowi *fl,
diff -ur /root/toolchain/linux-2.5-bk/net/netlink/af_netlink.c linux-2.5-bk/net/netlink/af_netlink.c
--- /root/toolchain/linux-2.5-bk/net/netlink/af_netlink.c	2004-06-19 05:48:21.000000000 +0000
+++ linux-2.5-bk/net/netlink/af_netlink.c	2004-07-03 11:24:21.701977136 +0000
@@ -176,7 +176,7 @@
 	return sk;
 }
 
-extern struct proto_ops netlink_ops;
+static struct proto_ops netlink_ops;
 
 static int netlink_insert(struct sock *sk, u32 pid)
 {
