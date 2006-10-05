Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWJEWJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWJEWJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWJEWJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:09:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:26077 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932320AbWJEWJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:09:32 -0400
X-Authenticated: #704063
Subject: Re: [Patch] Dereference in drivers/usb/misc/adutux.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, netwiz@crc.id.au
In-Reply-To: <20061005082131.c9a0ecd0.rdunlap@xenotime.net>
References: <1160042489.3101.2.camel@alice>
	 <20061005082131.c9a0ecd0.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 00:09:29 +0200
Message-Id: <1160086169.26057.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> > in two of the error cases, dev is still NULL,
> > and we dereference it. Spotted by coverity (cid#1428, 1429)
> > 
> space after if, for, while, etc.  No space after function names.

updated patch below.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.19-rc1/drivers/usb/misc/adutux.c.orig	2006-10-05 17:34:45.000000000 +0200
+++ linux-2.6.19-rc1/drivers/usb/misc/adutux.c	2006-10-05 17:34:53.000000000 +0200
@@ -370,7 +370,8 @@ static int adu_release(struct inode *ino
 	retval = adu_release_internal(dev);
 
 exit:
-	up(&dev->sem);
+	if (dev)
+		up(&dev->sem);
 	dbg(2," %s : leave, return value %d", __FUNCTION__, retval);
 	return retval;
 }


