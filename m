Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263697AbUEWWus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUEWWus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 18:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbUEWWus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 18:50:48 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:2190 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263697AbUEWWuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 18:50:46 -0400
Subject: [PATCH] export swapper_space
From: James Bottomley <James.Bottomley@steeleye.com>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 May 2004 17:50:36 -0500
Message-Id: <1085352637.10930.42.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is now used as part of the page_mapping() macro.  However, certain
filesystems, such as ext3, make use of this.  If it's not exported, they
can't be compiled as modules.

James

===== mm/swap_state.c 1.77 vs edited =====
--- 1.77/mm/swap_state.c	Sat May 22 16:56:26 2004
+++ edited/mm/swap_state.c	Sun May 23 16:53:37 2004
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/backing-dev.h>
+#include <linux/module.h>
 
 #include <asm/pgtable.h>
 
@@ -38,6 +39,7 @@
 	.a_ops		= &swap_aops,
 	.backing_dev_info = &swap_backing_dev_info,
 };
+EXPORT_SYMBOL(swapper_space);
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
 


