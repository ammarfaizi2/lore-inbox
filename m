Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWAHHws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWAHHws (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbWAHHws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:52:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57305 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030397AbWAHHws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:52:48 -0500
Message-ID: <43C0C4BA.8000800@volny.cz>
Date: Sun, 08 Jan 2006 08:52:26 +0100
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] wistron_btns: Fix missing BIOS signature handling, take 2
References: <43C0B3BF.5050100@volny.cz> <200601080158.04175.dtor_core@ameritech.net>
In-Reply-To: <200601080158.04175.dtor_core@ameritech.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------020402050005020801000107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020402050005020801000107
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:
> On Sunday 08 January 2006 01:39, Miloslav Trmac wrote:
> 
>>offset can never be < 0 because it has type size_t.  The driver
>>currently oopses on insmod if BIOS does not support the interface,
>>instead of refusing to load.
> 
> I don't really like that casting, should we just change offset to ssize_t?
Sure.
	Mirek

--------------020402050005020801000107
Content-Type: text/x-patch;
 name="wistron-no-entry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wistron-no-entry.patch"

offset can never be < 0 because it has type size_t.  The driver
currently oopses on insmod if BIOS does not support the interface,
instead of refusing to load.

Signed-off-by: Miloslav Trmac <mitr@volny.cz>

--- a/drivers/input/misc/wistron_btns.c	Sun Jan  8 06:30:59 2006
+++ b/drivers/input/misc/wistron_btns.c	Sun Jan  8 08:46:26 2006
@@ -92,11 +92,11 @@
 	preempt_enable();
 }
 
-static size_t __init locate_wistron_bios(void __iomem *base)
+static ssize_t __init locate_wistron_bios(void __iomem *base)
 {
 	static const unsigned char __initdata signature[] =
 		{ 0x42, 0x21, 0x55, 0x30 };
-	size_t offset;
+	ssize_t offset;
 
 	for (offset = 0; offset < 0x10000; offset += 0x10) {
 		if (check_signature(base + offset, signature,
@@ -109,7 +109,7 @@
 static int __init map_bios(void)
 {
 	void __iomem *base;
-	size_t offset;
+	ssize_t offset;
 	u32 entry_point;
 
 	base = ioremap(0xF0000, 0x10000); /* Can't fail */

--------------020402050005020801000107--
