Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbTCRJAW>; Tue, 18 Mar 2003 04:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbTCRJAW>; Tue, 18 Mar 2003 04:00:22 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:18832 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262238AbTCRJAT>; Tue, 18 Mar 2003 04:00:19 -0500
Date: Tue, 18 Mar 2003 20:11:18 +1100
From: CaT <cat@zip.com.au>
To: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       pekkas@netcore.fi
Subject: 2.5.65: netfiler ipv6 compile failure fix
Message-ID: <20030318091118.GC504@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the ipv6_ext_hdr function was left in a few files. The
patch below removes it. This in turn allows me to compile the kernel.
I'm not too sure if it's right as I haven't pulled my finger out yet and
started playing with IPv6.

--- net/ipv6/netfilter/ip6t_ah.c.old	Tue Mar 18 17:16:18 2003
+++ net/ipv6/netfilter/ip6t_ah.c	Tue Mar 18 17:17:23 2003
@@ -26,17 +26,6 @@
        __u32   spi;
 };
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /* Returns 1 if the spi is matched by the range, 0 otherwise */
 static inline int
 spi_match(u_int32_t min, u_int32_t max, u_int32_t spi, int invert)
--- net/ipv6/netfilter/ip6t_dst.c.old	Tue Mar 18 17:16:18 2003
+++ net/ipv6/netfilter/ip6t_dst.c	Tue Mar 18 17:17:05 2003
@@ -29,17 +29,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /*
  * (Type & 0xC0) >> 6
  * 	0	-> ignorable
--- net/ipv6/netfilter/ip6t_esp.c.old	Tue Mar 18 17:16:18 2003
+++ net/ipv6/netfilter/ip6t_esp.c	Tue Mar 18 17:17:15 2003
@@ -23,17 +23,6 @@
 	__u32   spi;
 };
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /* Returns 1 if the spi is matched by the range, 0 otherwise */
 static inline int
 spi_match(u_int32_t min, u_int32_t max, u_int32_t spi, int invert)
--- net/ipv6/netfilter/ip6t_frag.c.old	Tue Mar 18 17:16:18 2003
+++ net/ipv6/netfilter/ip6t_frag.c	Tue Mar 18 17:17:11 2003
@@ -44,17 +44,6 @@
        __u32   id;
 };
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /* Returns 1 if the id is matched by the range, 0 otherwise */
 static inline int
 id_match(u_int32_t min, u_int32_t max, u_int32_t id, int invert)
--- net/ipv6/netfilter/ip6t_hbh.c.old	Tue Mar 18 17:16:18 2003
+++ net/ipv6/netfilter/ip6t_hbh.c	Tue Mar 18 17:16:50 2003
@@ -29,17 +29,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /*
  * (Type & 0xC0) >> 6
  * 	0	-> ignorable
--- net/ipv6/netfilter/ip6t_ipv6header.c.old	Tue Mar 18 17:09:56 2003
+++ net/ipv6/netfilter/ip6t_ipv6header.c	Tue Mar 18 17:09:59 2003
@@ -24,17 +24,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 static int
 ipv6header_match(const struct sk_buff *skb,
 		 const struct net_device *in,
--- net/ipv6/netfilter/ip6t_rt.c.old	Tue Mar 18 17:16:18 2003
+++ net/ipv6/netfilter/ip6t_rt.c	Tue Mar 18 17:16:58 2003
@@ -21,17 +21,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /* Returns 1 if the id is matched by the range, 0 otherwise */
 static inline int
 segsleft_match(u_int32_t min, u_int32_t max, u_int32_t id, int invert)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of Regime of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

