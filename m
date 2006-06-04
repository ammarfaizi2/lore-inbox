Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932203AbWFDIpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWFDIpp (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 04:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWFDIpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 04:45:45 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:43182 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932203AbWFDIpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 04:45:45 -0400
Message-ID: <349410738.29011@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sun, 4 Jun 2006 16:45:48 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: [minor fix] radixtree: regulate tag get return value
Message-ID: <20060604084548.GA5609@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	nickpiggin@yahoo.com.au
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, this small patch makes the radixtree tester program from
        http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz
run OK, with the latest radix tree code in linux-2.6.17-rc5-mm2.

It regulates the return value to 0/1 for functions
radix_tree_tag_get() and radix_tree_tagged().

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux.orig/lib/radix-tree.c
+++ linux/lib/radix-tree.c
@@ -156,7 +156,7 @@ static inline void tag_clear(struct radi
 static inline int tag_get(struct radix_tree_node *node, unsigned int tag,
 		int offset)
 {
-	return test_bit(offset, node->tags[tag]);
+	return !! test_bit(offset, node->tags[tag]);
 }
 
 static inline void root_tag_set(struct radix_tree_root *root, unsigned int tag)
@@ -177,7 +177,7 @@ static inline void root_tag_clear_all(st
 
 static inline int root_tag_get(struct radix_tree_root *root, unsigned int tag)
 {
-	return root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT));
+	return !! (root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT)));
 }
 
 /*
