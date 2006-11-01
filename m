Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946304AbWKAKht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946304AbWKAKht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946761AbWKAKht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:37:49 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:61047 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946304AbWKAKht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:37:49 -0500
Message-ID: <454878ED.1080405@sw.ru>
Date: Wed, 01 Nov 2006 13:37:33 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Blunck <jblunck@suse.de>,
       Alexander Viro <viro@zeniv.linux.org.uk>
CC: devel@openvz.org
Subject: [PATCH 2.6.19-rc3] VFS: extra check inside dentry_unhash()
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:	Vasily Averin <vvs@sw.ru>

d_count check after dget() is always true

Signed-off-by:	Vasily Averin <vvs@sw.ru>

--- linux-2.6.19-rc3-mm1/fs/namei.c.duhsh	2006-10-30 14:20:19.000000000 +0300
+++ linux-2.6.19-rc3-mm1/fs/namei.c	2006-11-01 13:17:17.000000000 +0300
@@ -1993,8 +1993,7 @@ asmlinkage long sys_mkdir(const char __u
 void dentry_unhash(struct dentry *dentry)
 {
 	dget(dentry);
-	if (atomic_read(&dentry->d_count))
-		shrink_dcache_parent(dentry);
+	shrink_dcache_parent(dentry);
 	spin_lock(&dcache_lock);
 	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count) == 2)


