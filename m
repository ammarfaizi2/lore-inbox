Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265182AbSJaGHr>; Thu, 31 Oct 2002 01:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265183AbSJaGHr>; Thu, 31 Oct 2002 01:07:47 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:10713 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265182AbSJaGHq>; Thu, 31 Oct 2002 01:07:46 -0500
Message-ID: <3DC0BBE6.1BEA710E@verizon.net>
Date: Wed, 30 Oct 2002 21:13:10 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.44 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: 2.5.45 net: warning + patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [4.64.197.173] at Thu, 31 Oct 2002 00:14:06 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,net/sunrpc/.clnt.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=clnt   -c -o net/sunrpc/clnt.o net/sunrpc/clnt.c
net/ipv4/route.c: In function `ip_rt_init':
net/ipv4/route.c:2544: warning: implicit declaration of function
`xfrm_init'

and one patch is:

--- ./include/net/xfrm.h%syntax Wed Oct 30 16:42:22 2002
+++ ./include/net/xfrm.h        Wed Oct 30 20:58:29 2002
@@ -384,3 +384,4 @@
 extern int km_query(struct xfrm_state *x);
 
 extern int ah4_init(void);
+extern void xfrm_init(void);
--- ./net/ipv4/route.c%syntax   Wed Oct 30 16:43:45 2002
+++ ./net/ipv4/route.c  Wed Oct 30 21:08:52 2002
@@ -94,6 +94,7 @@
 #include <net/arp.h>
 #include <net/tcp.h>
 #include <net/icmp.h>
+#include <net/xfrm.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif


~Randy
