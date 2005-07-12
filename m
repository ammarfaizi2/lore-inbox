Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVGLXWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVGLXWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVGLXUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:20:34 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:9543 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262405AbVGLXTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:19:31 -0400
Date: Tue, 12 Jul 2005 19:19:30 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH] reiserfs: fix up case where indent misreads the code
Message-ID: <20050712231930.GA9495@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 indent(1) doesn't know how to handle the "do not compile" error. It results
 in the item_ops array declaration being indented a tab stop in when it should
 not be. This patch replaces it with a #error that describes why it's failing.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.13-rc2/fs/reiserfs/item_ops.c linux-2.6.13-rc2.lindent/fs/reiserfs/item_ops.c
--- linux-2.6.13-rc2/fs/reiserfs/item_ops.c	2005-07-12 21:00:32.000000000 -0400
+++ linux-2.6.13-rc2.lindent/fs/reiserfs/item_ops.c	2005-07-12 21:04:01.000000000 -0400
@@ -772,7 +772,7 @@ static struct item_operations errcatch_o
 //
 //
 #if ! (TYPE_STAT_DATA == 0 && TYPE_INDIRECT == 1 && TYPE_DIRECT == 2 && TYPE_DIRENTRY == 3)
-  do not compile
+#error Item types must use disk-format assigned values.
 #endif
 
 struct item_operations * item_ops [TYPE_ANY + 1] = {
-- 
Jeff Mahoney
SuSE Labs
