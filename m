Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWDHL3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWDHL3I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 07:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWDHL3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 07:29:07 -0400
Received: from soohrt.org ([85.131.246.150]:62621 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S964800AbWDHL3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 07:29:06 -0400
Date: Sat, 8 Apr 2006 13:28:59 +0200
From: Horst Schirmeier <horst@schirmeier.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] trivial fs/select.c compiler warning fix
Message-ID: <20060408112859.GS2335@quickstop.soohrt.org>
Mail-Followup-To: Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch fixes
fs/select.c: In function `core_sys_select':
fs/select.c:339: warning: assignment from incompatible pointer type
fs/select.c:376: warning: comparison of distinct pointer types lacks a cast
by casting to (char *) when accessing stack_fds.

Signed-off-by: Horst Schirmeier <horst@schirmeier.com>

---

diff --git a/fs/select.c b/fs/select.c
index 071660f..3025cec 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -336,7 +336,7 @@ static int core_sys_select(int n, fd_set
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
 	if (6*size < SELECT_STACK_ALLOC)
-		bits = stack_fds;
+		bits = (char *) stack_fds;
 	else
 		bits = kmalloc(6 * size, GFP_KERNEL);
 	if (!bits)
@@ -373,7 +373,7 @@ static int core_sys_select(int n, fd_set
 		ret = -EFAULT;
 
 out:
-	if (bits != stack_fds)
+	if (bits != (char *) stack_fds)
 		kfree(bits);
 out_nofds:
 	return ret;

-- 
PGP-Key 0xD40E0E7A
