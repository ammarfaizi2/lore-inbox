Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbTJJHne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 03:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbTJJHne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 03:43:34 -0400
Received: from gprs148-182.eurotel.cz ([160.218.148.182]:12417 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262554AbTJJHnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 03:43:32 -0400
Date: Fri, 10 Oct 2003 09:43:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [pm] document acpi_sleep= options
Message-ID: <20031010074319.GA352@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Those were even missing from kernel-parameters.txt. This adds some
description. Please apply,
							Pavel

--- clean/Documentation/kernel-parameters.txt	2003-10-09 00:13:09.000000000 +0200
+++ linux/Documentation/kernel-parameters.txt	2003-10-10 09:36:31.000000000 +0200
@@ -90,6 +90,10 @@
 			off -- disabled ACPI for systems with default on
 			ht -- run only enough ACPI to enable Hyper Threading
 			See also Documentation/pm.txt.
+
+	acpi_sleep=	[HW,ACPI] Sleep options
+			Format: { s3_bios, s3_mode }
+			See Documentation/power/video.txt
  
 	ad1816=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>
--- clean/Documentation/power/video.txt	2003-10-10 09:11:51.000000000 +0200
+++ linux/Documentation/power/video.txt	2003-10-10 09:40:44.000000000 +0200
@@ -0,0 +1,36 @@
+
+		Video issues with S3 resume
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		     2003, Pavel Machek
+
+During S3 resume, hardware needs to be reinitialized. For most
+devices, this is easy, and kernel driver knows how to do
+it. Unfortunately there's one exception: video card. Those are usually
+initialized by BIOS, and kernel does not have enough information to
+boot video card. (Kernel usually does not even contain video card
+driver -- vesafb and vgacon are widely used).
+
+This is not problem for swsusp, because during swsusp resume, BIOS is
+run normally so video card is normally initialized.
+
+There are three types of systems where video works after S3 resume:
+
+* systems where video state is preserved over S3. (HP Omnibook xe3)
+
+* systems that initialize video card into vga text mode and where BIOS
+  works well enough to be able to set video mode. Use
+  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
+
+* systems where it is possible to call video bios during S3
+  resume. Unfortunately, it is not correct to call video BIOS at that
+  point, but it happens to work on some machines. Use
+  acpi_sleep=s3_bios (Athlon64 desktop system)
+
+Now, if you pass acpi_sleep=something, and it does not work with your
+bios, you'll get hard crash during resume. Be carefull.
+
+You may have system where none of above works. At that point you
+either invent another ugly hack that works, or write proper driver for
+your video card (good luck getting docs :-(). Maybe suspending from X
+(proper X, knowing your hardware, not XF68_FBcon) might have better
+chance of working.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
