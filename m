Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTIBIU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbTIBITP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:19:15 -0400
Received: from dp.samba.org ([66.70.73.150]:5014 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263631AbTIBISa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:18:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MODULE_ALIAS() in network families
Date: Tue, 02 Sep 2003 18:18:05 +1000
Message-Id: <20030902081828.E8E8A2C0D2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: MODULE_ALIAS inside modules: network protocols
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk3

D: Previously, default aliases were hardwired into modutils.  Now they
D: should be inside the modules, using MODULE_ALIAS() (they will be overridden
D: by any user alias).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/include/linux/net.h .305-linux-2.6.0-test4-bk3.updated/include/linux/net.h
--- .305-linux-2.6.0-test4-bk3/include/linux/net.h	2003-05-27 15:02:21.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/include/linux/net.h	2003-09-02 18:10:34.000000000 +1000
@@ -20,6 +20,7 @@
 
 #include <linux/config.h>
 #include <linux/wait.h>
+#include <linux/stringify.h>
 
 struct poll_table_struct;
 struct inode;
@@ -243,6 +244,8 @@ static struct proto_ops name##_ops = {		
 };
 #endif
 
+#define MODULE_ALIAS_NETPROTO(proto) \
+	MODULE_ALIAS("net-pf-" __stringify(proto))
 
 #endif /* __KERNEL__ */
 #endif	/* _LINUX_NET_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/appletalk/ddp.c .305-linux-2.6.0-test4-bk3.updated/net/appletalk/ddp.c
--- .305-linux-2.6.0-test4-bk3/net/appletalk/ddp.c	2003-06-17 16:57:33.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/appletalk/ddp.c	2003-09-02 18:10:07.000000000 +1000
@@ -1876,3 +1876,4 @@ module_exit(atalk_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alan Cox <Alan.Cox@linux.org>");
 MODULE_DESCRIPTION("AppleTalk 0.20 for Linux NET4.0\n");
+MODULE_ALIAS_NETPROTO(PF_APPLETALK);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/atm/common.c .305-linux-2.6.0-test4-bk3.updated/net/atm/common.c
--- .305-linux-2.6.0-test4-bk3/net/atm/common.c	2003-08-25 11:58:36.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/atm/common.c	2003-09-02 18:10:07.000000000 +1000
@@ -1135,3 +1135,5 @@ module_init(atm_init);
 module_exit(atm_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_ATMPVC);
+MODULE_ALIAS_NETPROTO(PF_ATMSVC);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/ax25/af_ax25.c .305-linux-2.6.0-test4-bk3.updated/net/ax25/af_ax25.c
--- .305-linux-2.6.0-test4-bk3/net/ax25/af_ax25.c	2003-08-25 11:58:36.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/ax25/af_ax25.c	2003-09-02 18:10:07.000000000 +1000
@@ -1999,6 +1999,7 @@ module_init(ax25_init);
 MODULE_AUTHOR("Jonathan Naylor G4KLX <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The amateur radio AX.25 link layer protocol");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_AX25);
 
 static void __exit ax25_exit(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/bluetooth/bnep/core.c .305-linux-2.6.0-test4-bk3.updated/net/bluetooth/bnep/core.c
--- .305-linux-2.6.0-test4-bk3/net/bluetooth/bnep/core.c	2003-06-15 11:30:12.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/bluetooth/bnep/core.c	2003-09-02 18:10:07.000000000 +1000
@@ -711,3 +711,4 @@ module_exit(bnep_cleanup_module);
 MODULE_DESCRIPTION("Bluetooth BNEP ver " VERSION);
 MODULE_AUTHOR("David Libault <david.libault@inventel.fr>, Maxim Krasnyanskiy <maxk@qualcomm.com>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_PROTO(PF_BLUETOOTH);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/decnet/af_decnet.c .305-linux-2.6.0-test4-bk3.updated/net/decnet/af_decnet.c
--- .305-linux-2.6.0-test4-bk3/net/decnet/af_decnet.c	2003-07-31 01:50:20.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/decnet/af_decnet.c	2003-09-02 18:10:07.000000000 +1000
@@ -2349,6 +2349,7 @@ void dn_unregister_sysctl(void);
 MODULE_DESCRIPTION("The Linux DECnet Network Protocol");
 MODULE_AUTHOR("Linux DECnet Project Team");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_DECnet);
 
 static char banner[] __initdata = KERN_INFO "NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team\n";
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/econet/af_econet.c .305-linux-2.6.0-test4-bk3.updated/net/econet/af_econet.c
--- .305-linux-2.6.0-test4-bk3/net/econet/af_econet.c	2003-06-23 10:52:59.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/econet/af_econet.c	2003-09-02 18:10:07.000000000 +1000
@@ -1115,3 +1115,4 @@ module_init(econet_proto_init);
 module_exit(econet_proto_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_ECONET);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/ipv4/af_inet.c .305-linux-2.6.0-test4-bk3.updated/net/ipv4/af_inet.c
--- .305-linux-2.6.0-test4-bk3/net/ipv4/af_inet.c	2003-08-12 06:58:07.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/ipv4/af_inet.c	2003-09-02 18:10:07.000000000 +1000
@@ -1248,3 +1248,4 @@ int __init ipv4_proc_init(void)
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
+MODULE_ALIAS_NETPROTO(PF_INET);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/ipv6/af_inet6.c .305-linux-2.6.0-test4-bk3.updated/net/ipv6/af_inet6.c
--- .305-linux-2.6.0-test4-bk3/net/ipv6/af_inet6.c	2003-08-12 06:58:07.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/ipv6/af_inet6.c	2003-09-02 18:10:07.000000000 +1000
@@ -893,3 +893,5 @@ static void inet6_exit(void)
 }
 module_exit(inet6_exit);
 #endif /* MODULE */
