Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUHPCWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUHPCWB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267349AbUHPCWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:22:01 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:19172 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S267345AbUHPCUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:20:05 -0400
Subject: [PATCH] Remove MODULE_PARM from main part of kernel
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1092622748.29612.59.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 12:19:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Remove MODULE_PARM from main part of kernel
Status: Booted on 2.6.8-rc2-mm1
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Version: -mm

MODULE_PARM() was marked obsolete.  Remove it from everything except
drivers/ and arch/.

Naturally, such a widespread change may introduce bugs for some of the
non-trivial cases, and where in doubt I used "0" as permissions arg
(ie. won't appear in sysfs).  Individual authors should think about
whether that would be useful.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/crypto/tcrypt.c .16083-linux-2.6.8-rc4-mm1.updated/crypto/tcrypt.c
--- .16083-linux-2.6.8-rc4-mm1/crypto/tcrypt.c	2004-08-11 09:41:31.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/crypto/tcrypt.c	2004-08-16 12:14:24.000000000 +1000
@@ -24,6 +24,7 @@
 #include <linux/string.h>
 #include <linux/crypto.h>
 #include <linux/highmem.h>
+#include <linux/moduleparam.h>
 #include "tcrypt.h"
 
 /*
@@ -837,7 +838,7 @@ static void __exit fini(void) { }
 module_init(init);
 module_exit(fini);
 
-MODULE_PARM(mode, "i");
+module_param(mode, int, 0);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Quick & dirty crypto testing module");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/fs/afs/main.c .16083-linux-2.6.8-rc4-mm1.updated/fs/afs/main.c
--- .16083-linux-2.6.8-rc4-mm1/fs/afs/main.c	2004-08-11 09:43:23.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/fs/afs/main.c	2004-08-16 12:14:24.000000000 +1000
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
@@ -47,7 +48,7 @@ MODULE_LICENSE("GPL");
 
 static char *rootcell;
 
-MODULE_PARM(rootcell, "s");
+module_param(rootcell, charp, 0);
 MODULE_PARM_DESC(rootcell, "root AFS cell name and VL server IP addr list");
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/fs/ntfs/super.c .16083-linux-2.6.8-rc4-mm1.updated/fs/ntfs/super.c
--- .16083-linux-2.6.8-rc4-mm1/fs/ntfs/super.c	2004-08-11 09:43:25.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/fs/ntfs/super.c	2004-08-16 12:14:24.000000000 +1000
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
+#include <linux/moduleparam.h>
 
 #include "ntfs.h"
 #include "sysctl.h"
@@ -2585,7 +2586,7 @@ MODULE_AUTHOR("Anton Altaparmakov <aia21
 MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2004 Anton Altaparmakov");
 MODULE_LICENSE("GPL");
 #ifdef DEBUG
-MODULE_PARM(debug_msgs, "i");
+module_param(debug_msgs, bool, 0);
 MODULE_PARM_DESC(debug_msgs, "Enable debug messages.");
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/bridge/netfilter/ebt_vlan.c .16083-linux-2.6.8-rc4-mm1.updated/net/bridge/netfilter/ebt_vlan.c
--- .16083-linux-2.6.8-rc4-mm1/net/bridge/netfilter/ebt_vlan.c	2004-03-12 07:57:29.000000000 +1100
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/bridge/netfilter/ebt_vlan.c	2004-08-16 12:14:24.000000000 +1000
@@ -24,10 +24,10 @@
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_vlan.h>
 
-static unsigned char debug;
+static int debug;
 #define MODULE_VERS "0.6"
 
-MODULE_PARM(debug, "0-1b");
+module_param(debug, bool, 0600);
 MODULE_PARM_DESC(debug, "debug=1 is turn on debug messages");
 MODULE_AUTHOR("Nick Fedchik <nick@fedchik.org.ua>");
 MODULE_DESCRIPTION("802.1Q match module (ebtables extension), v"
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_amanda.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_amanda.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-08-16 12:14:24.000000000 +1000
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/netfilter.h>
 #include <linux/ip.h>
+#include <linux/moduleparam.h>
 #include <net/checksum.h>
 #include <net/udp.h>
 
@@ -34,7 +35,7 @@ static unsigned int master_timeout = 300
 MODULE_AUTHOR("Brian J. Murrell <netfilter@interlinx.bc.ca>");
 MODULE_DESCRIPTION("Amanda connection tracking module");
 MODULE_LICENSE("GPL");
-MODULE_PARM(master_timeout, "i");
+module_param(master_timeout, uint, 0);
 MODULE_PARM_DESC(master_timeout, "timeout for the master connection");
 
 static char *conns[] = { "DATA ", "MESG ", "INDEX " };
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_core.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_core.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_core.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_core.c	2004-08-16 12:14:24.000000000 +1000
@@ -34,8 +34,8 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/jhash.h>
-/* For ERR_PTR().  Yeah, I know... --RR */
-#include <linux/fs.h>
+#include <linux/moduleparam.h>
+#include <linux/err.h>
 
 /* This rwlock protects the main hash table, protocol/helper/expected
    registrations, conntrack timers*/
@@ -1373,7 +1373,7 @@ void ip_conntrack_cleanup(void)
 }
 
 static int hashsize;
