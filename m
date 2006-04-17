Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWDQVff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWDQVff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDQVfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:35:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:58593 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751315AbWDQVe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:34:57 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/5] Fix block device symlink name
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 17 Apr 2006 14:33:36 -0700
Message-Id: <11453096192835-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.0.rc4.ge6bf
In-Reply-To: <11453096194144-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>

As noted further on the this file, some block devices have a / in their
name, so fix the "block:..." symlink name the same as the /sys/block name.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/partitions/check.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

2436f039d26a91e5404974ee0cb789b17db46168
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index f3b6af0..45ae7dd 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -372,6 +372,7 @@ static char *make_block_name(struct gend
 	char *name;
 	static char *block_str = "block:";
 	int size;
+	char *s;
 
 	size = strlen(block_str) + strlen(disk->disk_name) + 1;
 	name = kmalloc(size, GFP_KERNEL);
@@ -379,6 +380,10 @@ static char *make_block_name(struct gend
 		return NULL;
 	strcpy(name, block_str);
 	strcat(name, disk->disk_name);
+	/* ewww... some of these buggers have / in name... */
+	s = strchr(name, '/');
+	if (s)
+		*s = '!';
 	return name;
 }
 
-- 
1.2.6