+
+MODULE_ALIAS_NETPROTO(PF_INET6);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/ipx/af_ipx.c .305-linux-2.6.0-test4-bk3.updated/net/ipx/af_ipx.c
--- .305-linux-2.6.0-test4-bk3/net/ipx/af_ipx.c	2003-06-23 10:53:00.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/ipx/af_ipx.c	2003-09-02 18:10:07.000000000 +1000
@@ -2020,3 +2020,4 @@ static void __exit ipx_proto_finito(void
 module_init(ipx_init);
 module_exit(ipx_proto_finito);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_IPX);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/irda/irsyms.c .305-linux-2.6.0-test4-bk3.updated/net/irda/irsyms.c
--- .305-linux-2.6.0-test4-bk3/net/irda/irsyms.c	2003-05-27 15:02:28.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/irda/irsyms.c	2003-09-02 18:10:07.000000000 +1000
@@ -351,3 +351,4 @@ MODULE_LICENSE("GPL");
 #ifdef CONFIG_IRDA_DEBUG
 MODULE_PARM(irda_debug, "1l");
 #endif
+MODULE_ALIAS_NETPROTO(PF_IRDA);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/key/af_key.c .305-linux-2.6.0-test4-bk3.updated/net/key/af_key.c
--- .305-linux-2.6.0-test4-bk3/net/key/af_key.c	2003-08-12 06:58:08.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/key/af_key.c	2003-09-02 18:10:07.000000000 +1000
@@ -2844,3 +2844,4 @@ static int __init ipsec_pfkey_init(void)
 module_init(ipsec_pfkey_init);
 module_exit(ipsec_pfkey_exit);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_KEY);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/llc/llc_main.c .305-linux-2.6.0-test4-bk3.updated/net/llc/llc_main.c
