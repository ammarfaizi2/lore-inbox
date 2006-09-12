Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWILRtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWILRtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWILRtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:49:08 -0400
Received: from hermes.domdv.de ([193.102.202.1]:61456 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1030303AbWILRtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:49:05 -0400
Message-ID: <4506F311.3090909@domdv.de>
Date: Tue, 12 Sep 2006 19:49:05 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix suspend to disk swap_type_of() function
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/mixed;
 boundary="------------060302010600010103020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302010600010103020008
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The attached patch fixes swap_type_of() for the case the suspend device
is not the first swap device. This looks like a cut'n'paste fix. Patch
is against 2.6.17.8.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------060302010600010103020008
Content-Type: text/plain;
 name="suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="suspend.patch"

--- linux.orig/mm/swapfile.c	2006-09-12 19:33:51.000000000 +0200
+++ linux/mm/swapfile.c	2006-09-12 19:34:58.000000000 +0200
@@ -444,7 +444,7 @@ int swap_type_of(dev_t device)
 			spin_unlock(&swap_lock);
 			return i;
 		}
-		inode = swap_info->swap_file->f_dentry->d_inode;
+		inode = swap_info[i].swap_file->f_dentry->d_inode;
 		if (S_ISBLK(inode->i_mode) &&
 		    device == MKDEV(imajor(inode), iminor(inode))) {
 			spin_unlock(&swap_lock);

--------------060302010600010103020008--
