Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290666AbSA3WNk>; Wed, 30 Jan 2002 17:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290664AbSA3WNc>; Wed, 30 Jan 2002 17:13:32 -0500
Received: from zero.tech9.net ([209.61.188.187]:13586 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290656AbSA3WNC>;
	Wed, 30 Jan 2002 17:13:02 -0500
Subject: [PATCH] Re: 2.5.3 Link Error
From: Robert Love <rml@tech9.net>
To: John Weber <weber@nyc.rr.com>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C586D98.5090900@nyc.rr.com>
In-Reply-To: <3C586D98.5090900@nyc.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 30 Jan 2002 17:18:46 -0500
Message-Id: <1012429142.3392.79.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iOn Wed, 2002-01-30 at 17:03, John Weber wrote:
>          -o vmlinux
> fs/fs.o: In function `cap_info_llseek':
> fs/fs.o(.text+0x4e1d1): undefined reference to `lock_kernel'
> fs/fs.o(.text+0x4e220): undefined reference to `unlock_kernel'
> fs/fs.o: In function `hdr_llseek':
> fs/fs.o(.text+0x4e858): undefined reference to `lock_kernel'
> fs/fs.o(.text+0x4e8b6): undefined reference to `unlock_kernel'
> make: *** [vmlinux] Error 1

Whoops, missed that in the BKL removal patch.  This should fix it.

Linus, please apply.

	Robert Love

diff -urN linux-2.5.3/fs/hfs/file_cap.c linux/fs/hfs/file_cap.c
--- linux-2.5.3/fs/hfs/file_cap.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/hfs/file_cap.c	Wed Jan 30 17:08:09 2002
@@ -24,6 +24,7 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
+#include <linux/smp_lock.h>
 
 /*================ Forward declarations ================*/
 static loff_t      cap_info_llseek(struct file *, loff_t,
diff -urN linux-2.5.3/fs/hfs/file_hdr.c linux/fs/hfs/file_hdr.c
--- linux-2.5.3/fs/hfs/file_hdr.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/hfs/file_hdr.c	Wed Jan 30 17:10:31 2002
@@ -29,6 +29,7 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
+#include <linux/smp_lock.h>
 
 /* prodos types */
 #define PRODOSI_FTYPE_DIR   0x0F

