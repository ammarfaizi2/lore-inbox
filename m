Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUKHOhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUKHOhA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUKHOgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:36:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261852AbUKHOdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:33:06 -0500
Date: Mon, 8 Nov 2004 14:32:40 GMT
Message-Id: <200411081432.iA8EWeV0023371@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com, sct@redhat.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] EXT3 compiler warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes an uninitialised variable warning in ext3. The
compiler is wrong in this case because it can't analyse the code sufficiently.

Signed-Off-By: dhowells@redhat.com
---
diffstat ext3-2610rc1mm3.diff
 balloc.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/ext3/balloc.c linux-2.6.10-rc1-mm3-frv/fs/ext3/balloc.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/ext3/balloc.c	2004-11-05 13:15:39.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/ext3/balloc.c	2004-11-05 14:13:03.775506583 +0000
@@ -194,8 +194,7 @@ static struct reserve_window_node *searc
 	if (!n)
 		return NULL;
 
-	while (n)
-	{
+	do {
 		rsv = rb_entry(n, struct reserve_window_node, rsv_node);
 
 		if (goal < rsv->rsv_start)
@@ -204,7 +203,7 @@ static struct reserve_window_node *searc
 			n = n->rb_right;
 		else
 			return rsv;
-	}
+	} while (n);
 	/*
 	 * We've fallen off the end of the tree: the goal wasn't inside
 	 * any particular node.  OK, the previous node must be to one
