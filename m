Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbREHOBW>; Tue, 8 May 2001 10:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132557AbREHOBC>; Tue, 8 May 2001 10:01:02 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:45578 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132553AbREHOA6>; Tue, 8 May 2001 10:00:58 -0400
Date: Tue, 8 May 2001 16:00:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: nfs MAP_SHARED corruption fix
Message-ID: <20010508160050.F543@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes corruption with MAP_SHARED on top of nfs filesystem in 2.4:

--- 2.4.5pre1aa2/fs/nfs/write.c.~1~	Tue May  1 19:35:29 2001
+++ 2.4.5pre1aa2/fs/nfs/write.c	Tue May  8 02:04:15 2001
@@ -1533,6 +1533,7 @@
 	if (!inode && file)
 		inode = file->f_dentry->d_inode;
 
+	filemap_fdatasync(inode->i_mapping);
 	do {
 		error = 0;
 		if (wait)

Andrea
