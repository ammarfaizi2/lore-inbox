Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263653AbTCVQZy>; Sat, 22 Mar 2003 11:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263650AbTCVQZx>; Sat, 22 Mar 2003 11:25:53 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:26378 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S263380AbTCVQYl>; Sat, 22 Mar 2003 11:24:41 -0500
Date: Sun, 23 Mar 2003 01:35:28 +0900 (JST)
Message-Id: <20030323.013528.19572208.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: [PATCH] IPv6: use "const" qualifier
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

Specify some arguments of IPv6 address manipulation / testing functions
"const" qualifier.

Patch is against linux-2.5.64 + ChangeSet 1.1188.
This should be suitable for linux-2.4.x.

Thanks in advance.

Index: include/net/addrconf.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/net/addrconf.h,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.4.1
diff -u -r1.1.1.4 -r1.1.1.4.4.1
--- include/net/addrconf.h	22 Mar 2003 01:52:43 -0000	1.1.1.4
+++ include/net/addrconf.h	22 Mar 2003 15:05:07 -0000	1.1.1.4.4.1
@@ -175,7 +175,7 @@
  *	Hash function taken from net_alias.c
  */
 
-static __inline__ u8 ipv6_addr_hash(struct in6_addr *addr)
+static __inline__ u8 ipv6_addr_hash(const struct in6_addr *addr)
 {	
 	__u32 word;
 
@@ -195,7 +195,7 @@
  *	compute link-local solicited-node multicast address
  */
 
-static inline void addrconf_addr_solict_mult(struct in6_addr *addr,
+static inline void addrconf_addr_solict_mult(const struct in6_addr *addr,
 					     struct in6_addr *solicited)
 {
 	ipv6_addr_set(solicited,
@@ -219,7 +219,7 @@
 		      __constant_htonl(0x2));
 }
 
-static inline int ipv6_addr_is_multicast(struct in6_addr *addr)
+static inline int ipv6_addr_is_multicast(const struct in6_addr *addr)
 {
 	return (addr->s6_addr32[0] & __constant_htonl(0xFF000000)) == __constant_htonl(0xFF000000);
 }
Index: include/net/ipv6.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/net/ipv6.h,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.30.1
diff -u -r1.1.1.4 -r1.1.1.4.30.1
--- include/net/ipv6.h	9 Jan 2003 11:14:19 -0000	1.1.1.4
+++ include/net/ipv6.h	22 Mar 2003 14:56:24 -0000	1.1.1.4.30.1
@@ -226,21 +226,21 @@
 					   unsigned int, unsigned int);
 
 
-extern int		ipv6_addr_type(struct in6_addr *addr);
+extern int		ipv6_addr_type(const struct in6_addr *addr);
 
-static inline int ipv6_addr_scope(struct in6_addr *addr)
+static inline int ipv6_addr_scope(const struct in6_addr *addr)
 {
 	return ipv6_addr_type(addr) & IPV6_ADDR_SCOPE_MASK;
 }
 
-static inline int ipv6_addr_cmp(struct in6_addr *a1, struct in6_addr *a2)
+static inline int ipv6_addr_cmp(const struct in6_addr *a1, const struct in6_addr *a2)
 {
-	return memcmp((void *) a1, (void *) a2, sizeof(struct in6_addr));
+	return memcmp((const void *) a1, (const void *) a2, sizeof(struct in6_addr));
 }
 
-static inline void ipv6_addr_copy(struct in6_addr *a1, struct in6_addr *a2)
+static inline void ipv6_addr_copy(struct in6_addr *a1, const struct in6_addr *a2)
 {
-	memcpy((void *) a1, (void *) a2, sizeof(struct in6_addr));
+	memcpy((void *) a1, (const void *) a2, sizeof(struct in6_addr));
 }
 
 #ifndef __HAVE_ARCH_ADDR_SET
@@ -255,7 +255,7 @@
 }
 #endif
 
-static inline int ipv6_addr_any(struct in6_addr *a)
+static inline int ipv6_addr_any(const struct in6_addr *a)
 {
 	return ((a->s6_addr32[0] | a->s6_addr32[1] | 
 		 a->s6_addr32[2] | a->s6_addr32[3] ) == 0); 
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.8
retrieving revision 1.1.1.8.4.2
diff -u -r1.1.1.8 -r1.1.1.8.4.2
--- net/ipv6/addrconf.c	22 Mar 2003 01:52:23 -0000	1.1.1.8
+++ net/ipv6/addrconf.c	22 Mar 2003 15:01:28 -0000	1.1.1.8.4.2
@@ -172,7 +172,7 @@
 const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
 const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
 
-int ipv6_addr_type(struct in6_addr *addr)
+int ipv6_addr_type(const struct in6_addr *addr)
 {
 	int type;
 	u32 st;
@@ -486,7 +486,7 @@
 /* On success it returns ifp with increased reference count */
 
 static struct inet6_ifaddr *
-ipv6_add_addr(struct inet6_dev *idev, struct in6_addr *addr, int pfxlen,
+ipv6_add_addr(struct inet6_dev *idev, const struct in6_addr *addr, int pfxlen,
 	      int scope, unsigned flags)
 {
 	struct inet6_ifaddr *ifa;

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
