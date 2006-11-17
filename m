Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424768AbWKQFlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424768AbWKQFlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424770AbWKQFlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:41:46 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:895 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1162376AbWKQFll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:41:41 -0500
Date: Thu, 16 Nov 2006 21:36:00 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: pavel@suse.cz, akpm <akpm@osdl.org>
Subject: [PATCH -mm] freeze/thaw fs when BLOCK=n
Message-Id: <20061116213600.9983f4f9.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix freeze/thaw filesystems with CONFIG_BLOCK disabled:
kernel/power/process.c:124: warning: implicit declaration of function 'freeze_fil
esystems'
kernel/power/process.c:189: warning: implicit declaration of function 'thaw_files
ystems'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/linux/buffer_head.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2619-rc5mm2.orig/include/linux/buffer_head.h
+++ linux-2619-rc5mm2/include/linux/buffer_head.h
@@ -314,7 +314,8 @@ static inline void invalidate_inode_buff
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
 static inline void invalidate_bdev(struct block_device *bdev, int destroy_dirty_buffers) {}
-
+static inline void freeze_filesystems(void) {}
+static inline void thaw_filesystems(void) {}
 
 #endif /* CONFIG_BLOCK */
 #endif /* _LINUX_BUFFER_HEAD_H */


---
