Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263319AbTCVQYh>; Sat, 22 Mar 2003 11:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263380AbTCVQYh>; Sat, 22 Mar 2003 11:24:37 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:24842 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S263319AbTCVQYf>; Sat, 22 Mar 2003 11:24:35 -0500
Date: Sun, 23 Mar 2003 01:35:32 +0900 (JST)
Message-Id: <20030323.013532.24422763.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: [PATCH] IPv6: use RFC2553 constant
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

Hello.

Use RFC2553 constant variable.

Patch is for linux-2.5.65 + ChangeSet 1.1188 and depends on my
use "const" qualifier patch.

Thanks in advance.

Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.8.4.2
retrieving revision 1.1.1.8.4.3
diff -u -r1.1.1.8.4.2 -r1.1.1.8.4.3
--- net/ipv6/addrconf.c	22 Mar 2003 15:01:28 -0000	1.1.1.8.4.2
+++ net/ipv6/addrconf.c	22 Mar 2003 15:16:50 -0000	1.1.1.8.4.3
@@ -1646,7 +1646,6 @@
 
 static void init_loopback(struct net_device *dev)
 {
-	struct in6_addr addr;
 	struct inet6_dev  *idev;
 	struct inet6_ifaddr * ifp;
 
@@ -1654,15 +1653,12 @@
 
 	ASSERT_RTNL();
 
-	memset(&addr, 0, sizeof(struct in6_addr));
-	addr.s6_addr[15] = 1;
-
 	if ((idev = ipv6_find_idev(dev)) == NULL) {
 		printk(KERN_DEBUG "init loopback: add_dev failed\n");
 		return;
 	}
 
-	ifp = ipv6_add_addr(idev, &addr, 128, IFA_HOST, IFA_F_PERMANENT);
+	ifp = ipv6_add_addr(idev, &in6addr_loopback, 128, IFA_HOST, IFA_F_PERMANENT);
 	if (ifp) {
 		spin_lock_bh(&ifp->lock);
 		ifp->flags &= ~IFA_F_TENTATIVE;

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
