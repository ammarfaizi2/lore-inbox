Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263447AbTC2SD5>; Sat, 29 Mar 2003 13:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263448AbTC2SD5>; Sat, 29 Mar 2003 13:03:57 -0500
Received: from smtp02.web.de ([217.72.192.151]:45578 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S263447AbTC2SD4> convert rfc822-to-8bit;
	Sat, 29 Mar 2003 13:03:56 -0500
Date: Sat, 29 Mar 2003 19:26:16 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [TRIVIAL] Cleanup in fs/devpts/inode.c
Message-Id: <20030329192616.72a397a4.l.s.r@web.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch un-complicates a small piece of code of the dev/pts
filesystem and decreases the size of the object code by 8 bytes
for my build. Yay! :)

René


--- linux-2.5.66/fs/devpts/inode.c.orig	2003-01-17 13:54:26.000000000 +0100
+++ linux-2.5.66/fs/devpts/inode.c	2003-03-22 14:09:40.000000000 +0100
@@ -170,9 +170,8 @@
 	int err = register_filesystem(&devpts_fs_type);
 	if (!err) {
 		devpts_mnt = kern_mount(&devpts_fs_type);
-		err = PTR_ERR(devpts_mnt);
-		if (!IS_ERR(devpts_mnt))
-			err = 0;
+		if (IS_ERR(devpts_mnt))
+			err = PTR_ERR(devpts_mnt);
 	}
 	return err;
 }
