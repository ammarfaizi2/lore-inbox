Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVASUng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVASUng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVASUng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:43:36 -0500
Received: from main.gmane.org ([80.91.229.2]:20716 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261884AbVASUnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:43:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] AOE: fix up the block device registration so that it
 actually works now.
Date: Wed, 19 Jan 2005 15:43:02 -0500
Message-ID: <87mzv5m9pl.fsf@coraid.com>
References: <20050119000935.GA22454@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-214-28-36.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:dgobE2Ajx64PAvPppnl6fndCpOs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Greg KH <greg@kroah.com> writes:

> Ed, I need the following patch against the latest -bk tree in order to
> get the aoe code to load and work properly.  Does it look good to you?

I hadn't submitted all my changes correctly, sorry.  Here's a patch
against block-2.6 that rectifies the omission.


Remove allow aoeblk_exit to be called from __init code, and move
register_blkdev into aoe_init.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=diff-block-2.6

diff -uprN block-2.6-export-a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- block-2.6-export-a/drivers/block/aoe/aoeblk.c	2005-01-19 14:29:31.000000000 -0500
+++ patch-block-2.6-20050119-export/linux/drivers/block/aoe/aoeblk.c	2005-01-19 15:21:53.000000000 -0500
@@ -245,7 +252,7 @@ aoeblk_gdalloc(void *vp)
 		d->fw_ver, (long long)d->ssize);
 }
 
-void __exit
+void
 aoeblk_exit(void)
 {
 	kmem_cache_destroy(buf_pool_cache);
@@ -254,19 +261,12 @@ aoeblk_exit(void)
 int __init
 aoeblk_init(void)
 {
-	int n;
-
 	buf_pool_cache = kmem_cache_create("aoe_bufs", 
 					   sizeof(struct buf),
 					   0, 0, NULL, NULL);
 	if (buf_pool_cache == NULL)
 		return -ENOMEM;
 
-	n = register_blkdev(AOE_MAJOR, DEVICE_NAME);
-	if (n < 0) {
-		printk(KERN_ERR "aoe: aoeblk_init: can't register major\n");
-		return n;
-	}
 	return 0;
 }
 

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

