Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbTBGAFE>; Thu, 6 Feb 2003 19:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTBGAFE>; Thu, 6 Feb 2003 19:05:04 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:39933 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267588AbTBGAFD>; Thu, 6 Feb 2003 19:05:03 -0500
Date: Thu, 6 Feb 2003 16:13:59 -0800
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: greg@kroah.com, akpm@digeo.com, sds@epoch.ncsc.mil,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Remove duplicate LSM hooks in sendfile
Message-ID: <20030206161359.A2515@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>, greg@kroah.com,
	akpm@digeo.com, sds@epoch.ncsc.mil, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Somehow the patch to restore the LSM hooks in sendfile got submitted by
Andrew twice (csets 1.974.1.7 and 1.947.32.14 in the current 2.5-bk).
This patch removes the duplication.  Thanks to Stephen Rothwell for
noting this.

Thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


===== fs/read_write.c 1.27 vs edited =====
--- 1.27/fs/read_write.c	Wed Feb  5 20:04:28 2003
+++ edited/fs/read_write.c	Thu Feb  6 16:10:53 2003
@@ -535,10 +535,6 @@
 	if (retval)
 		goto fput_in;
 
-	retval = security_file_permission (in_file, MAY_READ);
-	if (retval)
-		goto fput_in;
-
 	/*
 	 * Get output file, and verify that it is ok..
 	 */
@@ -553,10 +549,6 @@
 		goto fput_out;
 	out_inode = out_file->f_dentry->d_inode;
 	retval = locks_verify_area(FLOCK_VERIFY_WRITE, out_inode, out_file, out_file->f_pos, count);
-	if (retval)
-		goto fput_out;
-
-	retval = security_file_permission (out_file, MAY_WRITE);
 	if (retval)
 		goto fput_out;
 
