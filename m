Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbTB0Vtz>; Thu, 27 Feb 2003 16:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbTB0Vtz>; Thu, 27 Feb 2003 16:49:55 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:37893 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S267121AbTB0Vts>; Thu, 27 Feb 2003 16:49:48 -0500
Date: Fri, 28 Feb 2003 06:59:44 +0900 (JST)
Message-Id: <20030228.065944.08980219.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: [PATCH] Use C99 initializers in net/ipv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This convers net/ipv6/{addrconf,route,sit}.c files to use C99
initializers.  We don't touch net/ipv6/exthdrs.c for now because
it will conflicts with our patch for IPsec.

Thanks in advance.

-------------------------------------------------------------------
Patch-Name: Use C99 initializers in net/ipv6
Patch-Id: FIX_2_5_63_C99_CLEANUP-20030228
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
-------------------------------------------------------------------
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.6
retrieving revision 1.1.1.6.4.1
diff -u -r1.1.1.6 -r1.1.1.6.4.1
--- net/ipv6/addrconf.c	25 Feb 2003 05:33:26 -0000	1.1.1.6
+++ net/ipv6/addrconf.c	27 Feb 2003 21:31:11 -0000	1.1.1.6.4.1
@@ -2288,75 +2288,163 @@
 	ctl_table addrconf_proto_dir[2];
 	ctl_table addrconf_root_dir[2];
 } addrconf_sysctl = {
-	NULL,
-        {{NET_IPV6_FORWARDING, "forwarding",
-         &ipv6_devconf.forwarding, sizeof(int), 0644, NULL,
-         &addrconf_sysctl_forward},
-
-	{NET_IPV6_HOP_LIMIT, "hop_limit",
-         &ipv6_devconf.hop_limit, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-
-	{NET_IPV6_MTU, "mtu",
-         &ipv6_devconf.mtu6, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-
-	{NET_IPV6_ACCEPT_RA, "accept_ra",
-         &ipv6_devconf.accept_ra, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-
-	{NET_IPV6_ACCEPT_REDIRECTS, "accept_redirects",
-         &ipv6_devconf.accept_redirects, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-
-	{NET_IPV6_AUTOCONF, "autoconf",
-         &ipv6_devconf.autoconf, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-
-	{NET_IPV6_DAD_TRANSMITS, "dad_transmits",
-         &ipv6_devconf.dad_transmits, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-
-	{NET_IPV6_RTR_SOLICITS, "router_solicitations",
-         &ipv6_devconf.rtr_solicits, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-
-	{NET_IPV6_RTR_SOLICIT_INTERVAL, "router_solicitation_interval",
-         &ipv6_devconf.rtr_solicit_interval, sizeof(int), 0644, NULL,
-         &proc_dointvec_jiffies},
-
-	{NET_IPV6_RTR_SOLICIT_DELAY, "router_solicitation_delay",
-         &ipv6_devconf.rtr_solicit_delay, sizeof(int), 0644, NULL,
-         &proc_dointvec_jiffies},
-
+	.sysctl_header = NULL,
+	.addrconf_vars = {
+        	{
+			.ctl_name	=	NET_IPV6_FORWARDING,
+			.procname	=	"forwarding",
+         		.data		=	&ipv6_devconf.forwarding,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&addrconf_sysctl_forward,
+		},
+		{
+			.ctl_name	=	NET_IPV6_HOP_LIMIT,
+			.procname	=	"hop_limit",
+         		.data		=	&ipv6_devconf.hop_limit,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+			.proc_handler	=	proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_MTU,
+			.procname	=	"mtu",
+			.data		=	&ipv6_devconf.mtu6,
+         		.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_ACCEPT_RA,
+			.procname	=	"accept_ra",
+         		.data		=	&ipv6_devconf.accept_ra,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_ACCEPT_REDIRECTS,
+			.procname	=	"accept_redirects",
+         		.data		=	&ipv6_devconf.accept_redirects,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_AUTOCONF,
+			.procname	=	"autoconf",
+         		.data		=	&ipv6_devconf.autoconf,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_DAD_TRANSMITS,
+			.procname	=	"dad_transmits",
+         		.data		=	&ipv6_devconf.dad_transmits,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_RTR_SOLICITS,
+			.procname	=	"router_solicitations",
+         		.data		=	&ipv6_devconf.rtr_solicits,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_RTR_SOLICIT_INTERVAL,
+			.procname	=	"router_solicitation_interval",
+         		.data		=	&ipv6_devconf.rtr_solicit_interval,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&proc_dointvec_jiffies,
+		},
+		{
+			.ctl_name	=	NET_IPV6_RTR_SOLICIT_DELAY,
+			.procname	=	"router_solicitation_delay",
+         		.data		=	&ipv6_devconf.rtr_solicit_delay,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+         		.proc_handler	=	&proc_dointvec_jiffies,
+		},
 #ifdef CONFIG_IPV6_PRIVACY
-	{NET_IPV6_USE_TEMPADDR, "use_tempaddr",
-	 &ipv6_devconf.use_tempaddr, sizeof(int), 0644, NULL,
-	 &proc_dointvec},
-
-	{NET_IPV6_TEMP_VALID_LFT, "temp_valid_lft",
-	 &ipv6_devconf.temp_valid_lft, sizeof(int), 0644, NULL,
-	 &proc_dointvec},
-
-	{NET_IPV6_TEMP_PREFERED_LFT, "temp_prefered_lft",
-	 &ipv6_devconf.temp_prefered_lft, sizeof(int), 0644, NULL,
-	 &proc_dointvec},
-
-	{NET_IPV6_REGEN_MAX_RETRY, "regen_max_retry",
-	 &ipv6_devconf.regen_max_retry, sizeof(int), 0644, NULL,
-	 &proc_dointvec},
-
-	{NET_IPV6_MAX_DESYNC_FACTOR, "max_desync_factor",
-	 &ipv6_devconf.max_desync_factor, sizeof(int), 0644, NULL,
-	 &proc_dointvec},
+		{
+			.ctl_name	=	NET_IPV6_USE_TEMPADDR,
+			.procname	=	"use_tempaddr",
+	 		.data		=	&ipv6_devconf.use_tempaddr,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+	 		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_TEMP_VALID_LFT,
+			.procname	=	"temp_valid_lft",
+	 		.data		=	&ipv6_devconf.temp_valid_lft,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+	 		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_TEMP_PREFERED_LFT,
+			.procname	=	"temp_prefered_lft",
+	 		.data		=	&ipv6_devconf.temp_prefered_lft,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+	 		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_REGEN_MAX_RETRY,
+			.procname	=	"regen_max_retry",
+	 		.data		=	&ipv6_devconf.regen_max_retry,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+	 		.proc_handler	=	&proc_dointvec,
+		},
+		{
+			.ctl_name	=	NET_IPV6_MAX_DESYNC_FACTOR,
+			.procname	=	"max_desync_factor",
+	 		.data		=	&ipv6_devconf.max_desync_factor,
+			.maxlen		=	sizeof(int),
+			.mode		=	0644,
+	 		.proc_handler	=	&proc_dointvec,
+		},
 #endif
-
-	{0}},
-
-	{{NET_PROTO_CONF_ALL, "all", NULL, 0, 0555, addrconf_sysctl.addrconf_vars},{0}},
-	{{NET_IPV6_CONF, "conf", NULL, 0, 0555, addrconf_sysctl.addrconf_dev},{0}},
-	{{NET_IPV6, "ipv6", NULL, 0, 0555, addrconf_sysctl.addrconf_conf_dir},{0}},
-	{{CTL_NET, "net", NULL, 0, 0555, addrconf_sysctl.addrconf_proto_dir},{0}}
+	},
+	.addrconf_dev = {
+		{
+			.ctl_name	=	NET_PROTO_CONF_ALL,
+			.procname	=	"all",
+			.mode		=	0555,
+			.child		=	addrconf_sysctl.addrconf_vars,
+		},
+	},
+	.addrconf_conf_dir = {
+		{
+			.ctl_name	=	NET_IPV6_CONF,
+			.procname	=	"conf",
+			.mode		=	0555,
+			.child		=	addrconf_sysctl.addrconf_dev,
+		},
+	},
+	.addrconf_proto_dir = {
+		{
+			.ctl_name	=	NET_IPV6,
+			.procname	=	"ipv6",
+			.mode		=	0555,
+			.child		=	addrconf_sysctl.addrconf_conf_dir,
+		},
+	},
+	.addrconf_root_dir = {
+		{
+			.ctl_name	=	CTL_NET,
+			.procname	=	"net",
+			.mode		=	0555,
+			.child		=	addrconf_sysctl.addrconf_proto_dir,
+		},
+	},
 };
 
 static void addrconf_sysctl_register(struct inet6_dev *idev, struct ipv6_devconf *p)
Index: net/ipv6/route.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/route.c,v
retrieving revision 1.1.1.7
retrieving revision 1.1.1.7.4.1
diff -u -r1.1.1.7 -r1.1.1.7.4.1
--- net/ipv6/route.c	25 Feb 2003 05:33:26 -0000	1.1.1.7
+++ net/ipv6/route.c	27 Feb 2003 21:31:11 -0000	1.1.1.7.4.1
@@ -1777,34 +1777,84 @@
 }
 
 ctl_table ipv6_route_table[] = {
-        {NET_IPV6_ROUTE_FLUSH, "flush",
-         &flush_delay, sizeof(int), 0644, NULL,
-         &ipv6_sysctl_rtcache_flush},
-	{NET_IPV6_ROUTE_GC_THRESH, "gc_thresh",
-         &ip6_dst_ops.gc_thresh, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-	{NET_IPV6_ROUTE_MAX_SIZE, "max_size",
-         &ip6_rt_max_size, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-	{NET_IPV6_ROUTE_GC_MIN_INTERVAL, "gc_min_interval",
-         &ip6_rt_gc_min_interval, sizeof(int), 0644, NULL,
-         &proc_dointvec_jiffies, &sysctl_jiffies},
-	{NET_IPV6_ROUTE_GC_TIMEOUT, "gc_timeout",
-         &ip6_rt_gc_timeout, sizeof(int), 0644, NULL,
-         &proc_dointvec_jiffies, &sysctl_jiffies},
-	{NET_IPV6_ROUTE_GC_INTERVAL, "gc_interval",
-         &ip6_rt_gc_interval, sizeof(int), 0644, NULL,
-         &proc_dointvec_jiffies, &sysctl_jiffies},
-	{NET_IPV6_ROUTE_GC_ELASTICITY, "gc_elasticity",
-         &ip6_rt_gc_elasticity, sizeof(int), 0644, NULL,
-         &proc_dointvec_jiffies, &sysctl_jiffies},
-	{NET_IPV6_ROUTE_MTU_EXPIRES, "mtu_expires",
-         &ip6_rt_mtu_expires, sizeof(int), 0644, NULL,
-         &proc_dointvec_jiffies, &sysctl_jiffies},
-	{NET_IPV6_ROUTE_MIN_ADVMSS, "min_adv_mss",
-         &ip6_rt_min_advmss, sizeof(int), 0644, NULL,
-         &proc_dointvec_jiffies, &sysctl_jiffies},
-	 {0}
+        {
+		.ctl_name	=	NET_IPV6_ROUTE_FLUSH, 
+		.procname	=	"flush",
+         	.data		=	&flush_delay,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&ipv6_sysctl_rtcache_flush
+	},
+	{
+		.ctl_name	=	NET_IPV6_ROUTE_GC_THRESH,
+		.procname	=	"gc_thresh",
+         	.data		=	&ip6_dst_ops.gc_thresh,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&proc_dointvec,
+	},
+	{
+		.ctl_name	=	NET_IPV6_ROUTE_MAX_SIZE,
+		.procname	=	"max_size",
+         	.data		=	&ip6_rt_max_size,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&proc_dointvec,
+	},
+	{
+		.ctl_name	=	NET_IPV6_ROUTE_GC_MIN_INTERVAL,
+		.procname	=	"gc_min_interval",
+         	.data		=	&ip6_rt_gc_min_interval,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&proc_dointvec_jiffies,
+		.strategy	=	&sysctl_jiffies,
+	},
+	{
+		.ctl_name	=	NET_IPV6_ROUTE_GC_TIMEOUT,
+		.procname	=	"gc_timeout",
+         	.data		=	&ip6_rt_gc_timeout,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&proc_dointvec_jiffies,
+		.strategy	=	&sysctl_jiffies,
+	},
+	{
+		.ctl_name	=	NET_IPV6_ROUTE_GC_INTERVAL,
+		.procname	=	"gc_interval",
+         	.data		=	&ip6_rt_gc_interval,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&proc_dointvec_jiffies,
+		.strategy	=	&sysctl_jiffies,
+	},
+	{
+		.ctl_name	=	NET_IPV6_ROUTE_GC_ELASTICITY,
+		.procname	=	"gc_elasticity",
+         	.data		=	&ip6_rt_gc_elasticity,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&proc_dointvec_jiffies,
+		.strategy	=	&sysctl_jiffies,
+	},
+	{
+		.ctl_name	=	NET_IPV6_ROUTE_MTU_EXPIRES,
+		.procname	=	"mtu_expires",
+         	.data		=	&ip6_rt_mtu_expires,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&proc_dointvec_jiffies,
+		.strategy	=	&sysctl_jiffies,
+	},
+	{
+		.ctl_name	=	NET_IPV6_ROUTE_MIN_ADVMSS,
+		.procname	=	"min_adv_mss",
+         	.data		=	&ip6_rt_min_advmss,
+		.maxlen		=	sizeof(int),
+		.mode		=	0644,
+         	.proc_handler	=	&proc_dointvec_jiffies,
+		.strategy	=	&sysctl_jiffies,
+	},
 };
 
 #endif
Index: net/ipv6/sit.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/sit.c,v
retrieving revision 1.1.1.6
retrieving revision 1.1.1.6.4.1
diff -u -r1.1.1.6 -r1.1.1.6.4.1
--- net/ipv6/sit.c	25 Feb 2003 05:33:26 -0000	1.1.1.6
+++ net/ipv6/sit.c	27 Feb 2003 21:31:11 -0000	1.1.1.6.4.1
@@ -68,7 +68,8 @@
 };
 
 static struct ip_tunnel ipip6_fb_tunnel = {
-	NULL, &ipip6_fb_tunnel_dev, {0, }, 0, 0, 0, 0, 0, 0, 0, {"sit0", }
+	.dev = &ipip6_fb_tunnel_dev,
+	.parms = { .name = "sit0" }
 };
 
 static struct ip_tunnel *tunnels_r_l[HASH_SIZE];


-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
