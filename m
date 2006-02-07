Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWBGOYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWBGOYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWBGOYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:24:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9740 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965090AbWBGOY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:24:29 -0500
Date: Tue, 7 Feb 2006 15:24:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] More informative message on umount failure.
Message-ID: <20060207142428.GG5937@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had a user trigger this message on a box that had a lot
of different mounts, all with different options.
It might help narrow down wtf happened if we print out
which device failed.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Dave Jones on:
- 2 Feb 2006

--- linux-2.6.15.noarch/fs/super.c~	2006-02-02 20:19:20.000000000 -0500
+++ linux-2.6.15.noarch/fs/super.c	2006-02-02 20:20:02.000000000 -0500
@@ -247,8 +247,9 @@ void generic_shutdown_super(struct super
 
 		/* Forget any remaining inodes */
 		if (invalidate_inodes(sb)) {
-			printk("VFS: Busy inodes after unmount. "
-			   "Self-destruct in 5 seconds.  Have a nice day...\n");
+			printk("VFS: Busy inodes after unmount of %s. "
+			   "Self-destruct in 5 seconds.  Have a nice day...\n",
+			   sb->s_id);
 		}
 
 		unlock_kernel();
