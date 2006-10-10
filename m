Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWJJG6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWJJG6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWJJG6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:58:15 -0400
Received: from havoc.gtf.org ([69.61.125.42]:8078 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965043AbWJJG6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:58:15 -0400
Date: Tue, 10 Oct 2006 02:58:14 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Douglas_Warzecha@dell.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware/dcdbas: fix bug in error cleanup
Message-ID: <20061010065814.GA21747@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The error path path mistakenly called sysfs_create_group() rather than
sysfs_remove_group().  They take the same arguments, so it's easy to
cut-n-paste such a bug.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/firmware/dcdbas.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

36ed9d7acc1c6df0c9f1083e1df729631339a3d8
diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
index 339f405..8bcb58c 100644
--- a/drivers/firmware/dcdbas.c
+++ b/drivers/firmware/dcdbas.c
@@ -559,7 +559,7 @@ static int __devinit dcdbas_probe(struct
 			while (--i >= 0)
 				sysfs_remove_bin_file(&dev->dev.kobj,
 						      dcdbas_bin_attrs[i]);
-			sysfs_create_group(&dev->dev.kobj, &dcdbas_attr_group);
+			sysfs_remove_group(&dev->dev.kobj, &dcdbas_attr_group);
 			return error;
 		}
 	}