-MODULE_PARM(hashsize, "i");
+module_param(hashsize, int, 0);
 
 int __init ip_conntrack_init(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_ftp.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_ftp.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_ftp.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_ftp.c	2004-08-16 12:14:24.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/netfilter.h>
 #include <linux/ip.h>
 #include <linux/ctype.h>
+#include <linux/moduleparam.h>
 #include <net/checksum.h>
 #include <net/tcp.h>
 
@@ -31,12 +32,12 @@ DECLARE_LOCK(ip_ftp_lock);
 struct module *ip_conntrack_ftp = THIS_MODULE;
 
 #define MAX_PORTS 8
-static int ports[MAX_PORTS];
-static int ports_c;
-MODULE_PARM(ports, "1-" __MODULE_STRING(MAX_PORTS) "i");
+static int ports[MAX_PORTS] = { FTP_PORT };
+static int ports_c = 1;
+module_param_array(ports, int, ports_c, 0400);
 
 static int loose;
-MODULE_PARM(loose, "i");
+module_param(loose, int, 0600);
 
 #if 0
 #define DEBUGP printk
@@ -420,10 +421,7 @@ static int __init init(void)
 	int i, ret;
 	char *tmpname;
 
-	if (ports[0] == 0)
-		ports[0] = FTP_PORT;
-
-	for (i = 0; (i < MAX_PORTS) && ports[i]; i++) {
+	for (i = 0; i < ports_c; i++) {
 		ftp[i].tuple.src.u.tcp.port = htons(ports[i]);
 		ftp[i].tuple.dst.protonum = IPPROTO_TCP;
 		ftp[i].mask.src.u.tcp.port = 0xFFFF;
@@ -449,7 +447,6 @@ static int __init init(void)
 			fini();
 			return ret;
 		}
-		ports_c++;
 	}
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_irc.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_irc.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_irc.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_irc.c	2004-08-16 12:14:24.000000000 +1000
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/netfilter.h>
 #include <linux/ip.h>
+#include <linux/moduleparam.h>
 #include <net/checksum.h>
 #include <net/tcp.h>
 
@@ -34,8 +35,8 @@
 #include <linux/netfilter_ipv4/ip_conntrack_irc.h>
 
 #define MAX_PORTS 8
-static int ports[MAX_PORTS];
-static int ports_c;
+static int ports[MAX_PORTS] = { IRC_PORT };
+static int ports_c = 1;
 static int max_dcc_channels = 8;
 static unsigned int dcc_timeout = 300;
 /* This is slow, but it's simple. --RR */
@@ -44,11 +45,11 @@ static char irc_buffer[65536];
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("IRC (DCC) connection tracking helper");
 MODULE_LICENSE("GPL");
-MODULE_PARM(ports, "1-" __MODULE_STRING(MAX_PORTS) "i");
+module_param_array(ports, int, ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of IRC servers");
-MODULE_PARM(max_dcc_channels, "i");
+module_param(max_dcc_channels, int, 0);
 MODULE_PARM_DESC(max_dcc_channels, "max number of expected DCC channels per IRC session");
-MODULE_PARM(dcc_timeout, "i");
+module_param(dcc_timeout, uint, 0);
 MODULE_PARM_DESC(dcc_timeout, "timeout on for unestablished DCC channels");
 
 static char *dccprotos[] = { "SEND ", "CHAT ", "MOVE ", "TSEND ", "SCHAT " };
@@ -251,11 +252,7 @@ static int __init init(void)
 		return -EBUSY;
 	}
 	
-	/* If no port given, default to standard irc port */
-	if (ports[0] == 0)
-		ports[0] = IRC_PORT;
-
-	for (i = 0; (i < MAX_PORTS) && ports[i]; i++) {
+	for (i = 0; i < ports_c; i++) {
 		hlpr = &irc_helpers[i];
 		hlpr->tuple.src.u.tcp.port = htons(ports[i]);
 		hlpr->tuple.dst.protonum = IPPROTO_TCP;
@@ -284,7 +281,6 @@ static int __init init(void)
 			fini();
 			return -EBUSY;
 		}
-		ports_c++;
 	}
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_tftp.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_tftp.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_conntrack_tftp.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_conntrack_tftp.c	2004-08-16 12:14:24.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/ip.h>
 #include <linux/udp.h>
+#include <linux/moduleparam.h>
 
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
@@ -25,9 +26,9 @@ MODULE_DESCRIPTION("tftp connection trac
 MODULE_LICENSE("GPL");
 
 #define MAX_PORTS 8
-static int ports[MAX_PORTS];
-static int ports_c;
-MODULE_PARM(ports, "1-" __MODULE_STRING(MAX_PORTS) "i");
+static int ports[MAX_PORTS] = { TFTP_PORT };
+static int ports_c = 1;
+module_param_array(ports, int, ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of tftp servers");
 
 #if 0
@@ -104,10 +105,7 @@ static int __init init(void)
 	int i, ret;
 	char *tmpname;
 
-	if (!ports[0])
-		ports[0]=TFTP_PORT;
-
-	for (i = 0 ; (i < MAX_PORTS) && ports[i] ; i++) {
+	for (i = 0 ; i < ports_c; i++) {
 		/* Create helper structure */
 		memset(&tftp[i], 0, sizeof(struct ip_conntrack_helper));
 
@@ -137,7 +135,6 @@ static int __init init(void)
 			fini();
 			return(ret);
 		}
-		ports_c++;
 	}
 	return(0);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_nat_ftp.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_nat_ftp.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_nat_ftp.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_nat_ftp.c	2004-08-16 12:14:24.000000000 +1000
@@ -12,6 +12,7 @@
 #include <linux/netfilter_ipv4.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
+#include <linux/moduleparam.h>
 #include <net/tcp.h>
 #include <linux/netfilter_ipv4/ip_nat.h>
 #include <linux/netfilter_ipv4/ip_nat_helper.h>
@@ -30,10 +31,10 @@ MODULE_DESCRIPTION("ftp NAT helper");
 #endif
 
 #define MAX_PORTS 8
-static int ports[MAX_PORTS];
-static int ports_c;
+static int ports[MAX_PORTS] = { FTP_PORT };
+static int ports_c = 1;
 
-MODULE_PARM(ports, "1-" __MODULE_STRING(MAX_PORTS) "i");
+module_param_array(ports, int, ports_c, 0400);
 
 DECLARE_LOCK_EXTERN(ip_ftp_lock);
 
@@ -313,10 +314,7 @@ static int __init init(void)
 	int i, ret = 0;
 	char *tmpname;
 
-	if (ports[0] == 0)
-		ports[0] = FTP_PORT;
-
-	for (i = 0; (i < MAX_PORTS) && ports[i]; i++) {
+	for (i = 0; i < ports_c; i++) {
 		ftp[i].tuple.dst.protonum = IPPROTO_TCP;
 		ftp[i].tuple.src.u.tcp.port = htons(ports[i]);
 		ftp[i].mask.dst.protonum = 0xFFFF;
@@ -343,7 +341,6 @@ static int __init init(void)
 			fini();
 			return ret;
 		}
-		ports_c++;
 	}
 
 	return ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_nat_irc.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_nat_irc.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_nat_irc.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_nat_irc.c	2004-08-16 12:14:24.000000000 +1000
@@ -17,6 +17,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
@@ -35,13 +36,13 @@
 #endif
 
 #define MAX_PORTS 8
-static int ports[MAX_PORTS];
-static int ports_c;
+static int ports[MAX_PORTS] = { IRC_PORT };
+static int ports_c = 1;
 
 MODULE_AUTHOR("Harald Welte <laforge@gnumonks.org>");
 MODULE_DESCRIPTION("IRC (DCC) NAT helper");
 MODULE_LICENSE("GPL");
-MODULE_PARM(ports, "1-" __MODULE_STRING(MAX_PORTS) "i");
+module_param_array(ports, int, ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of IRC servers");
 
 /* protects irc part of conntracks */
@@ -235,11 +236,7 @@ static int __init init(void)
 	struct ip_nat_helper *hlpr;
 	char *tmpname;
 
-	if (ports[0] == 0) {
-		ports[0] = IRC_PORT;
-	}
-
-	for (i = 0; (i < MAX_PORTS) && ports[i] != 0; i++) {
+	for (i = 0; ports_c; i++) {
 		hlpr = &ip_nat_irc_helpers[i];
 		hlpr->tuple.dst.protonum = IPPROTO_TCP;
 		hlpr->tuple.src.u.tcp.port = htons(ports[i]);
@@ -269,7 +266,6 @@ static int __init init(void)
 			fini();
 			return 1;
 		}
-		ports_c++;
 	}
 	return ret;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_nat_snmp_basic.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_nat_snmp_basic.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_nat_snmp_basic.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_nat_snmp_basic.c	2004-08-16 12:14:24.000000000 +1000
@@ -51,6 +51,7 @@
 #include <linux/netfilter_ipv4/ip_nat.h>
 #include <linux/netfilter_ipv4/ip_nat_helper.h>
 #include <linux/ip.h>
+#include <linux/moduleparam.h>
 #include <net/checksum.h>
 #include <net/udp.h>
 #include <asm/uaccess.h>
@@ -1357,4 +1358,4 @@ static void __exit fini(void)
 module_init(init);
 module_exit(fini);
 
-MODULE_PARM(debug, "i");
+module_param(debug, int, 0600);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_nat_tftp.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_nat_tftp.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ip_nat_tftp.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ip_nat_tftp.c	2004-08-16 12:14:24.000000000 +1000
@@ -25,6 +25,7 @@
 #include <linux/netfilter_ipv4.h>
 #include <linux/ip.h>
 #include <linux/udp.h>
+#include <linux/moduleparam.h>
 
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
@@ -39,9 +40,9 @@ MODULE_LICENSE("GPL");
 
 #define MAX_PORTS 8
 
-static int ports[MAX_PORTS];
-static int ports_c = 0;
-MODULE_PARM(ports,"1-" __MODULE_STRING(MAX_PORTS) "i");
+static int ports[MAX_PORTS] = { TFTP_PORT };
+static int ports_c = 1;
+module_param_array(ports, int, ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of tftp servers");
 
 #if 0
@@ -162,10 +163,7 @@ static int __init init(void)
 	int i, ret = 0;
 	char *tmpname;
 
-	if (!ports[0])
-		ports[0] = TFTP_PORT;
-
-	for (i = 0 ; (i < MAX_PORTS) && ports[i] ; i++) {
+	for (i = 0 ; i < ports_c ; i++) {
 		memset(&tftp[i], 0, sizeof(struct ip_nat_helper));
 
 		tftp[i].tuple.dst.protonum = IPPROTO_UDP;
@@ -194,7 +192,6 @@ static int __init init(void)
 			fini();
 			return ret;
 		}
-		ports_c++;
 	}
 	return ret;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ipt_LOG.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ipt_LOG.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ipt_LOG.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ipt_LOG.c	2004-08-16 12:14:24.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>
 #include <linux/ip.h>
+#include <linux/moduleparam.h>
 #include <net/icmp.h>
 #include <net/udp.h>
 #include <net/tcp.h>
@@ -28,7 +29,7 @@ MODULE_AUTHOR("Netfilter Core Team <core
 MODULE_DESCRIPTION("iptables syslog logging module");
 
 static unsigned int nflog = 1;
-MODULE_PARM(nflog, "i");
+module_param(nflog, int, 0);
 MODULE_PARM_DESC(nflog, "register as internal netfilter logging module");
  
 #if 0
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ipt_ULOG.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ipt_ULOG.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ipt_ULOG.c	2004-08-11 09:42:27.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ipt_ULOG.c	2004-08-16 12:14:24.000000000 +1000
@@ -54,6 +54,7 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_ULOG.h>
 #include <linux/netfilter_ipv4/lockhelp.h>
+#include <linux/moduleparam.h>
 #include <net/sock.h>
 #include <linux/bitops.h>
 
@@ -74,15 +75,15 @@ MODULE_DESCRIPTION("iptables userspace l
 #define PRINTR(format, args...) do { if (net_ratelimit()) printk(format , ## args); } while (0)
 
 static unsigned int nlbufsiz = 4096;
-MODULE_PARM(nlbufsiz, "i");
+module_param(nlbufsiz, uint, 0);
 MODULE_PARM_DESC(nlbufsiz, "netlink buffer size");
 
 static unsigned int flushtimeout = 10 * HZ;
-MODULE_PARM(flushtimeout, "i");
+module_param(flushtimeout, uint, 0);
 MODULE_PARM_DESC(flushtimeout, "buffer flush timeout");
 
-static unsigned int nflog = 1;
-MODULE_PARM(nflog, "i");
+static int nflog = 1;
+module_param(nflog, bool, 0);
 MODULE_PARM_DESC(nflog, "register as internal netfilter logging module");
 
 /* global data structures */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ipt_recent.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ipt_recent.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/ipt_recent.c	2004-06-17 08:49:54.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/ipt_recent.c	2004-08-16 12:14:25.000000000 +1000
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/ip.h>
 #include <linux/vmalloc.h>
+#include <linux/moduleparam.h>
 
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_recent.h>
@@ -37,12 +38,12 @@ KERN_INFO RECENT_NAME " " RECENT_VER ": 
 MODULE_AUTHOR("Stephen Frost <sfrost@snowman.net>");
 MODULE_DESCRIPTION("IP tables recently seen matching module " RECENT_VER);
 MODULE_LICENSE("GPL");
-MODULE_PARM(ip_list_tot,"i");
-MODULE_PARM(ip_pkt_list_tot,"i");
-MODULE_PARM(ip_list_hash_size,"i");
-MODULE_PARM(ip_list_perms,"i");
+module_param(ip_list_tot, int ,0);
+module_param(ip_pkt_list_tot, int, 0);
+module_param(ip_list_hash_size, int, 0);
+module_param(ip_list_perms, int, 0);
 #ifdef DEBUG
-MODULE_PARM(debug,"i");
+module_param(debug, int, bool);
 MODULE_PARM_DESC(debug,"debugging level, defaults to 1");
 #endif
 MODULE_PARM_DESC(ip_list_tot,"number of IPs to remember per list");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/iptable_filter.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/iptable_filter.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv4/netfilter/iptable_filter.c	2004-02-18 23:54:37.000000000 +1100
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv4/netfilter/iptable_filter.c	2004-08-16 12:14:25.000000000 +1000
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 
 MODULE_LICENSE("GPL");
@@ -155,7 +156,7 @@ static struct nf_hook_ops ipt_ops[] = {
 
 /* Default to forward because I got too much mail already. */
 static int forward = NF_ACCEPT;
-MODULE_PARM(forward, "i");
+module_param(forward, bool, 0);
 
 static int __init init(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv6/netfilter/ip6t_LOG.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv6/netfilter/ip6t_LOG.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv6/netfilter/ip6t_LOG.c	2004-08-11 09:42:29.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv6/netfilter/ip6t_LOG.c	2004-08-16 12:14:25.000000000 +1000
@@ -19,14 +19,15 @@
 #include <net/tcp.h>
 #include <net/ipv6.h>
 #include <linux/netfilter.h>
+#include <linux/moduleparam.h>
 #include <linux/netfilter_ipv6/ip6_tables.h>
 
 MODULE_AUTHOR("Jan Rekorajski <baggins@pld.org.pl>");
 MODULE_DESCRIPTION("IP6 tables LOG target module");
 MODULE_LICENSE("GPL");
 
-static unsigned int nflog = 1;
-MODULE_PARM(nflog, "i");
+static int nflog = 1;
+module_param(nflog, bool, 0);
 MODULE_PARM_DESC(nflog, "register as internal netfilter logging module");
  
 struct in_device;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/ipv6/netfilter/ip6table_filter.c .16083-linux-2.6.8-rc4-mm1.updated/net/ipv6/netfilter/ip6table_filter.c
--- .16083-linux-2.6.8-rc4-mm1/net/ipv6/netfilter/ip6table_filter.c	2004-02-18 23:54:37.000000000 +1100
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/ipv6/netfilter/ip6table_filter.c	2004-08-16 12:14:25.000000000 +1000
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/netfilter_ipv6/ip6_tables.h>
 
 MODULE_LICENSE("GPL");
@@ -156,7 +157,7 @@ static struct nf_hook_ops ip6t_ops[] = {
 
 /* Default to forward because I got too much mail already. */
 static int forward = NF_ACCEPT;
-MODULE_PARM(forward, "i");
+module_param(forward, bool, 0);
 
 static int __init init(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/irda/irlan/irlan_common.c .16083-linux-2.6.8-rc4-mm1.updated/net/irda/irlan/irlan_common.c
--- .16083-linux-2.6.8-rc4-mm1/net/irda/irlan/irlan_common.c	2004-05-10 15:14:07.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/irda/irlan/irlan_common.c	2004-08-16 12:14:25.000000000 +1000
@@ -36,6 +36,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
+#include <linux/moduleparam.h>
 
 #include <asm/system.h>
 #include <asm/bitops.h>
@@ -1181,9 +1182,9 @@ MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.
 MODULE_DESCRIPTION("The Linux IrDA LAN protocol"); 
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(eth, "i");
+module_param(eth, bool, 0);
 MODULE_PARM_DESC(eth, "Name devices ethX (0) or irlanX (1)");
-MODULE_PARM(access, "i");
+module_param(access, int, 0);
 MODULE_PARM_DESC(access, "Access type DIRECT=1, PEER=2, HOSTED=3");
 
 module_init(irlan_init);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16083-linux-2.6.8-rc4-mm1/net/sched/sch_teql.c .16083-linux-2.6.8-rc4-mm1.updated/net/sched/sch_teql.c
--- .16083-linux-2.6.8-rc4-mm1/net/sched/sch_teql.c	2004-08-11 09:42:30.000000000 +1000
+++ .16083-linux-2.6.8-rc4-mm1.updated/net/sched/sch_teql.c	2004-08-16 12:14:25.000000000 +1000
@@ -31,6 +31,7 @@
 #include <net/ip.h>
 #include <net/route.h>
 #include <linux/skbuff.h>
+#include <linux/moduleparam.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
 
@@ -449,7 +450,7 @@ static __init void teql_master_setup(str
 
 static LIST_HEAD(master_dev_list);
 static int max_equalizers = 1;
-MODULE_PARM(max_equalizers, "i");
+module_param(max_equalizers, int, 0);
 MODULE_PARM_DESC(max_equalizers, "Max number of link equalizers");
 
 static int __init teql_init(void)

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

