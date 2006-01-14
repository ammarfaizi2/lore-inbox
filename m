Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWANQBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWANQBi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWANQBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:01:15 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:33178 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932295AbWANQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:01:09 -0500
Message-Id: <20060114154832.873325000.dtor_core@ameritech.net>
References: <20060114151645.035957000.dtor_core@ameritech.net>
Date: Sat, 14 Jan 2006 10:16:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [git pull 3/7] HID: fix an oops in PID initialization code
Content-Disposition: inline; filename=pid-fix-oops.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: HID - fix an oops in PID initialization code

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/pid.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/usb/input/pid.c
===================================================================
--- work.orig/drivers/usb/input/pid.c
+++ work/drivers/usb/input/pid.c
@@ -259,7 +259,7 @@ static int hid_pid_upload_effect(struct 
 int hid_pid_init(struct hid_device *hid)
 {
 	struct hid_ff_pid *private;
-	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
 
 	private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);

