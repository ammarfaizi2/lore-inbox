Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUJRJgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUJRJgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUJRJgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:36:38 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:30969 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S265195AbUJRJgd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:36:33 -0400
Message-ID: <41738E9E.4080701@verizon.net>
Date: Mon, 18 Oct 2004 05:36:30 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch to drivers/video/Kconfig [1 of 4]
Content-Type: multipart/mixed;
 boundary="------------090303040903090506060301"
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:36:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090303040903090506060301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes undefined symbol references when running "make config" for systems
that have PCI but not AGP (sparc, sparc64)

Apply against 2.6.9-rc4.

diff -u drivers/video/Kconfig.orig drivers/video/Kconfig


--------------090303040903090506060301
Content-Type: text/x-patch;
 name="drivers_video_kconfig-fix-intel-810-dependency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers_video_kconfig-fix-intel-810-dependency.patch"

--- drivers/video/Kconfig.orig	2004-10-16 11:58:32.738491881 -0400
+++ drivers/video/Kconfig	2004-10-16 12:51:57.221487678 -0400
@@ -460,11 +460,12 @@
 	  of debugging informations to provide to the maintainer when
 	  something goes wrong.
 
+comment "Enable AGP and AGP_INTEL for Intel 810/815 support (EXPERIMENTAL)."
+	depends on FB && EXPERIMENTAL && X86 && !X86_64 && PCI &&!(AGP && AGP_INTEL)
+
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
-	select AGP
-	select AGP_INTEL
+	depends on FB && EXPERIMENTAL && AGP && AGP_INTEL && X86 && !X86_64
 	select FB_MODE_HELPERS
 	help
 	  This driver supports the on-board graphics built in to the Intel 810 


--------------090303040903090506060301--
