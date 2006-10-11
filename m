Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWJKMwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWJKMwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWJKMwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:52:51 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:61164 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1161044AbWJKMwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:52:50 -0400
Subject: [PATCH] drivers/usb/core/message.c: Replacing yield() with a
	better alternative
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 18:26:12 +0530
Message-Id: <1160571372.19143.325.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6, the semantics of calling yield() changed from "sleep for a
bit" to "I really don't want to run for a while".  This matches POSIX
better, but there's a lot of drivers still using yield() when they mean
cond_resched(), schedule() or even schedule_timeout().

For this driver cond_resched() seems to be a better
alternative

Tested compile only

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/usb/core/message.c linux-2.6.19-rc1/drivers/usb/core/message.c
--- linux-2.6.19-rc1-orig/drivers/usb/core/message.c	2006-10-05 14:00:52.000000000 +0530
+++ linux-2.6.19-rc1/drivers/usb/core/message.c	2006-10-11 17:57:02.000000000 +0530
@@ -502,7 +502,7 @@ void usb_sg_wait (struct usb_sg_request 
 			io->urbs[i]->dev = NULL;
 			retval = 0;
 			i--;
-			yield ();
+			cond_resched();
 			break;
 
 			/* no error? continue immediately.


