Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbTLIJuE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTLIJuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:50:00 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:37357 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S264354AbTLIJtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:49:15 -0500
Date: Tue, 09 Dec 2003 10:47:32 +0100
From: Domen Puncer <domen@coderock.org>
Subject: [PATCH 2.4.23, 2.6.0-test11] fix d_type in readdir in isofs
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200312091047.33015.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Played with scandir, and noticed iso9660's files d_type is always 0,
so here's a fix.

If there are no objections i'll try to fix some other filesystems too.

2.6.0-test11:
--- c/fs/isofs/dir.c	2003-08-23 01:58:53.000000000 +0200
+++ a/fs/isofs/dir.c	2003-12-09 10:29:21.000000000 +0100
@@ -230,7 +230,8 @@
 			}
 		}
 		if (len > 0) {
-			if (filldir(dirent, p, len, filp->f_pos, inode_number, DT_UNKNOWN) < 0)
+			if (filldir(dirent, p, len, filp->f_pos, inode_number,
+					(de->flags[0]&2)?DT_DIR:DT_REG) < 0)
 				break;
 		}
 		filp->f_pos += de_len;


2.4.23:
--- linux-2.4.23-clean/fs/isofs/dir.c	2002-02-25 20:38:08.000000000 +0100
+++ linux-2.4.23/fs/isofs/dir.c	2003-12-09 10:28:58.000000000 +0100
@@ -230,7 +230,8 @@
 			}
 		}
 		if (len > 0) {
-			if (filldir(dirent, p, len, filp->f_pos, inode_number, DT_UNKNOWN) < 0)
+			if (filldir(dirent, p, len, filp->f_pos, inode_number,
+					(de->flags[0]&2)?DT_DIR:DT_REG) < 0)
 				break;
 		}
 		filp->f_pos += de_len;

