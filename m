Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUJTSie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUJTSie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJTSiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:38:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:48030 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269008AbUJTSfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:35:05 -0400
Date: Wed, 20 Oct 2004 20:35:04 +0200
From: Olaf Hering <olh@suse.de>
To: Andreas Kleen <ak@suse.de>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix cross compile on x86_64
Message-ID: <20041020183504.GA11821@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make all fails while building a helper app:

arch/x86_64/boot/tools/build.c:36:22: asm/boot.h: No such file or directory

Possible that make O=$foo did never work on x86_64.

This patch fixes it for me.

diff -purN linux-2.6.9-bk4.orig/arch/x86_64/boot/Makefile linux-2.6.9/arch/x86_64/boot/Makefile
--- linux-2.6.9-bk4.orig/arch/x86_64/boot/Makefile	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.9/arch/x86_64/boot/Makefile	2004-10-20 20:29:31.368618554 +0200
@@ -31,6 +31,7 @@ targets		:= vmlinux.bin bootsect bootsec
 EXTRA_CFLAGS := -m32
 
 hostprogs-y	:= tools/build
+HOST_EXTRACFLAGS += $(LINUXINCLUDE)
 subdir-		:= compressed/	#Let make clean descend in compressed/
 # ---------------------------------------------------------------------------
 
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
