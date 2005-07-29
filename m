Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVG3AxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVG3AxW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVG3Aur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:50:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:7088 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262759AbVG2TS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:18:56 -0400
Date: Fri, 29 Jul 2005 12:18:34 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: [patch 29/29] USB: hidinput_hid_event() oops fix
Message-ID: <20050729191834.GE5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-hidinput_hid_event-oops-fix.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pete Zaitcev <zaitcev@redhat.com>

It seems that I see a bug in hidinput_hid_event.  The check for NULL can never
work, becaue &hidinput->input is nonzero at all times.

Cc: <vojtech@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/input/hid-input.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/usb/input/hid-input.c	2005-07-29 11:29:47.000000000 -0700
+++ gregkh-2.6/drivers/usb/input/hid-input.c	2005-07-29 11:36:35.000000000 -0700
@@ -397,11 +397,12 @@
 
 void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
 {
-	struct input_dev *input = &field->hidinput->input;
+	struct input_dev *input;
 	int *quirks = &hid->quirks;
 
-	if (!input)
+	if (!field->hidinput)
 		return;
+	input = &field->hidinput->input;
 
 	input_regs(input, regs);
 

--
