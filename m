Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWHUEAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWHUEAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 00:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHUEAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 00:00:14 -0400
Received: from mail.dotsterhost.com ([72.5.54.21]:26284 "HELO
	mail.dotsterhost.com") by vger.kernel.org with SMTP id S932597AbWHUEAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 00:00:12 -0400
Date: Mon, 21 Aug 2006 12:00:04 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH] autofs4 - autofs4_follow_link false negative fix
Message-ID: <Pine.LNX.4.64.0608211149230.24684@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

The check for an empty directory in the autofs4_follow_link method fails 
occassionally due to old dentrys. We had the same problem 
autofs4_revalidate ages ago. I thought we wouldn't need this in 
autofs4_follow_link, silly me.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian

-- 

--- linux-2.6.18-rc4-mm1/fs/autofs4/root.c.follow_link-false-negative	2006-08-14 10:13:59.000000000 +0800
+++ linux-2.6.18-rc4-mm1/fs/autofs4/root.c	2006-08-14 10:15:26.000000000 +0800
@@ -359,7 +359,7 @@ static void *autofs4_follow_link(struct 
 	 * don't try to mount it again.
 	 */
 	spin_lock(&dcache_lock);
-	if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
+	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
 		spin_unlock(&dcache_lock);
 
 		status = try_to_fill_dentry(dentry, 0);
