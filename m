Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263073AbSJGPA3>; Mon, 7 Oct 2002 11:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263071AbSJGPA3>; Mon, 7 Oct 2002 11:00:29 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:25096 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S263073AbSJGPA2>; Mon, 7 Oct 2002 11:00:28 -0400
Date: Tue, 08 Oct 2002 00:05:59 +0900 (JST)
Message-Id: <20021008.000559.17528416.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Prefix length for link-local address should be 64, not 10.
This patch fixes prefix length of link-local address.

Following patch is against 2.4.19.

Thanks in advance.

-------------------------------------------------------------------
Patch-Name: Fix Prefix Length of Link-local Addresses
Patch-Id: FIX_2_4_19_LINKLOCAL_PREFIXLEN-20020928
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
-------------------------------------------------------------------
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.20.1
diff -u -r1.1.1.1 -r1.1.1.1.20.1
--- net/ipv6/addrconf.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/addrconf.c	2002/09/27 17:17:06	1.1.1.1.20.1
@@ -783,7 +783,7 @@
 	struct in6_addr addr;
 
 	ipv6_addr_set(&addr,  __constant_htonl(0xFE800000), 0, 0, 0);
-	addrconf_prefix_route(&addr, 10, dev, 0, RTF_ADDRCONF);
+	addrconf_prefix_route(&addr, 64, dev, 0, RTF_ADDRCONF);
 }
 
 static struct inet6_dev *addrconf_add_dev(struct net_device *dev)
@@ -1158,7 +1158,7 @@
 					flag |= IFA_HOST;
 				}
 				if (idev->dev->flags&IFF_POINTOPOINT)
-					plen = 10;
+					plen = 64;
 				else
 					plen = 96;
 
@@ -1208,7 +1208,7 @@
 {
 	struct inet6_ifaddr * ifp;
 
-	ifp = ipv6_add_addr(idev, addr, 10, IFA_LINK, IFA_F_PERMANENT);
+	ifp = ipv6_add_addr(idev, addr, 64, IFA_LINK, IFA_F_PERMANENT);
 	if (ifp) {
 		addrconf_dad_start(ifp);
 		in6_ifa_put(ifp);
