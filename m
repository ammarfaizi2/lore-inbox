Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWIZFld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWIZFld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWIZFlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:41:05 -0400
Received: from ns.suse.de ([195.135.220.2]:1250 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751294AbWIZFkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:18 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 42/47] sysfs: add proper sysfs_init() prototype
Date: Mon, 25 Sep 2006 22:38:02 -0700
Message-Id: <11592492193773-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592492153066-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Don't be crufty.  Mark it __must_check too.

Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/namespace.c        |   10 +---------
 include/linux/sysfs.h |    7 +++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fa7ed6a..36d1808 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -17,6 +17,7 @@ #include <linux/quotaops.h>
 #include <linux/acct.h>
 #include <linux/capability.h>
 #include <linux/module.h>
+#include <linux/sysfs.h>
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 #include <linux/namei.h>
@@ -28,15 +29,6 @@ #include "pnode.h"
 
 extern int __init init_rootfs(void);
 
-#ifdef CONFIG_SYSFS
-extern int __init sysfs_init(void);
-#else
-static inline int sysfs_init(void)
-{
-	return 0;
-}
-#endif
-
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
 
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 02ad790..6d5c43d 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -123,6 +123,8 @@ int __must_check sysfs_create_group(stru
 void sysfs_remove_group(struct kobject *, const struct attribute_group *);
 void sysfs_notify(struct kobject * k, char *dir, char *attr);
 
+extern int __must_check sysfs_init(void);
+
 #else /* CONFIG_SYSFS */
 
 static inline int sysfs_create_dir(struct kobject * k)
@@ -194,6 +196,11 @@ static inline void sysfs_notify(struct k
 {
 }
 
+static inline int __must_check sysfs_init(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SYSFS */
 
 #endif /* _SYSFS_H_ */
-- 
1.4.2.1

