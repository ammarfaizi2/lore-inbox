Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWEJR1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWEJR1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWEJR1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:27:42 -0400
Received: from homer.mvista.com ([63.81.120.158]:14881 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S965022AbWEJR1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:27:41 -0400
Date: Wed, 10 May 2006 10:26:52 -0700
Message-Id: <200605101726.k4AHQqZf004367@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: Seokmann.Ju@lsil.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH -mm] updated megaraid gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hows that Alan?

Fixes the following warning,

drivers/scsi/megaraid.c: In function ‘megadev_ioctl’:
drivers/scsi/megaraid.c:3665: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/scsi/megaraid.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/megaraid.c
+++ linux-2.6.16/drivers/scsi/megaraid.c
@@ -3662,8 +3662,9 @@ megadev_ioctl(struct inode *inode, struc
 			 * Send the request sense data also, irrespective of
 			 * whether the user has asked for it or not.
 			 */
-			copy_to_user(upthru->reqsensearea,
-					pthru->reqsensearea, 14);
+			if (copy_to_user(upthru->reqsensearea,
+					pthru->reqsensearea, 14))
+				rval = (-EFAULT);
 
 freemem_and_return:
 			if( pthru->dataxferlen ) {
