Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263734AbUEGUIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbUEGUIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUEGUG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:06:27 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:45837 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263731AbUEGUFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:05:23 -0400
Date: Fri, 7 May 2004 12:34:37 -0500
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cpqarray update for 2.6
Message-ID: <20040507173437.GA6020@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes 2 minor issues that break our Array Configuration utility.
my_io was changed to a pointer so the & had to removed when using it with copy_to_user().
Sometime in 2.5 SG_MAX got changed to 31. Maybe to copy cciss? Now I'm changing it back to 32 so our app can work.
Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
 cpqarray.c |    2 +-
 ida_cmd.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -burpN lx266-rc2.orig/drivers/block/cpqarray.c lx266-rc2-cpqarray/drivers/block/cpqarray.c
--- lx266-rc2.orig/drivers/block/cpqarray.c	2004-04-03 21:36:24.000000000 -0600
+++ lx266-rc2-cpqarray/drivers/block/cpqarray.c	2004-05-05 10:55:16.000000000 -0500
@@ -1193,7 +1193,7 @@ static int ida_ioctl(struct inode *inode
 		if (error)
 			goto out_passthru;
 		error = -EFAULT;
-		if (copy_to_user(io, &my_io, sizeof(*my_io)))
+		if (copy_to_user(io, my_io, sizeof(*my_io)))
 			goto out_passthru;
 		error = 0;
 out_passthru:
diff -burpN lx266-rc2.orig/drivers/block/ida_cmd.h lx266-rc2-cpqarray/drivers/block/ida_cmd.h
--- lx266-rc2.orig/drivers/block/ida_cmd.h	2004-04-03 21:36:54.000000000 -0600
+++ lx266-rc2-cpqarray/drivers/block/ida_cmd.h	2004-05-05 10:53:59.000000000 -0500
@@ -67,7 +67,7 @@ typedef struct {
 	__u8	reserved;
 } rhdr_t;
 
-#define SG_MAX			31
+#define SG_MAX			32
 typedef struct {
 	rhdr_t	hdr;
 	sg_t	sg[SG_MAX];
