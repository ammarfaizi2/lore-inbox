Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWJITYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWJITYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWJITYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:24:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23712 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751897AbWJITYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:24:50 -0400
Date: Mon, 9 Oct 2006 20:24:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] wrong order of arguments in copy_to_user() in ncpfs
Message-ID: <20061009192449.GS29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ncpfs/ioctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ncpfs/ioctl.c b/fs/ncpfs/ioctl.c
index a89ac84..589d1ea 100644
--- a/fs/ncpfs/ioctl.c
+++ b/fs/ncpfs/ioctl.c
@@ -726,7 +726,7 @@ #ifdef CONFIG_COMPAT
 				struct compat_ncp_privatedata_ioctl user32;
 				user32.len = user.len;
 				user32.data = (unsigned long) user.data;
-				if (copy_to_user(&user32, argp, sizeof(user32)))
+				if (copy_to_user(argp, &user32, sizeof(user32)))
 					return -EFAULT;
 			} else
 #endif
-- 
1.4.2.GIT

