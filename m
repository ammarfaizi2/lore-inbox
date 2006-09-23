Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWIWA1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWIWA1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWIWA1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:27:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2447 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964965AbWIWA1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:27:30 -0400
Date: Sat, 23 Sep 2006 01:27:30 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix the survivors of fbcon_vbl_handler() renaming
Message-ID: <20060923002729.GB29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In

|Author: James Simmons <jsimmons@kozmo.(none)>
|Date:   Thu Mar 13 22:37:08 2003 -0800
|
|    [FBCON] Cursor handling clean up. I nuked several static variables.

we have

-static void fbcon_vbl_handler(int irq, void *dummy, struct pt_regs *fp)
+static void fb_vbl_handler(int irq, void *dev_id, struct pt_regs *fp)

and 3 years later a couple of instances missed back then still remains
there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/video/console/fbcon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 390439b..1b4f75d 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3197,11 +3197,11 @@ static void fbcon_exit(void)
 		return;
 
 #ifdef CONFIG_ATARI
-	free_irq(IRQ_AUTO_4, fbcon_vbl_handler);
+	free_irq(IRQ_AUTO_4, fb_vbl_handler);
 #endif
 #ifdef CONFIG_MAC
 	if (MACH_IS_MAC && vbl_detected)
-		free_irq(IRQ_MAC_VBL, fbcon_vbl_handler);
+		free_irq(IRQ_MAC_VBL, fb_vbl_handler);
 #endif
 
 	kfree((void *)softback_buf);
-- 
1.4.2.GIT
