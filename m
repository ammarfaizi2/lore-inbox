Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbULZQo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbULZQo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbULZQo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:44:59 -0500
Received: from zux191-241.adsl.green.ch ([80.254.191.241]:26383 "EHLO
	oribi.org") by vger.kernel.org with ESMTP id S261705AbULZQot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:44:49 -0500
Message-ID: <41CEDC3B.4040107@oribi.org>
Date: Sun, 26 Dec 2004 16:43:55 +0100
From: Markus Amsler <markus.amsler@oribi.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, urban@teststation.com
Subject: [PATCH] smbfs: fix debug compile
Content-Type: multipart/mixed;
 boundary="------------000304060606020502030203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304060606020502030203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Compiling of fs/smbfs failes (gcc version 3.3.4) if you enable 
DSMBFS_DEBUG_VERBOSE in fs/smbfs/Makefile.This patch is against 2.610 
kernel.

Markus Amsler

--------------000304060606020502030203
Content-Type: text/plain;
 name="smbfs_debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smbfs_debug.diff"

diff -ru 2.6.10/fs/smbfs/file.c dev/fs/smbfs/file.c
--- 2.6.10/fs/smbfs/file.c	2004-12-24 22:35:27.000000000 +0100
+++ dev/fs/smbfs/file.c	2004-12-25 14:20:48.000000000 +0100
@@ -232,7 +232,7 @@
 
 	VERBOSE("before read, size=%ld, flags=%x, atime=%ld\n",
 		(long)dentry->d_inode->i_size,
-		dentry->d_inode->i_flags, dentry->d_inode->i_atime);
+		dentry->d_inode->i_flags, dentry->d_inode->i_atime.tv_sec);
 
 	status = generic_file_read(file, buf, count, ppos);
 out:
@@ -342,7 +342,7 @@
 		result = generic_file_write(file, buf, count, ppos);
 		VERBOSE("pos=%ld, size=%ld, mtime=%ld, atime=%ld\n",
 			(long) file->f_pos, (long) dentry->d_inode->i_size,
-			dentry->d_inode->i_mtime, dentry->d_inode->i_atime);
+			dentry->d_inode->i_mtime.tv_sec, dentry->d_inode->i_atime.tv_sec);
 	}
 out:
 	return result;
diff -ru 2.6.10/fs/smbfs/inode.c dev/fs/smbfs/inode.c
--- 2.6.10/fs/smbfs/inode.c	2004-12-24 22:34:00.000000000 +0100
+++ dev/fs/smbfs/inode.c	2004-12-25 14:18:31.000000000 +0100
@@ -216,7 +216,7 @@
 	if (inode->i_mtime.tv_sec != last_time || inode->i_size != last_sz) {
 		VERBOSE("%ld changed, old=%ld, new=%ld, oz=%ld, nz=%ld\n",
 			inode->i_ino,
-			(long) last_time, (long) inode->i_mtime,
+			(long) last_time, (long) inode->i_mtime.tv_sec,
 			(long) last_sz, (long) inode->i_size);
 
 		if (!S_ISDIR(inode->i_mode))
diff -ru 2.6.10/fs/smbfs/proc.c dev/fs/smbfs/proc.c
--- 2.6.10/fs/smbfs/proc.c	2004-12-24 22:34:00.000000000 +0100
+++ dev/fs/smbfs/proc.c	2004-12-25 14:22:01.000000000 +0100
@@ -2593,7 +2593,7 @@
 	fattr->f_mtime.tv_sec = date_dos2unix(server, date, time);
 	fattr->f_mtime.tv_nsec = 0;
 	VERBOSE("name=%s, date=%x, time=%x, mtime=%ld\n",
-		mask, date, time, fattr->f_mtime);
+		mask, date, time, fattr->f_mtime.tv_sec);
 	fattr->f_size = DVAL(req->rq_data, 12);
 	/* ULONG allocation size */
 	fattr->attr = WVAL(req->rq_data, 20);

--------------000304060606020502030203--
