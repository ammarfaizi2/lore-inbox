Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277030AbRJQSgx>; Wed, 17 Oct 2001 14:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277039AbRJQSgn>; Wed, 17 Oct 2001 14:36:43 -0400
Received: from kaa.perlsupport.com ([205.245.149.25]:16137 "EHLO
	kaa.perlsupport.com") by vger.kernel.org with ESMTP
	id <S277030AbRJQSgZ>; Wed, 17 Oct 2001 14:36:25 -0400
Date: Wed, 17 Oct 2001 11:36:40 -0700
From: Chip Salzenberg <chip@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.13pre3: &i_mapping used where i_mapping needed
Message-ID: <20011017113640.A3859@perlsupport.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In 2.4.13pre3, mm/filemap.c:mincore_page() sets an address_space
pointer to &inode->i_mapping.  This is almost surely an error, because
i_mapping is already a pointer.

A minimal patch is attached.
-- 
Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pre3-mapping-typo-1


Index: linux/mm/filemap.c
--- linux/mm/filemap.c.old	Tue Oct 16 23:29:08 2001
+++ linux/mm/filemap.c	Wed Oct 17 00:26:37 2001
@@ -2449,5 +2449,5 @@
 {
 	unsigned char present = 0;
-	struct address_space * as = &vma->vm_file->f_dentry->d_inode->i_mapping;
+	struct address_space * as = vma->vm_file->f_dentry->d_inode->i_mapping;
 	struct page * page, ** hash = page_hash(as, pgoff);
 

--rwEMma7ioTxnRzrJ--
