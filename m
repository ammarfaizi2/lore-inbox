Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUFPTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUFPTjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUFPTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:39:45 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:44441 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264692AbUFPTjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:39:40 -0400
Date: Wed, 16 Jun 2004 21:49:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040616194919.GA4384@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org> <20040615204616.E7666@flint.arm.linux.org.uk> <20040615205557.GK2310@mars.ravnborg.org> <20040615220646.I7666@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615220646.I7666@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about this much simpler approach?

One extra assignment for each architecture added to get access to the
kernel image (at least the default one) for that architecture.

The sole purpose for this is to pass info what
kernel image should be included in a deb, rpm or tar.gz package.


	Sam

===== arch/arm/Makefile 1.66 vs edited =====
--- 1.66/arch/arm/Makefile	2004-05-12 23:55:05 +02:00
+++ edited/arch/arm/Makefile	2004-06-16 21:47:11 +02:00
@@ -130,6 +130,7 @@
 all: zImage
 
 boot := arch/arm/boot
+KERNEL_IMAGE := $(boot)/zImage
 
 #	Update machine arch and proc symlinks if something which affects
 #	them changed.  We use .arch to indicate when they were updated
===== arch/i386/Makefile 1.68 vs edited =====
--- 1.68/arch/i386/Makefile	2004-06-01 00:18:41 +02:00
+++ edited/arch/i386/Makefile	2004-06-16 21:43:50 +02:00
@@ -120,6 +120,7 @@
 	zdisk bzdisk fdimage fdimage144 fdimage288 install
 
 all: bzImage
+KERNEL_IMAGE := $(boot)/bzImage
 
 BOOTIMAGE=arch/i386/boot/bzImage
 zImage zlilo zdisk: BOOTIMAGE=arch/i386/boot/zImage
===== arch/ppc/Makefile 1.50 vs edited =====
--- 1.50/arch/ppc/Makefile	2004-06-09 10:52:22 +02:00
+++ edited/arch/ppc/Makefile	2004-06-16 21:44:01 +02:00
@@ -49,6 +49,7 @@
 .PHONY: $(BOOT_TARGETS)
 
 all: zImage
+KERNEL_IMAGE := arch/ppc/boot/images/zImage
 
 AFLAGS_vmlinux.lds.o	:= -Upowerpc
 
