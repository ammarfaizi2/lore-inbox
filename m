Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTFUNqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTFUNiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:38:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22434 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262930AbTFUNiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:01 -0400
Subject: [PATCH 9/11] input: Fix double kfree of device->rdesc in hid-core
In-Reply-To: <10562035172152@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035171903@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1367, 2003-06-21 04:45:44-07:00, acme@conectiva.com.br
  input: fix double kfree of device->rdesc on hid_parse_parse error
         path in hid-core.c


 hid-core.c |    5 -----
 1 files changed, 5 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Sat Jun 21 15:25:51 2003
+++ b/drivers/usb/input/hid-core.c	Sat Jun 21 15:25:51 2003
@@ -674,7 +674,6 @@
 
 		if (item.format != HID_ITEM_FORMAT_SHORT) {
 			dbg("unexpected long global item");
-			kfree(device->rdesc);
 			kfree(device->collection);
 			hid_free_device(device);
 			kfree(parser);
@@ -684,7 +683,6 @@
 		if (dispatch_type[item.type](parser, &item)) {
 			dbg("item %u %u %u %u parsing failed\n",
 				item.format, (unsigned)item.size, (unsigned)item.type, (unsigned)item.tag);
-			kfree(device->rdesc);
 			kfree(device->collection);
 			hid_free_device(device);
 			kfree(parser);
@@ -694,7 +692,6 @@
 		if (start == end) {
 			if (parser->collection_stack_ptr) {
 				dbg("unbalanced collection at end of report description");
-				kfree(device->rdesc);
 				kfree(device->collection);
 				hid_free_device(device);
 				kfree(parser);
@@ -702,7 +699,6 @@
 			}
 			if (parser->local.delimiter_depth) {
 				dbg("unbalanced delimiter at end of report description");
-				kfree(device->rdesc);
 				kfree(device->collection);
 				hid_free_device(device);
 				kfree(parser);
@@ -714,7 +710,6 @@
 	}
 
 	dbg("item fetching failed at offset %d\n", (int)(end - start));
-	kfree(device->rdesc);
 	kfree(device->collection);
 	hid_free_device(device);
 	kfree(parser);

