Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbTBDGtS>; Tue, 4 Feb 2003 01:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTBDGtR>; Tue, 4 Feb 2003 01:49:17 -0500
Received: from dp.samba.org ([66.70.73.150]:49892 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267130AbTBDGtL>;
	Tue, 4 Feb 2003 01:49:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][0/6] CPU Hotplug update + fixes 
In-reply-to: Your message of "Mon, 03 Feb 2003 06:34:21 CDT."
             <Pine.LNX.4.44.0302030301120.9361-100000@montezuma.mastecende.com> 
Date: Tue, 04 Feb 2003 16:49:15 +1100
Message-Id: <20030204065845.1D5612C157@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302030301120.9361-100000@montezuma.mastecende.com> y
ou write:
> Hi,
> 	These patches are in no way an attempt to push this for inclusion, 
> but instead a bit of grunt work to keep it current. However i would 
> very much so like see it included in mainline.

Zwane, please send me your physical address so I can put you on my Christmas
list 8)

I've stolen these, removed a couple of unrelated cleanups to shrink
it, and put them on my page with you as author (and me as coauthor).

Here are the parts I pulled out (BTW, I'm missing 4/6: can you
re-xmit?)

Index: linux-2.5.59-lch2/include/linux/cpu.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/linux/cpu.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/linux/cpu.h	17 Jan 2003 11:15:50 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/linux/cpu.h	20 Jan 2003 13:48:27 -0000	1.1.1.1.2.1
@@ -1,3 +1,5 @@
+#ifndef _LINUX_CPU_H
+#define _LINUX_CPU_H
 /*
  * include/linux/cpu.h - generic cpu definition
  *
@@ -16,8 +18,6 @@
  * - drivers/base/intf.c 
  * - Documentation/driver-model/interface.txt
  */
-#ifndef _LINUX_CPU_H_
-#define _LINUX_CPU_H_
 
 #include <linux/device.h>
 #include <linux/node.h>
Index: linux-2.5.59-lch2/drivers/base/cpu.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/drivers/base/cpu.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/drivers/base/cpu.c	17 Jan 2003 11:15:18 -0000	1.1.1.1
+++ linux-2.5.59-lch2/drivers/base/cpu.c	20 Jan 2003 13:48:26 -0000	1.1.1.1.2.1
@@ -14,11 +14,11 @@
 {
 	return 0;
 }
+
 struct device_class cpu_devclass = {
 	.name		= "cpu",
 	.add_device	= cpu_add_device,
 };
-
 
 struct device_driver cpu_driver = {
 	.name		= "cpu",
Index: linux-2.5.59-lch2/mm/page-writeback.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/mm/page-writeback.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 page-writeback.c
--- linux-2.5.59-lch2/mm/page-writeback.c	17 Jan 2003 11:16:41 -0000	1.1.1.1
+++ linux-2.5.59-lch2/mm/page-writeback.c	21 Jan 2003 04:48:29 -0000
@@ -350,6 +350,7 @@
 static int
 ratelimit_handler(struct notifier_block *self, unsigned long u, void *v)
 {
+	/* This should be fine for all cases */
 	set_ratelimit();
 	return 0;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
