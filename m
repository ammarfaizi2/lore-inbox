Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263045AbSJNJbh>; Mon, 14 Oct 2002 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbSJNJbh>; Mon, 14 Oct 2002 05:31:37 -0400
Received: from [66.70.28.20] ([66.70.28.20]:13063 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S263045AbSJNJbg>; Mon, 14 Oct 2002 05:31:36 -0400
Date: Mon, 14 Oct 2002 11:36:22 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] mmap.c (do_mmap_pgoff), against 2.4.19 and 2.4.20-pre10
Message-ID: <20021014093622.GA96@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

    Hi all, specially Marcelo :)

    This is the fourth and last time I submit this patch to Marcelo.
This little tiny bug is fixed in all trees except the official one. I
think this patch is trivial enough to be accepted, but...

    Well, the attachments included (unified diff format), is the patch
against both 2.4.19 and 2.4.20-pre10 (I've changed the kernel name
directory part to '/usr/src/linux/' so it's applicable to both
versions.

    Marcelo, if you don't want to include this patch at least let me
know, please, so I won't need to see each new prerelease for seeing
if the patch has been already included ;))) Don't take it bad.

    Raúl

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Description: mmap.c.diff
Content-Disposition: attachment; filename="mmap.c.diff"

--- /usr/src/linux/mm/mmap.c.orig	2002-10-14 11:16:40.000000000 +0200
+++ /usr/src/linux/kernel/mm/mmap.c	2002-10-14 11:19:32.000000000 +0200
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

--lrZ03NoBR/3+SXJZ--
