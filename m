Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269532AbUIRPPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269532AbUIRPPo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 11:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269553AbUIRPPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 11:15:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:51364 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269532AbUIRPPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 11:15:43 -0400
Date: Sat, 18 Sep 2004 17:15:39 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix make O= for ppc64/boot
Message-ID: <20040918151539.GA16468@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make ARCH=ppc64 -j12 O=/dev/shm/R all fails,
the linker script is not in the output directory.


--- ./arch/ppc64/boot/Makefile	2004-09-18 17:07:00.474802662 +0200
+++ ./arch/ppc64/boot/Makefile	2004-09-18 17:10:04.770915019 +0200
@@ -29,7 +29,7 @@ BOOTCFLAGS	:= $(HOSTCFLAGS) $(LINUXINCLU
 BOOTAS		:= $(CROSS32_COMPILE)as
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional
 BOOTLD		:= $(CROSS32_COMPILE)ld
-BOOTLFLAGS	:= -Ttext 0x00400000 -e _start -T $(obj)/zImage.lds
+BOOTLFLAGS	:= -Ttext 0x00400000 -e _start -T $(srctree)/$(src)/zImage.lds
 BOOTOBJCOPY	:= $(CROSS32_COMPILE)objcopy
 OBJCOPYFLAGS    := contents,alloc,load,readonly,data
 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
