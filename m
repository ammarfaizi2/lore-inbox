Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSKNSJK>; Thu, 14 Nov 2002 13:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSKNSJK>; Thu, 14 Nov 2002 13:09:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:32385 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265051AbSKNSJJ>;
	Thu, 14 Nov 2002 13:09:09 -0500
Date: Thu, 14 Nov 2002 10:16:01 -0800
From: Bob Miller <rem@osdl.org>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [rem@osdl.org: [TRIVIAL PATCH 2.5.47] Fix char/raw.c to build as module]
Message-ID: <20021114181601.GA4542@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

Please don't apply this patch.  There's a bug in it. I'll send
the right version sortly.

TIA.

----- Forwarded message from Bob Miller <rem@osdl.org> -----

Date: 	Wed, 13 Nov 2002 14:25:54 -0800
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
From: Bob Miller <rem@osdl.org>
Subject: [TRIVIAL PATCH 2.5.47] Fix char/raw.c to build as module

Small fixes that lets the raw driver be built as a module.

diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Wed Nov 13 14:09:57 2002
+++ b/drivers/char/raw.c	Wed Nov 13 14:09:57 2002
@@ -103,7 +103,7 @@
 {
 	struct block_device *bdev = filp->private_data;
 
-	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
+	return ioctl_by_bdev(bdev->bd_inode, command, arg);
 }
 
 /*
@@ -241,3 +241,4 @@
 
 module_init(raw_init);
 module_exit(raw_exit);
+MODULE_LICENSE("GPL");
 
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
