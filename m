Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbUK1VZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbUK1VZp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 16:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbUK1VZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 16:25:44 -0500
Received: from mail.dif.dk ([193.138.115.101]:11183 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261579AbUK1VZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 16:25:38 -0500
Date: Sun, 28 Nov 2004 22:35:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sound/isa : check __copy_to_user in sscape_upload_bootblock()
Message-ID: <Pine.LNX.4.61.0411282225200.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__copy_to_user() is called without checking its return value in 
sound/isa/sscape.c::sscape_upload_bootblock . 

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -p -U 5 linux-2.6.10-rc2-bk11-orig/sound/isa/sscape.c linux-2.6.10-rc2-bk11/sound/isa/sscape.c
--- linux-2.6.10-rc2-bk11-orig/sound/isa/sscape.c	2004-11-17 01:20:39.000000000 +0100
+++ linux-2.6.10-rc2-bk11/sound/isa/sscape.c	2004-11-28 22:24:14.000000000 +0100
@@ -570,11 +570,12 @@ static int sscape_upload_bootblock(struc
 	if (ret == 0) {
 		if (data < 0) {
 			snd_printk(KERN_ERR "sscape: timeout reading firmware version\n");
 			ret = -EAGAIN;
 		} else {
-			__copy_to_user(&bb->version, &data, sizeof(bb->version));
+			if (__copy_to_user(&bb->version, &data, sizeof(bb->version)))
+				ret = -EFAULT;
 		}
 	}
 
 	return ret;
 }



-- 
Jesper Juhl

PS. Please CC me on replies from alsa-devel


