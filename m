Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbTCVQYj>; Sat, 22 Mar 2003 11:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263380AbTCVQYj>; Sat, 22 Mar 2003 11:24:39 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:25098 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S263344AbTCVQYg>; Sat, 22 Mar 2003 11:24:36 -0500
Date: Sun, 23 Mar 2003 01:35:35 +0900 (JST)
Message-Id: <20030323.013535.60875023.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: [PATCH] IPv6: use ipv6_addr_any() for testing unspecified address
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

Use ipv6_addr_any() for testing unspecified address.
Patch is for linux-2.5.65 + ChangeSet 1.1188.
This should be suitable for linux-2.4.x.

Thanks in advance.

Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.8.4.3
retrieving revision 1.1.1.8.4.4
diff -u -r1.1.1.8.4.3 -r1.1.1.8.4.4
--- net/ipv6/addrconf.c	22 Mar 2003 15:16:50 -0000	1.1.1.8.4.3
+++ net/ipv6/addrconf.c	22 Mar 2003 15:27:05 -0000	1.1.1.8.4.4
@@ -426,8 +426,7 @@
 	}
 	for (ifa=idev->addr_list; ifa; ifa=ifa->if_next) {
 		ipv6_addr_prefix(&addr, &ifa->addr, ifa->prefix_len);
-		if (addr.s6_addr32[0] == 0 && addr.s6_addr32[1] == 0 &&
-		    addr.s6_addr32[2] == 0 && addr.s6_addr32[3] == 0)
+		if (ipv6_addr_any(&addr))
 			continue;
 		if (idev->cnf.forwarding)
 			ipv6_dev_ac_inc(idev->dev, &addr);
@@ -2030,8 +2029,7 @@
 		struct in6_addr addr;
 
 		ipv6_addr_prefix(&addr, &ifp->addr, ifp->prefix_len);
-		if (addr.s6_addr32[0] || addr.s6_addr32[1] ||
-		    addr.s6_addr32[2] || addr.s6_addr32[3])
+		if (!ipv6_addr_any(&addr))
 			ipv6_dev_ac_inc(ifp->idev->dev, &addr);
 	}
 }
@@ -2368,8 +2366,7 @@
 			struct in6_addr addr;
 
 			ipv6_addr_prefix(&addr, &ifp->addr, ifp->prefix_len);
-			if (addr.s6_addr32[0] || addr.s6_addr32[1] ||
-			    addr.s6_addr32[2] || addr.s6_addr32[3])
+			if (!ipv6_addr_any(&addr))
 				ipv6_dev_ac_dec(ifp->idev->dev, &addr);
 		}
 		if (!ipv6_chk_addr(&ifp->addr, NULL))

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
