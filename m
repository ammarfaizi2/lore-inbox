Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVCVWM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVCVWM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVCVWLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:11:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6413 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262171AbVCVWIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:08:21 -0500
Date: Tue, 22 Mar 2005 23:08:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/core/devices.c: small corrections
Message-ID: <20050322220816.GT1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

total_written is used at places where it can't have any value different 
from 0.

This patch is partially based on findings of the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/usb/core/devices.c.old	2005-03-22 21:13:18.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/usb/core/devices.c	2005-03-22 21:15:02.000000000 +0100
@@ -460,7 +460,7 @@ static ssize_t usb_device_dump(char __us
 		return 0;
 	
 	if (level > MAX_TOPO_LEVEL)
-		return total_written;
+		return 0;
 	/* allocate 2^1 pages = 8K (on i386); should be more than enough for one device */
         if (!(pages_start = (char*) __get_free_pages(GFP_KERNEL,1)))
                 return -ENOMEM;
@@ -527,10 +527,7 @@ static ssize_t usb_device_dump(char __us
 			length = *nbytes;
 		if (copy_to_user(*buffer, pages_start + *skip_bytes, length)) {
 			free_pages((unsigned long)pages_start, 1);
-			
-			if (total_written == 0)
-				return -EFAULT;
-			return total_written;
+			return -EFAULT;
 		}
 		*nbytes -= length;
 		*file_offset += length;

