Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315291AbSEADlg>; Tue, 30 Apr 2002 23:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315292AbSEADlg>; Tue, 30 Apr 2002 23:41:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21749 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315291AbSEADlf>;
	Tue, 30 Apr 2002 23:41:35 -0400
Date: Tue, 30 Apr 2002 23:41:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing checks in exec_permission_light()
Message-ID: <Pine.GSO.4.21.0204302340340.10523-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Missing checks added...

diff -urN C12-0/fs/namei.c C12-current/fs/namei.c
--- C12-0/fs/namei.c	Tue Apr 30 20:23:38 2002
+++ C12-current/fs/namei.c	Tue Apr 30 23:37:15 2002
@@ -324,6 +324,12 @@
 	if (mode & MAY_EXEC)
 		return 0;
 
+	if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
+		return 0;
+
+	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
+		return 0;
+
 	return -EACCES;
 }
 

