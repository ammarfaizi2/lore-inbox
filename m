Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263906AbRF1TVu>; Thu, 28 Jun 2001 15:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264032AbRF1TVj>; Thu, 28 Jun 2001 15:21:39 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:8708 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263906AbRF1TVZ>;
	Thu, 28 Jun 2001 15:21:25 -0400
Message-ID: <20010626181314.A4873@bug.ucw.cz>
Date: Tue, 26 Jun 2001 18:13:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: bzImage > 0xefff0 will not boot from floppy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...it will loop forever. I have fix that allows up-to 0xffff0
bzImages, but it is *ugly*. This seems better; please apply.

								Pavel
Index: build.c
===================================================================
RCS file: /home/cvs/Repository/linux/arch/i386/boot/tools/build.c,v
retrieving revision 1.2
diff -u -u -r1.2 build.c
--- build.c	2001/04/20 00:59:29	1.2
+++ build.c	2001/06/26 15:13:34
@@ -154,7 +154,7 @@
 	if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
 		die("System is too big. Try using %smodules.",
 			is_big_kernel ? "" : "bzImage or ");
-	if (sys_size > 0xffff)
+	if (sys_size > 0xefff)
 		fprintf(stderr,"warning: kernel is too big for standalone boot "
 		    "from floppy\n");
 	while (sz > 0) {

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
