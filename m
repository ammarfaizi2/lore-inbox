Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbTCEWsr>; Wed, 5 Mar 2003 17:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbTCEWsr>; Wed, 5 Mar 2003 17:48:47 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23273 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266805AbTCEWsh>; Wed, 5 Mar 2003 17:48:37 -0500
Date: Wed, 5 Mar 2003 23:59:01 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: CaT <cat@zip.com.au>, laforge@netfilter.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove all ipv6_ext_hdr's from ip6tables
Message-ID: <20030305225901.GP20423@fs.tum.de>
References: <20030305153259.GE2075@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305153259.GE2075@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 02:32:59AM +1100, CaT wrote:

>...
> net/ipv6/netfilter/ip6t_dst.o: In function `ipv6_ext_hdr':
> net/ipv6/netfilter/ip6t_dst.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
> net/ipv6/netfilter/ip6t_rt.o(.text+0x0): first defined here
>...

I don't understand why someone added an ipv6_ext_hdr to every single 
file instead of using the ip6t_ext_hdr that is already present in 
ip6_tables.c. The patch below fixes this problem.

cu
Adrian

--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ah.c.old	2003-03-05 23:30:00.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ah.c	2003-03-05 23:30:43.000000000 +0100
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
@@ -79,7 +68,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_ah header iteration \n");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_dst.c.old	2003-03-05 23:30:44.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_dst.c	2003-03-05 23:31:01.000000000 +0100
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
@@ -84,7 +73,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_opts header iteration \n");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_esp.c.old	2003-03-05 23:31:02.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_esp.c	2003-03-05 23:31:22.000000000 +0100
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
@@ -74,7 +63,7 @@
 	len = skb->len - ptr;
 	temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
         	struct ipv6_opt_hdr *hdr;
         	int hdrlen;
 
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_frag.c.old	2003-03-05 23:31:23.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_frag.c	2003-03-05 23:31:45.000000000 +0100
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
@@ -93,7 +82,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_frag header iteration \n");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_hbh.c.old	2003-03-05 23:31:45.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_hbh.c	2003-03-05 23:32:01.000000000 +0100
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
@@ -84,7 +73,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_opts header iteration \n");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ipv6header.c.old	2003-03-05 23:32:02.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ipv6header.c	2003-03-05 23:32:26.000000000 +0100
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
@@ -95,7 +84,7 @@
 
 	temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
         	struct ipv6_opt_hdr *hdr;
         	int hdrlen;
 
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_rt.c.old	2003-03-05 23:32:26.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_rt.c	2003-03-05 23:32:40.000000000 +0100
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
@@ -71,7 +60,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_rt header iteration \n");
--- linux-2.5.64-notfull/include/linux/netfilter_ipv6/ip6_tables.h.old	2003-03-05 23:36:49.000000000 +0100
+++ linux-2.5.64-notfull/include/linux/netfilter_ipv6/ip6_tables.h	2003-03-05 23:49:51.000000000 +0100
@@ -449,6 +449,9 @@
 				  struct ip6t_table *table,
 				  void *userdata);
 
+/* Check for an extension */
+extern int ip6t_ext_hdr(u8 nexthdr);
+
 #define IP6T_ALIGN(s) (((s) + (__alignof__(struct ip6t_entry)-1)) & ~(__alignof__(struct ip6t_entry)-1))
 
 #endif /*__KERNEL__*/
