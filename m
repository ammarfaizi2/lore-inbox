Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUJGKIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUJGKIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269777AbUJGKIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:08:13 -0400
Received: from mail.dif.dk ([193.138.115.101]:18913 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267378AbUJGKHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:07:01 -0400
Date: Thu, 7 Oct 2004 12:04:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.9-rc3-mm3
In-Reply-To: <20041007015139.6f5b833b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410071159010.13059@jjulnx.backbone.dif.dk>
References: <20041007015139.6f5b833b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes since 2.6.9-rc3-mm2:
> 
[...]
> +ds_ioctl-usercopy-check.patch
> 
>  usercopy checks
> 
[...]

After recieving some feedback from Christoph Hellwig I believe this is 
probably a better version of the patch (no reason not to use the 
access_ok checking version of copy_to_user) :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk5-orig/drivers/pcmcia/ds.c linux-2.6.9-rc3-bk5/drivers/pcmcia/ds.c
--- linux-2.6.9-rc3-bk5-orig/drivers/pcmcia/ds.c	2004-10-05 22:07:27.000000000 +0200
+++ linux-2.6.9-rc3-bk5/drivers/pcmcia/ds.c	2004-10-06 22:20:27.000000000 +0200
@@ -1046,7 +1046,11 @@ static int ds_ioctl(struct inode * inode
 	}
     }
 
-    if (cmd & IOC_OUT) __copy_to_user(uarg, (char *)&buf, size);
+    if (cmd & IOC_OUT) {
+        if (copy_to_user(uarg, (char *)&buf, size))
+            err = -EFAULT;
+    }
+
 
     return err;
 } /* ds_ioctl */


