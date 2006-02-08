Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWBHUBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWBHUBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWBHUBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:01:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36049 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030367AbWBHUBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:01:39 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] Revert "[PATCH] aty: remove unnecessary CONFIG_PCI"
Cc: adaplas@pol.net
Message-Id: <E1F6vVS-0008BY-JX@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:01:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1137633692 -0500

This reverts 8416131ded5e491ecc2947d1ffaedf64725bb7a3 commit.

The hell it was unnecessary - atyfb_driver is undefined if we don't
have CONFIG_PCI and pci_register_driver() is always an inline, so
it cares for arguments being sane.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/video/aty/atyfb_base.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

f2dba384a7e37d0770256e5e947fc0292c339013
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 485be38..c02a0f4 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3719,7 +3719,9 @@ static int __init atyfb_init(void)
     atyfb_setup(option);
 #endif
 
+#ifdef CONFIG_PCI
     pci_register_driver(&atyfb_driver);
+#endif
 #ifdef CONFIG_ATARI
     atyfb_atari_probe();
 #endif
@@ -3728,7 +3730,9 @@ static int __init atyfb_init(void)
 
 static void __exit atyfb_exit(void)
 {
+#ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
+#endif
 }
 
 module_init(atyfb_init);
-- 
0.99.9.GIT

