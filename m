Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRJOVll>; Mon, 15 Oct 2001 17:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278442AbRJOVlc>; Mon, 15 Oct 2001 17:41:32 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:34176 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278438AbRJOVlY>; Mon, 15 Oct 2001 17:41:24 -0400
From: David Megginson <david@megginson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15307.22561.583985.85494@megginson.com>
Date: Mon, 15 Oct 2001 17:41:53 -0400
To: linux-kernel@vger.kernel.org
Subject: Joystick-hat fix for drivers/usb/hid-input.c
X-Mailer: VM 6.92 under 21.5  (beta2) "artichoke" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[NOTE: I'm not subscribed to linux-kernel -- if you have any
questions, please reply directly to me.]

Between 2.4.9 and 2.4.10, drivers/usb/hid.c was replaced by
drivers/usb/hid-input.c, and a small typo broke support for USB
joystick hats.  Here's a patch to 2.4.12 that fixes the problem:

========================================================================

--- drivers/usb/hid-input.c.ORIG	Tue Sep 25 07:01:26 2001
+++ drivers/usb/hid-input.c	Mon Oct 15 17:31:27 2001
@@ -61,7 +61,7 @@
 static struct {
 	__s32 x;
 	__s32 y;
-}  hid_hat_to_axis[] = {{0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
+}  hid_hat_to_axis[] = {{ 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}, {0,0}};
 
 static void hidinput_configure_usage(struct hid_device *device, struct hid_field *field, struct hid_usage *usage)
 {

========================================================================

You'll notice that the order of the hid_hat_to_axis entries in the
patched version is the same as in the original hid.c.


All the best,


David

-- 
David Megginson
david@megginson.com

