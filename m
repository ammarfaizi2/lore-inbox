Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUHWRVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUHWRVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUHWRTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:19:13 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:48612 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S266163AbUHWRRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:17:53 -0400
Message-ID: <412A2693.8030703@ttnet.net.tr>
Date: Mon, 23 Aug 2004 20:17:07 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10] [4/4]
Content-Type: multipart/mixed;
	boundary="------------040406060704030302060203"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406060704030302060203
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

splitted-up the fs/* gcc3.4-inline-patches.

[4/4] fs/xfs/linux-2.4/xfs_lrw.c

Someone please verify / correct this.



--------------040406060704030302060203
Content-Type: text/plain;
	name="gcc34_inline_09-4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_09-4.diff"

--- 28p1/include/linux/fs.h~	2004-08-16 20:23:00.000000000 +0300
+++ 28p1/include/linux/fs.h	2004-08-17 13:02:49.000000000 +0300
@@ -1528,7 +1528,7 @@
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
-extern inline ssize_t do_generic_direct_read(struct file *, char *, size_t, loff_t *);
+extern ssize_t do_generic_direct_read(struct file *, char *, size_t, loff_t *);
 extern int precheck_file_write(struct file *, struct inode *, size_t *, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
--- 28p1/mm/filemap.c~	2004-04-14 16:05:41.000000000 +0300
+++ 28p1/mm/filemap.c	2004-08-23 20:04:20.000000000 +0300
@@ -1747,7 +1747,7 @@
 	return size;
 }
 
-inline ssize_t do_generic_direct_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
+ssize_t do_generic_direct_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
 {
 	ssize_t retval;
 	loff_t pos = *ppos;

--------------040406060704030302060203--
