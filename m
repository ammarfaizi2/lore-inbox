Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUFGMOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUFGMOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUFGMN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:13:58 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18049 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264628AbUFGL4c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:32 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093553089@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609355796@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:55 +0200
Subject: [PATCH 38/39] input: Fix oops in hiddev
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1612.1.19, 2004-05-17 13:02:06+02:00, tiwai@suse.de
  input: Fix oops in hiddev


 hiddev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	2004-06-07 13:10:21 +02:00
+++ b/drivers/usb/input/hiddev.c	2004-06-07 13:10:21 +02:00
@@ -232,7 +232,7 @@
 static struct usb_class_driver hiddev_class;
 static void hiddev_cleanup(struct hiddev *hiddev)
 {
-	hiddev_table[hiddev->hid->minor] = NULL;
+	hiddev_table[hiddev->hid->minor - HIDDEV_MINOR_BASE] = NULL;
 	usb_deregister_dev(hiddev->hid->intf, &hiddev_class);
 	kfree(hiddev);
 }

