Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWJEKBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWJEKBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWJEKBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:01:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:59018 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751590AbWJEKBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:01:33 -0400
X-Authenticated: #704063
Subject: [Patch] Dereference in drivers/usb/misc/adutux.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: netwiz@crc.id.au
Content-Type: text/plain
Date: Thu, 05 Oct 2006 12:01:29 +0200
Message-Id: <1160042489.3101.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

in two of the error cases, dev is still NULL,
and we dereference it. Spotted by coverity (cid#1428, 1429)

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.19-rc1/drivers/usb/misc/adutux.c.orig	2006-10-05 11:57:52.000000000 +0200
+++ linux-2.6.19-rc1/drivers/usb/misc/adutux.c	2006-10-05 11:58:19.000000000 +0200
@@ -370,7 +370,8 @@ static int adu_release(struct inode *ino
 	retval = adu_release_internal(dev);
 
 exit:
-	up(&dev->sem);
+	if(dev)
+		up(&dev->sem);
 	dbg(2," %s : leave, return value %d", __FUNCTION__, retval);
 	return retval;
 }


