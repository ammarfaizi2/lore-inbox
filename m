Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbTDGDgM (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTDGDgM (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:36:12 -0400
Received: from chii.cinet.co.jp ([61.197.228.217]:42881 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S263226AbTDGDgL (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:36:11 -0400
Date: Mon, 7 Apr 2003 12:45:53 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.66-ac2] PC-9800 sub architecture support (1/9) kconfig
Message-ID: <20030407034553.GA4840@yuzuki.cinet.co.jp>
References: <20030407033627.GA4798@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407033627.GA4798@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.66-ac2. (1/9)

Add selection CONFIG_X86_PC9800.

Regards,
Osamu Tomita

diff -Nru linux-2.5.66-ac2/arch/i386/Kconfig linux98-2.5.66-ac2/arch/i386/Kconfig
--- linux-2.5.66-ac2/arch/i386/Kconfig	2003-04-05 10:06:16.000000000 +0900
+++ linux98-2.5.66-ac2/arch/i386/Kconfig	2003-04-05 10:16:36.000000000 +0900
@@ -103,6 +103,12 @@
 	  A kernel compiled for the Visual Workstation will not run on PCs
 	  and vice versa. See <file:Documentation/sgi-visws.txt> for details.
 
+config X86_PC9800
+	bool "PC-9800 (NEC)"
+	help
+	  To make kernel for NEC PC-9801/PC-9821 sub-architecture, say Y.
+	  If say Y, kernel works -ONLY- on PC-9800 architecture.
+
 endchoice
 
 
@@ -1089,7 +1095,7 @@
 
 config EISA
 	bool "EISA support"
-	depends on ISA
+	depends on ISA && !X86_PC9800
 	---help---
 	  The Extended Industry Standard Architecture (EISA) bus was
 	  developed as an open alternative to the IBM MicroChannel bus.
@@ -1107,7 +1113,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_PC9800)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
