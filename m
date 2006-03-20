Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030581AbWCTWJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbWCTWJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030549AbWCTWBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:1978 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030550AbWCTWBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:21 -0500
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 23/23] sysfs: fix a kobject leak in sysfs_add_link on the error path
In-Reply-To: <11428920391737-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:39 -0800
Message-Id: <11428920393593-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Oliver Neukum.

Cc: Maneesh Soni <maneesh@in.ibm.com>
Cc: Oliver Neukum <oliver@neukum.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/sysfs/symlink.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

b3229087c5e08589cea4f5040dab56f7dc11332a
diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index fe23f47..d2eac3c 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -66,6 +66,7 @@ static int sysfs_add_link(struct dentry 
 	if (!error)
 		return 0;
 
+	kobject_put(target);
 	kfree(sl->link_name);
 exit2:
 	kfree(sl);
-- 
1.2.4


