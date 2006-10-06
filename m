Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWJFKEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWJFKEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWJFKEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:04:23 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:28830 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932147AbWJFKEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:04:23 -0400
To: linux-kernel@vger.kernel.org
CC: linux-mm@kvack.org, viro@zeniv.linux.org.uk,
       David Miller <davem@davemloft.net>,
       Dmitriy Monakhov <dmonakhov@openvz.org>
Subject: [PATCH] mm: D-cache flushing was forgotten 
From: Dmitriy Monakhov <dmonakhov@openvz.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
Date: Fri, 06 Oct 2006 13:44:50 +0400
Message-ID: <87psd5lqwd.fsf@sw.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Here is a patch that add D-cache flushing  routine
after page was changed. It is forgotten in current code.

David Miller agree with patch.

Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>


--=-=-=
Content-Disposition: inline; filename=diff-buffer-flush-dcache-page

diff --git a/fs/buffer.c b/fs/buffer.c
index 71649ef..b2652aa 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2008,6 +2008,7 @@ static int __block_prepare_write(struct 
 			clear_buffer_new(bh);
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr+block_start, 0, bh->b_size);
+			flush_dcache_page(page);
 			kunmap_atomic(kaddr, KM_USER0);
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
@@ -2514,6 +2515,7 @@ failed:
 	 */
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
+	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);
 	SetPageUptodate(page);
 	set_page_dirty(page);

--=-=-=--

