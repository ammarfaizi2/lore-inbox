Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267948AbUGWTnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267948AbUGWTnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 15:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267949AbUGWTnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 15:43:39 -0400
Received: from server18.wavepath.com ([63.247.70.66]:31413 "EHLO
	bradgoodman.com") by vger.kernel.org with ESMTP id S267948AbUGWTnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 15:43:37 -0400
Date: Fri, 23 Jul 2004 15:47:58 -0400
From: "bradgoodman.com" <bkgoodman@bradgoodman.com>
Message-Id: <200407231947.i6NJlwo32224@bradgoodman.com>
To: alan@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] 2.4.27 - MTD cfi_cmdset_0002.c - Duplicate cleanup in error path
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to 2.4.x: Corrects an obvious error where all of the cleanups are done
twice in the event of a chip programming error. This can result in
kernel BUG() getting called on subsequent programming attempts.


--- linux-2.4.22.prepatch/drivers/mtd/chips/cfi_cmdset_0002.c	Fri Jun 13 10:51:34 2003
+++ linux-2.4.22/drivers/mtd/chips/cfi_cmdset_0002.new	Thu Jul 15 14:44:30 2004
@@ -549,11 +549,6 @@
 			}
 		} else {
 			printk(KERN_WARNING "Waiting for write to complete timed out in do_write_oneword.");        
-			
-			chip->state = FL_READY;
-			wake_up(&chip->wq);
-			cfi_spin_unlock(chip->mutex);
-			DISABLE_VPP(map);
 			ret = -EIO;
 		}
 	}
