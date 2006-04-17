Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWDQVff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWDQVff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWDQVfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:35:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:58337 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751324AbWDQVe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:34:57 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Ananiev@perch.kroah.org, Leonid I <leonid.i.ananiev@intel.com>,
       Leonid Ananiev <leonid.i.ananiev@intel.com>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/5] ext3: Fix missed mutex unlock
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 17 Apr 2006 14:33:37 -0700
Message-Id: <11453096191057-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.0.rc4.ge6bf
In-Reply-To: <11453096192835-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananiev, Leonid I <leonid.i.ananiev@intel.com>

Missed unlock_super()call is added in error condition code path.

Signed-off-by: Leonid Ananiev <leonid.i.ananiev@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/ext3/resize.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

75616cf9854b83eb83a968b1338ae0ee11c9673c
diff --git a/fs/ext3/resize.c b/fs/ext3/resize.c
index 14f5f6e..c5ffa85 100644
--- a/fs/ext3/resize.c
+++ b/fs/ext3/resize.c
@@ -767,6 +767,7 @@ int ext3_group_add(struct super_block *s
 	if (input->group != sbi->s_groups_count) {
 		ext3_warning(sb, __FUNCTION__,
 			     "multiple resizers run on filesystem!");
+		unlock_super(sb);
 		err = -EBUSY;
 		goto exit_journal;
 	}
-- 
1.2.6

