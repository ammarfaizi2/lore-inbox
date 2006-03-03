Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWCCXOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWCCXOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWCCXOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:14:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9741 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932420AbWCCXOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:14:20 -0500
Date: Sat, 4 Mar 2006 00:14:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chris@zankel.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] xtensa must set RWSEM_GENERIC_SPINLOCK=y
Message-ID: <20060303231419.GD9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This untested patch should fix the following compile error:

<--  snip  -->

...
 CC      mm/rmap.o
/usr/src/ctest/git/kernel/mm/rmap.c: In function `page_referenced_one':
/usr/src/ctest/git/kernel/mm/rmap.c:354: warning: implicit declaration of function `rwsem_is_locked'
...
 LD      .tmp_vmlinux1
mm/built-in.o:(.text+0x5a0): undefined reference to `rwsem_is_locked'
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm2-full/arch/xtensa/Kconfig.old	2006-03-04 00:03:32.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/arch/xtensa/Kconfig	2006-03-04 00:03:56.000000000 +0100
@@ -34,6 +34,10 @@
 	bool
 	default y
 
+config RWSEM_GENERIC_SPINLOCK
+       bool
+       default y
+
 source "init/Kconfig"
 
 menu "Processor type and features"

