Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWIXWm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWIXWm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWIXWmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:42:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50629 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751628AbWIXWmW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:42:22 -0400
Date: Sun, 24 Sep 2006 23:42:20 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix iptables __user misannotations
Message-ID: <20060924224219.GY29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/netfilter/x_tables.h |    4 ++--
 net/ipv4/netfilter/ip_tables.c     |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x_tables.h
index 739a98e..04319a7 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -390,13 +390,13 @@ extern int xt_compat_match_offset(struct
 extern void xt_compat_match_from_user(struct xt_entry_match *m,
 				      void **dstptr, int *size);
 extern int xt_compat_match_to_user(struct xt_entry_match *m,
-				   void * __user *dstptr, int *size);
+				   void __user **dstptr, int *size);
 
 extern int xt_compat_target_offset(struct xt_target *target);
 extern void xt_compat_target_from_user(struct xt_entry_target *t,
 				       void **dstptr, int *size);
 extern int xt_compat_target_to_user(struct xt_entry_target *t,
-				    void * __user *dstptr, int *size);
+				    void __user **dstptr, int *size);
 
 #endif /* CONFIG_COMPAT */
 #endif /* __KERNEL__ */
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 800067d..78a44b0 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1364,15 +1364,15 @@ struct compat_ipt_replace {
 };
 
 static inline int compat_copy_match_to_user(struct ipt_entry_match *m,
-		void * __user *dstptr, compat_uint_t *size)
+		void __user **dstptr, compat_uint_t *size)
 {
 	return xt_compat_match_to_user(m, dstptr, size);
 }
 
 static int compat_copy_entry_to_user(struct ipt_entry *e,
-		void * __user *dstptr, compat_uint_t *size)
+		void __user **dstptr, compat_uint_t *size)
 {
-	struct ipt_entry_target __user *t;
+	struct ipt_entry_target *t;
 	struct compat_ipt_entry __user *ce;
 	u_int16_t target_offset, next_offset;
 	compat_uint_t origsize;
-- 
1.4.2.GIT
