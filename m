Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267192AbSLaHuA>; Tue, 31 Dec 2002 02:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbSLaHuA>; Tue, 31 Dec 2002 02:50:00 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:46029 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267192AbSLaHtz>; Tue, 31 Dec 2002 02:49:55 -0500
Date: Mon, 30 Dec 2002 23:43:49 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Enable compilation of fs/readdir.c for gcc 2.95.2
Message-ID: <20021230234349.F628@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Spam-Score: -1.7 (-)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18THI3-0006mC-00*jP4R/m9JoUc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

if you also have problems compiling 2.5.5x, then your compiler is
too old as is mine.

Anyway, since I don't like to upgrade now, I hacked the offending
file fs/readdir.c and can compile a kernel again ;-)

Have fun!

Ingo Oeser

diff -Naur linux-2.5.53-mm2/fs/readdir.c linux-2.5.53-mm2-ioe/fs/readdir.c
--- linux-2.5.53-mm2/fs/readdir.c	Fri Dec 27 13:49:53 2002
+++ linux-2.5.53-mm2-ioe/fs/readdir.c	Mon Dec 30 21:51:53 2002
@@ -134,18 +134,18 @@
 		return -EINVAL;
 	dirent = buf->previous;
 	if (dirent) {
-		if (__put_user(offset, &dirent->d_off))
+		if (put_user(offset, &dirent->d_off))
 			goto efault;
 	}
 	dirent = buf->current_dir;
 	buf->previous = dirent;
-	if (__put_user(ino, &dirent->d_ino))
+	if (put_user(ino, &dirent->d_ino))
 		goto efault;
-	if (__put_user(reclen, &dirent->d_reclen))
+	if (put_user(reclen, &dirent->d_reclen))
 		goto efault;
 	if (copy_to_user(dirent->d_name, name, namlen))
 		goto efault;
-	if (__put_user(0, dirent->d_name + namlen))
+	if (put_user(0, dirent->d_name + namlen))
 		goto efault;
 	((char *) dirent) += reclen;
 	buf->current_dir = dirent;
@@ -226,22 +226,22 @@
 		return -EINVAL;
 	dirent = buf->previous;
 	if (dirent) {
-		if (__put_user(offset, &dirent->d_off))
+		if (put_user(offset, &dirent->d_off))
 			goto efault;
 	}
 	dirent = buf->current_dir;
 	buf->previous = dirent;
-	if (__put_user(ino, &dirent->d_ino))
+	if (put_user(ino, &dirent->d_ino))
 		goto efault;
-	if (__put_user(0, &dirent->d_off))
+	if (put_user(0, &dirent->d_off))
 		goto efault;
-	if (__put_user(reclen, &dirent->d_reclen))
+	if (put_user(reclen, &dirent->d_reclen))
 		goto efault;
-	if (__put_user(d_type, &dirent->d_type))
+	if (put_user(d_type, &dirent->d_type))
 		goto efault;
 	if (copy_to_user(dirent->d_name, name, namlen))
 		goto efault;
-	if (__put_user(0, dirent->d_name + namlen))
+	if (put_user(0, dirent->d_name + namlen))
 		goto efault;
 	((char *) dirent) += reclen;
 	buf->current_dir = dirent;
@@ -280,7 +280,9 @@
 	if (lastdirent) {
 		struct linux_dirent64 d;
 		d.d_off = file->f_pos;
-		__put_user(d.d_off, &lastdirent->d_off);
+		error = -EFAULT;
+		if (put_user(d.d_off, &lastdirent->d_off))
+			goto out;
 		error = count - buf.count;
 	}
 

-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
