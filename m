Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbVLOMZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbVLOMZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbVLOMZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:25:29 -0500
Received: from [218.25.172.144] ([218.25.172.144]:32787 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1422699AbVLOMZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:25:28 -0500
Date: Thu, 15 Dec 2005 20:25:27 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: torvalds@osdl.org
Cc: willy@debian.org, arnd@arndb.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, debian-glibc@lists.debian.org
Subject: [patch] ioctl BLKGETSIZE64 fix
Message-ID: <20051215122527.GA7762@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Two years ago, "[PATCH] use size_t for the broken ioctl numbers" brought in the problem.
<http://lkml.org/lkml/2003/9/7/14> (also FYI: <https://lwn.net/Articles/48360/>)

The patch below fixes the bug on BLKGETSIZE64. typeof(size_t) == 32, but we expect 64. 
The choice of `size_t' is also a mistake. We should have taken `int'.  This also affects
userland linux-kernel-headers.

Or am I missing something? Thanks.

	Coywolf

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---
diff -pruN 2.6.15-rc5-mm3/include/linux/fs.h 2.6.15-rc5-mm3~BLKGETSIZE64-fix/include/linux/fs.h
--- 2.6.15-rc5-mm3/include/linux/fs.h	2005-12-15 16:55:22.000000000 +0800
+++ 2.6.15-rc5-mm3~BLKGETSIZE64-fix/include/linux/fs.h	2005-12-15 20:08:52.000000000 +0800
@@ -197,7 +197,7 @@ extern int dir_notify_enable;
 /* A jump here: 108-111 have been used for various private purposes. */
 #define BLKBSZGET  _IOR(0x12,112,size_t)
 #define BLKBSZSET  _IOW(0x12,113,size_t)
-#define BLKGETSIZE64 _IOR(0x12,114,size_t)	/* return device size in bytes (u64 *arg) */
+#define BLKGETSIZE64 _IOR(0x12,114,u64)	/* return device size in bytes (u64 *arg) */
 #define BLKSTARTTRACE _IOWR(0x12,115,struct blk_user_trace_setup)
 #define BLKSTOPTRACE _IO(0x12,116)
 
