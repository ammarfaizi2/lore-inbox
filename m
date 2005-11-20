Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVKTXbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVKTXbS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVKTXbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:31:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48144 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932126AbVKTXbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:31:17 -0500
Date: Mon, 21 Nov 2005 00:31:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tigran@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] arch/i386/kernel/microcode.c: remove the obsolete microcode_ioctl
Message-ID: <20051120233116.GN16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nowadays, even Debian stable ships a microcode_ctl utility recent enough 
to no longer use this ioctl.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/microcode.c |   17 -----------------
 1 file changed, 17 deletions(-)

--- linux-2.6.15-rc1-mm2-full/arch/i386/kernel/microcode.c.old	2005-11-20 21:30:59.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/arch/i386/kernel/microcode.c	2005-11-20 21:31:24.000000000 +0100
@@ -457,26 +457,9 @@
 	return ret;
 }
 
-static int microcode_ioctl (struct inode *inode, struct file *file, 
-		unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-		/* 
-		 *  XXX: will be removed after microcode_ctl 
-		 *  is updated to ignore failure of this ioctl()
-		 */
-		case MICROCODE_IOCFREE:
-			return 0;
-		default:
-			return -EINVAL;
-	}
-	return -EINVAL;
-}
-
 static struct file_operations microcode_fops = {
 	.owner		= THIS_MODULE,
 	.write		= microcode_write,
-	.ioctl		= microcode_ioctl,
 	.open		= microcode_open,
 };
 

