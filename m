Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUIVTYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUIVTYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUIVTYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:24:20 -0400
Received: from pointblue.com.pl ([81.219.144.6]:61956 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S266786AbUIVTYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:24:02 -0400
Message-ID: <4151D140.9040600@pointblue.com.pl>
Date: Wed, 22 Sep 2004 21:23:44 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] compilation fixes for gcc 4.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one causes most doubts in me, as it is a function declared inside 
body of another function.

Is there really a need to have such mad code in reiser4 fs ??
This issue was raised already on reiser4 mailing list.
Here it's only for reviev and opinions, if no doubts, please apply.

Signed-off-by: Grzegorz Jaskiewicz <gj at pointblue.com.pl>

--- fs/reiser4/search.c    2004-09-22 20:38:04 +0200
+++ fs/reiser4/search.new.c        2004-09-22 20:37:26 +0200
@@ -1088,6 +1088,20 @@
 }
 #endif

+/* true if @key is left delimiting key of @node */
+static int key_is_ld(znode * node, const reiser4_key * key) {
+       int ld;
+
+        assert("nikita-1716", node != NULL);
+        assert("nikita-1758", key != NULL);
+
+        RLOCK_DK(znode_get_tree(node));
+        assert("nikita-1759", znode_contains_key(node, key));
+        ld = keyeq(znode_get_ld_key(node), key);
+        RUNLOCK_DK(znode_get_tree(node));
+        return ld;
+}
+
 /* Process one node during tree traversal.

    This is called by cbk_level_lookup(). */
@@ -1107,19 +1121,6 @@
        /* result */
        int result;

-       /* true if @key is left delimiting key of @node */
-       static int key_is_ld(znode * node, const reiser4_key * key) {
-               int ld;
-
-                assert("nikita-1716", node != NULL);
-                assert("nikita-1758", key != NULL);
-
-                RLOCK_DK(znode_get_tree(node));
-                assert("nikita-1759", znode_contains_key(node, key));
-                ld = keyeq(znode_get_ld_key(node), key);
-                RUNLOCK_DK(znode_get_tree(node));
-                return ld;
-       }
        assert("nikita-379", h != NULL);

        active = h->active_lh->node;


--
GJ
