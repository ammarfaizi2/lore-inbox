Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264619AbSJNLDA>; Mon, 14 Oct 2002 07:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264621AbSJNLDA>; Mon, 14 Oct 2002 07:03:00 -0400
Received: from [66.70.28.20] ([66.70.28.20]:19720 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S264619AbSJNLC5>; Mon, 14 Oct 2002 07:02:57 -0400
Date: Mon, 14 Oct 2002 13:07:03 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmap.c (do_mmap_pgoff) against 2.4.19/2.4.20-pre10, better format.
Message-ID: <20021014110703.GE381@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

    Hi all :))

    This time the patch is 'good looking', as per the warning Russell
issued over the format of the last patch (Thanks Russell ;)))

    Raúl

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Description: mmap.c.diff
Content-Disposition: attachment; filename="mmap.c.diff"

--- linux/mm/mmap.c.orig  2002-10-14 11:16:40.000000000 +0200
+++ linux/mm/mmap.c	      2002-10-14 11:19:32.000000000 +0200
@@ -390,6 +390,12 @@
 	return 0;
 }
 
+
+/*
+ *	NOTE: in this function we rely on TASK_SIZE being lower than
+ *	SIZE_MAX-PAGE_SIZE at least. I'm pretty sure that it is.
+ */
+
 unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long pgoff)
 {
@@ -403,12 +409,14 @@
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
 
-	if ((len = PAGE_ALIGN(len)) == 0)
+	if (!len)
 		return addr;
 
 	if (len > TASK_SIZE)
 		return -EINVAL;
 
+	len = PAGE_ALIGN(len);  /* This cannot be zero now */
+
 	/* offset overflow? */
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;

--k+w/mQv8wyuph6w0--
