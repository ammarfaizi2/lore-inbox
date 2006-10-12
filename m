Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbWJLF2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWJLF2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWJLF2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:28:52 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:51160 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965280AbWJLF2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:28:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=dSCR8uCyTNrCgGxwgaLXIXA6slXnwdnxGd0NkYD3Ex1EusxGicL0LA2bxMp9EM+C4L2eCMi9IVF04j4IdMJwGaaIELkwqG1RTJ0lc+W7kVS5hr8HaRh72RIXjSbxNYCAEJ1CUpuZM6dExEzbl6IjyOQUFOdb7mnaS6+eWfjSJjw=
Date: Thu, 12 Oct 2006 14:28:40 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] jffs2: use rb_first() and rb_last() cleanup
Message-ID: <20061012052840.GA29465@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use rb_first() and rb_last() to implement frag_first() and frag_last().

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

 fs/jffs2/nodelist.h |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: work-fault-inject/fs/jffs2/nodelist.h
===================================================================
--- work-fault-inject.orig/fs/jffs2/nodelist.h
+++ work-fault-inject/fs/jffs2/nodelist.h
@@ -294,23 +294,21 @@ static inline int jffs2_encode_dev(union
 
 static inline struct jffs2_node_frag *frag_first(struct rb_root *root)
 {
-	struct rb_node *node = root->rb_node;
+	struct rb_node *node = rb_first(root);
 
 	if (!node)
 		return NULL;
-	while(node->rb_left)
-		node = node->rb_left;
+
 	return rb_entry(node, struct jffs2_node_frag, rb);
 }
 
 static inline struct jffs2_node_frag *frag_last(struct rb_root *root)
 {
-	struct rb_node *node = root->rb_node;
+	struct rb_node *node = rb_last(root);
 
 	if (!node)
 		return NULL;
-	while(node->rb_right)
-		node = node->rb_right;
+
 	return rb_entry(node, struct jffs2_node_frag, rb);
 }
 
