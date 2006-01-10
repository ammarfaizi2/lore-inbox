Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWAJHUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWAJHUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWAJHUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:20:12 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:12968 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750982AbWAJHUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:20:07 -0500
Message-Id: <20060110071650.618082000.dtor_core@ameritech.net>
References: <20060110070945.912712000.dtor_core@ameritech.net>
Date: Tue, 10 Jan 2006 02:09:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Miloslav Trmac <mitr@volny.cz>
Subject: [PATCH 2/5] wistron: do not crash if BIOS does not support interface
Content-Disposition: inline; filename=wistron-no-entry.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miloslav Trmac <mitr@volny.cz>

Input: wistron - do not crash if BIOS does not support interface

offset can never be < 0 because it has type size_t.  The driver
currently oopses on insmod if BIOS does not support the interface,
instead of refusing to load.

Signed-off-by: Miloslav Trmac <mitr@volny.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/wistron_btns.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: work/drivers/input/misc/wistron_btns.c
===================================================================
--- work.orig/drivers/input/misc/wistron_btns.c
+++ work/drivers/input/misc/wistron_btns.c
@@ -92,11 +92,11 @@ static void call_bios(struct regs *regs)
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
@@ -109,7 +109,7 @@ static size_t __init locate_wistron_bios
 static int __init map_bios(void)
 {
 	void __iomem *base;
-	size_t offset;
+	ssize_t offset;
 	u32 entry_point;
 
 	base = ioremap(0xF0000, 0x10000); /* Can't fail */