--- .305-linux-2.6.0-test4-bk3/net/llc/llc_main.c	2003-06-17 16:57:33.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/llc/llc_main.c	2003-09-02 18:10:07.000000000 +1000
@@ -603,3 +603,4 @@ module_exit(llc_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Procom, 1997, Arnaldo C. Melo, Jay Schullist, 2001-2003");
 MODULE_DESCRIPTION("LLC 2.0, NET4.0 IEEE 802.2 extended support");
+MODULE_ALIAS_NETPROTO(PF_LLC);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/netlink/af_netlink.c .305-linux-2.6.0-test4-bk3.updated/net/netlink/af_netlink.c
--- .305-linux-2.6.0-test4-bk3/net/netlink/af_netlink.c	2003-07-14 16:58:39.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/netlink/af_netlink.c	2003-09-02 18:10:07.000000000 +1000
@@ -1086,3 +1086,4 @@ core_initcall(netlink_proto_init);
 module_exit(netlink_proto_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_NETLINK);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/netrom/af_netrom.c .305-linux-2.6.0-test4-bk3.updated/net/netrom/af_netrom.c
--- .305-linux-2.6.0-test4-bk3/net/netrom/af_netrom.c	2003-08-25 11:58:37.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/netrom/af_netrom.c	2003-09-02 18:10:07.000000000 +1000
@@ -1458,6 +1458,7 @@ MODULE_PARM_DESC(nr_ndevs, "number of NE
 MODULE_AUTHOR("Jonathan Naylor G4KLX <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The amateur radio NET/ROM network and transport layer protocol");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_NETROM);
 
 static void __exit nr_exit(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/packet/af_packet.c .305-linux-2.6.0-test4-bk3.updated/net/packet/af_packet.c
--- .305-linux-2.6.0-test4-bk3/net/packet/af_packet.c	2003-07-11 09:54:51.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/packet/af_packet.c	2003-09-02 18:10:07.000000000 +1000
@@ -1832,3 +1832,4 @@ static int __init packet_init(void)
 module_init(packet_init);
 module_exit(packet_exit);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_PACKET);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/rose/af_rose.c .305-linux-2.6.0-test4-bk3.updated/net/rose/af_rose.c
--- .305-linux-2.6.0-test4-bk3/net/rose/af_rose.c	2003-08-25 11:58:37.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/rose/af_rose.c	2003-09-02 18:10:07.000000000 +1000
@@ -1549,6 +1549,7 @@ MODULE_PARM_DESC(rose_ndevs, "number of 
 MODULE_AUTHOR("Jonathan Naylor G4KLX <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The amateur radio ROSE network layer protocol");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_ROSE);
 
 static void __exit rose_exit(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/unix/af_unix.c .305-linux-2.6.0-test4-bk3.updated/net/unix/af_unix.c
--- .305-linux-2.6.0-test4-bk3/net/unix/af_unix.c	2003-07-11 09:54:51.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/unix/af_unix.c	2003-09-02 18:10:07.000000000 +1000
@@ -1965,3 +1965,4 @@ module_init(af_unix_init);
 module_exit(af_unix_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_UNIX);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/wanrouter/af_wanpipe.c .305-linux-2.6.0-test4-bk3.updated/net/wanrouter/af_wanpipe.c
--- .305-linux-2.6.0-test4-bk3/net/wanrouter/af_wanpipe.c	2003-06-23 10:53:00.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/wanrouter/af_wanpipe.c	2003-09-02 18:10:07.000000000 +1000
@@ -2600,3 +2600,4 @@ int init_module(void)
 }
 #endif
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_WANPIPE);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .305-linux-2.6.0-test4-bk3/net/x25/af_x25.c .305-linux-2.6.0-test4-bk3.updated/net/x25/af_x25.c
--- .305-linux-2.6.0-test4-bk3/net/x25/af_x25.c	2003-08-12 06:58:08.000000000 +1000
+++ .305-linux-2.6.0-test4-bk3.updated/net/x25/af_x25.c	2003-09-02 18:10:07.000000000 +1000
@@ -1421,3 +1421,4 @@ module_exit(x25_exit);
 MODULE_AUTHOR("Jonathan Naylor <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The X.25 Packet Layer network layer protocol");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_X25);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
