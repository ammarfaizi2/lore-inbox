Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWBAFJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWBAFJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWBAFJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:15 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:53359 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030333AbWBAFJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:04 -0500
Message-Id: <20060201050735.359475000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 18/18] hiddev: fix off-by-one for num_values in uref_multi requests
Content-Disposition: inline; filename=hiddev-fix-uref-multi-requests.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Collins <bcollins@ubuntu.com>

Input: hiddev - fix off-by-one for num_values in uref_multi requests

Found this when working with a HAPP UGCI device. It has a usage with 7
indexes. I could read them all one at a time, but using a multiref it
would only allow me to read the first 6. The patch below fixed it.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/hiddev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/usb/input/hiddev.c
===================================================================
--- work.orig/drivers/usb/input/hiddev.c
+++ work/drivers/usb/input/hiddev.c
@@ -631,7 +631,7 @@ static int hiddev_ioctl(struct inode *in
 
 			else if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
 				 (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
-				  uref->usage_index + uref_multi->num_values >= field->report_count))
+				  uref->usage_index + uref_multi->num_values > field->report_count))
 				goto inval;
 			}
 

