Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271675AbTGRBvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 21:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271678AbTGRBvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 21:51:51 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:17888 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271675AbTGRBvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 21:51:50 -0400
Subject: [PATCH] fix info leak
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1058493468.733.55.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jul 2003 21:57:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a better fix for the kernel stack data
leaking out into user-space. (due to padding)
This fix takes advantage of the fact that an i386
machine is little-endian. The type of st_rdev may
be widened to fill the gap, causing the extra 2
bytes to get zeroed when st_rdev is written to.

Everybody: use -Wpadded to find these

--- old/include/asm-i386/stat.h	2003-06-26 17:50:47.000000000 -0400
+++ new/include/asm-i386/stat.h	2003-07-17 18:23:01.000000000 -0400
@@ -9,6 +9,6 @@
 	unsigned short st_uid;
 	unsigned short st_gid;
-	unsigned short st_rdev;
+	unsigned int   st_rdev;
 	unsigned long  st_size;
 	unsigned long  st_atime;
 	unsigned long  st_mtime;



