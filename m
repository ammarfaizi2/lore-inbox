Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbTBOWEA>; Sat, 15 Feb 2003 17:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTBOWEA>; Sat, 15 Feb 2003 17:04:00 -0500
Received: from www.indiadirect.com ([139.142.153.40]:41479 "EHLO
	silverpencil.com") by vger.kernel.org with ESMTP id <S265333AbTBOWD7>;
	Sat, 15 Feb 2003 17:03:59 -0500
From: "Sumankar Shankar" <sumankar@silverpencil.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 16 Feb 2003 03:40:43 +0530
Subject: [PATCH] isofs, 2.4.20
CC: marcelo@conectiva.com.br
Message-ID: <3E4F083B.22610.1AB6DD@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is this annoying bug in isofs in 2.4.19 and 2.4.20
that makes it impossible to read most udf written discs
that have been closed as iso9660. Its not a problem in
2.2.x but dont know when in 2.4 it came about. Dunno
if its fixed in 2.4.21-prewhatever but I didnt see any activity
about it in lkml, so the patch is here:

--- linux/fs/isofs/inode.c	Sun Feb 16 03:06:39 2003
+++ linux/fs/isofs-mankar/inode.c	Sun Feb 16 03:08:34 2003
@@ -939,7 +939,7 @@
 				if (!ninode)
 					goto abort;
 				firstext  = ninode->u.isofs_i.i_first_extent;
-				sect_size = ninode->u.isofs_i.i_section_size;
+				sect_size = ninode->u.isofs_i.i_section_size >> ISOFS_BUFFER_BITS(inode);
 				nextino   = ninode->u.isofs_i.i_next_section_ino;
 				iput(ninode);

[The patch is for 2.4.19 but Im quite sure it works
with 2.4.20 too.  The error is because iso9660 level 3 
support for handling files with more than 2 extents is 
badly handled.]

-Mankar
