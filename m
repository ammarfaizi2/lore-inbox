Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264713AbTIJIdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbTIJIdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:33:06 -0400
Received: from dp.samba.org ([66.70.73.150]:36249 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264713AbTIJIdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:33:03 -0400
Date: Wed, 10 Sep 2003 18:29:16 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix initramfs permissions on directories and special files
Message-ID: <20030910082916.GE1532@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set correct permissions on initramfs directories and special files. We dont
want to obey the umask here, so do the same thing we do on normal files -
call sys_chmod.


 work-anton/init/initramfs.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN init/initramfs.c~initramfs-fix init/initramfs.c
--- work/init/initramfs.c~initramfs-fix	2003-09-10 03:11:58.000000000 -0500
+++ work-anton/init/initramfs.c	2003-09-10 03:11:58.000000000 -0500
@@ -260,11 +260,13 @@ static int __init do_name(void)
 	} else if (S_ISDIR(mode)) {
 		sys_mkdir(collected, mode);
 		sys_chown(collected, uid, gid);
+		sys_chmod(collected, mode);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
 			sys_mknod(collected, mode, rdev);
 			sys_chown(collected, uid, gid);
+			sys_chmod(collected, mode);
 		}
 	} else
 		panic("populate_root: bogus mode: %o\n", mode);

_
