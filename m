Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWAHGkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWAHGkc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 01:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWAHGkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 01:40:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58822 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751165AbWAHGkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 01:40:32 -0500
Message-ID: <43C0B3BF.5050100@volny.cz>
Date: Sun, 08 Jan 2006 07:39:59 +0100
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] wistron_btns: Fix missing BIOS signature handling
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------010901030707090601080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010901030707090601080600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

offset can never be < 0 because it has type size_t.  The driver
currently oopses on insmod if BIOS does not support the interface,
instead of refusing to load.

--------------010901030707090601080600
Content-Type: text/x-patch;
 name="wistron-no-entry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wistron-no-entry.patch"

offset can never be < 0 because it has type size_t.  The driver
currently oopses on insmod if BIOS does not support the interface,
instead of refusing to load.

Signed-off-by: Miloslav Trmac <mitr@volny.cz>

diff -r 88ae680122c0 wistron_btns.c
--- a/drivers/input/misc/wistron_btns.c	Sun Dec 11 21:18:28 2005
+++ b/drivers/input/misc/wistron_btns.c	Sun Jan  8 07:24:44 2006
@@ -114,7 +114,7 @@
 
 	base = ioremap(0xF0000, 0x10000); /* Can't fail */
 	offset = locate_wistron_bios(base);
-	if (offset < 0) {
+	if (offset == (size_t)-1) {
 		printk(KERN_ERR "wistron_btns: BIOS entry point not found\n");
 		iounmap(base);
 		return -ENODEV;

--------------010901030707090601080600--
