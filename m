Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUIWCHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUIWCHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 22:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUIWCHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 22:07:38 -0400
Received: from pointblue.com.pl ([81.219.144.6]:27140 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S268141AbUIWCHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 22:07:17 -0400
Message-ID: <41522FC7.6050500@pointblue.com.pl>
Date: Thu, 23 Sep 2004 04:07:03 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] compilation fixes for gcc 4.0
References: <4151D140.9040600@pointblue.com.pl>
In-Reply-To: <4151D140.9040600@pointblue.com.pl>
Content-Type: multipart/mixed;
 boundary="------------060305000904010908020403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305000904010908020403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Grzegorz Piotr Jaskiewicz wrote:

> This one causes most doubts in me, as it is a function declared inside 
> body of another function.
>
> Is there really a need to have such mad code in reiser4 fs ??
> This issue was raised already on reiser4 mailing list.
> Here it's only for reviev and opinions, if no doubts, please apply.
>
I need to change email client :-)
Patch attached.

Signed-off-by: Grzegorz Jaskiewicz <gj at pointblue.com.pl>


--
GJ

--------------060305000904010908020403
Content-Type: text/plain;
 name="search.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="search.c.patch"

--- a/fs/reiser4/search.c	2004-09-22 20:38:04 +0200
+++ b/fs/reiser4/search.new.c	2004-09-22 20:37:26 +0200
@@ -1088,6 +1088,20 @@
 }
 #endif
 
+/* true if @key is left delimiting key of @node */
+static int key_is_ld(znode * node, const reiser4_key * key) {
+	int ld;
+
+	 assert("nikita-1716", node != NULL);
+	 assert("nikita-1758", key != NULL);
+
+	 RLOCK_DK(znode_get_tree(node));
+	 assert("nikita-1759", znode_contains_key(node, key));
+	 ld = keyeq(znode_get_ld_key(node), key);
+	 RUNLOCK_DK(znode_get_tree(node));
+	 return ld;
+}
+
 /* Process one node during tree traversal.
 
    This is called by cbk_level_lookup(). */
@@ -1107,19 +1121,6 @@
 	/* result */
 	int result;
 
-	/* true if @key is left delimiting key of @node */
-	static int key_is_ld(znode * node, const reiser4_key * key) {
-		int ld;
-
-		 assert("nikita-1716", node != NULL);
-		 assert("nikita-1758", key != NULL);
-
-		 RLOCK_DK(znode_get_tree(node));
-		 assert("nikita-1759", znode_contains_key(node, key));
-		 ld = keyeq(znode_get_ld_key(node), key);
-		 RUNLOCK_DK(znode_get_tree(node));
-		 return ld;
-	}
 	assert("nikita-379", h != NULL);
 
 	active = h->active_lh->node;

--------------060305000904010908020403--
