Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWCHLX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWCHLX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWCHLX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:23:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4360 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751486AbWCHLX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:23:56 -0500
Date: Wed, 8 Mar 2006 12:23:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: chris@zankel.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] xtensa must set RWSEM_GENERIC_SPINLOCK=y
Message-ID: <20060308112353.GC4006@stusta.de>
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

---

This patch was already sent on:
- 4 Mar 2006

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

