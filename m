Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUERX1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUERX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUERX1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 19:27:24 -0400
Received: from the.earth.li ([193.201.200.66]:16281 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S263731AbUERX1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 19:27:20 -0400
Date: Wed, 19 May 2004 00:27:20 +0100
From: Jonathan McDowell <noodles@earth.li>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Sparc doesn't build without input support / can't turn off VTs
Message-ID: <20040518232720.GO5289@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Tried to build 2.6.6 for my Sparc LX today, which runs headless. Turned
off all the input support and it failed to build - VT support couldn't
be disabled and this needs input support it seems.

Patch below allows disabling VT support for Sparc. I think it might also
want a "select INPUT" in the "config VT" section?

J.

-- 
Revd. Jonathan McDowell, ULC | Death is a nonmaskable interrupt.


--- linux-2.6.6/arch/sparc/Kconfig.orig	2004-05-19 00:16:05.320531000 +0100
+++ linux-2.6.6/arch/sparc/Kconfig	2004-05-18 21:30:07.000000000 +0100
@@ -27,7 +27,7 @@
 menu "General setup"
 
 config VT
-	bool
+	bool "Virtual terminal"
 	default y
 	---help---
 	  If you say Y here, you will get support for terminal devices with
@@ -57,7 +57,8 @@
 	  shiny Linux system :-)
 
 config VT_CONSOLE
-	bool
+	bool "Support for console on virtual terminal"
+	depends on VT
 	default y
 	---help---
 	  The system console is the device which receives all kernel messages
@@ -79,6 +80,7 @@
 
 config HW_CONSOLE
 	bool
+	depends on VT
 	default y
 
 config SMP
