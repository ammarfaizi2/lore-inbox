Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVKWAlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVKWAlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVKWAlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:41:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62482 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030280AbVKWAlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:41:09 -0500
Date: Wed, 23 Nov 2005 01:41:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: coreteam@netfilter.org
Cc: netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv4/netfilter/: small cleanups
Message-ID: <20051123004108.GE3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- ip_conntrack_core.c: ip_conntrack_flush() -> ip_conntrack_flush(void)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv4/netfilter/ip_conntrack_core.c |    4 ++--
 net/ipv4/netfilter/ip_nat_core.c       |    2 +-
 net/ipv4/netfilter/ipt_LOG.c           |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc1-mm2-full/net/ipv4/netfilter/ip_conntrack_core.c.old	2005-11-22 22:52:16.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/ipv4/netfilter/ip_conntrack_core.c	2005-11-22 23:00:36.000000000 +0100
@@ -1354,7 +1354,7 @@
 			   get_order(sizeof(struct list_head) * size));
 }
 
-void ip_conntrack_flush()
+void ip_conntrack_flush(void)
 {
 	/* This makes sure all current packets have passed through
            netfilter framework.  Roll on, two-stage module
@@ -1408,7 +1408,7 @@
 	return hash;
 }
 
-int set_hashsize(const char *val, struct kernel_param *kp)
+static int set_hashsize(const char *val, struct kernel_param *kp)
 {
 	int i, bucket, hashsize, vmalloced;
 	int old_vmalloced, old_size;
--- linux-2.6.15-rc1-mm2-full/net/ipv4/netfilter/ipt_LOG.c.old	2005-11-22 22:57:59.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/ipv4/netfilter/ipt_LOG.c	2005-11-22 22:58:08.000000000 +0100
@@ -351,7 +351,7 @@
 	/* maxlen = 230+   91  + 230 + 252 = 803 */
 }
 
-struct nf_loginfo default_loginfo = {
+static struct nf_loginfo default_loginfo = {
 	.type	= NF_LOG_TYPE_LOG,
 	.u = {
 		.log = {
--- linux-2.6.15-rc1-mm2-full/net/ipv4/netfilter/ip_nat_core.c.old	2005-11-22 22:58:31.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/ipv4/netfilter/ip_nat_core.c	2005-11-22 22:58:39.000000000 +0100
@@ -49,7 +49,7 @@
 static struct list_head *bysource;
 
 #define MAX_IP_NAT_PROTO 256
-struct ip_nat_protocol *ip_nat_protos[MAX_IP_NAT_PROTO];
+static struct ip_nat_protocol *ip_nat_protos[MAX_IP_NAT_PROTO];
 
 static inline struct ip_nat_protocol *
 __ip_nat_proto_find(u_int8_t protonum)

