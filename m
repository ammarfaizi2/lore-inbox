Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTB0X3n>; Thu, 27 Feb 2003 18:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTB0X3n>; Thu, 27 Feb 2003 18:29:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:15232 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267335AbTB0X3m>;
	Thu, 27 Feb 2003 18:29:42 -0500
Date: Thu, 27 Feb 2003 15:39:52 -0800
From: Bob Miller <rem@osdl.org>
To: dm@uk.sistina.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL PATCH 2.5.63] Fix compiler error in dm-ioctl.c
Message-ID: <20030227233952.GB4391@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds missing second argument to a new kmalloc() call.
 
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
--- a/drivers/md/dm-ioctl.c	Thu Feb 27 15:32:46 2003
+++ b/drivers/md/dm-ioctl.c	Thu Feb 27 15:32:46 2003
@@ -174,7 +174,7 @@
 static int register_with_devfs(struct hash_cell *hc)
 {
 	struct gendisk *disk = dm_disk(hc->md);
-	char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1);
+	char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1, GFP_KERNEL);
 	if (!name) {
 		return -ENOMEM;
 	}
