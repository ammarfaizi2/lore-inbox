Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUGOAmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUGOAmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUGOAiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:38:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:38528 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266067AbUGOAUG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:20:06 -0400
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <20040715001651.GA20161@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:22 -0700
Message-Id: <10898507023964@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1757.22.6, 2004/06/22 16:24:54-07:00, akpm@osdl.org

[PATCH] raw.c cleanups

- pass the raw_config_request by reference, not by value.

- fix whitespace drainbamage

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/raw.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)


diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	2004-07-14 17:12:42 -07:00
+++ b/drivers/char/raw.c	2004-07-14 17:12:42 -07:00
@@ -125,11 +125,11 @@
 	return ioctl_by_bdev(bdev, command, arg);
 }
 
-static void bind_device(struct raw_config_request rq)
+static void bind_device(struct raw_config_request *rq)
 {
-	class_simple_device_remove(MKDEV(RAW_MAJOR, rq.raw_minor));
-	class_simple_device_add(raw_class, MKDEV(RAW_MAJOR, rq.raw_minor),
-				      NULL, "raw%d", rq.raw_minor);
+	class_simple_device_remove(MKDEV(RAW_MAJOR, rq->raw_minor));
+	class_simple_device_add(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor),
+				      NULL, "raw%d", rq->raw_minor);
 }
 
 /*
@@ -200,15 +200,16 @@
 			if (rq.block_major == 0 && rq.block_minor == 0) {
 				/* unbind */
 				rawdev->binding = NULL;
-				class_simple_device_remove(MKDEV(RAW_MAJOR, rq.raw_minor));
+				class_simple_device_remove(MKDEV(RAW_MAJOR,
+								rq.raw_minor));
 			} else {
 				rawdev->binding = bdget(dev);
 				if (rawdev->binding == NULL)
 					err = -ENOMEM;
 				else {
 					__module_get(THIS_MODULE);
-					bind_device(rq);
-					}
+					bind_device(&rq);
+				}
 			}
 			up(&raw_mutex);
 		} else {

