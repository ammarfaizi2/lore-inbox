Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWBCBYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWBCBYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWBCBYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:24:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42200 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932325AbWBCBYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:24:12 -0500
Date: Thu, 2 Feb 2006 20:24:05 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: More imformative message on umount failure.
Message-ID: <20060203012405.GA7306@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had a user trigger this message on a box that had a lot
of different mounts, all with different options.
It might help narrow down wtf happened if we print out
which device failed.

Signed-off-by: Dave Jones <davej@redhat.com>

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
