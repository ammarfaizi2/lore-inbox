Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUCOADw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 19:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUCOADw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 19:03:52 -0500
Received: from waste.org ([209.173.204.2]:40330 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262078AbUCOADu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 19:03:50 -0500
Date: Sun, 14 Mar 2004 18:03:40 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: [patch] proper alignment of init task in kernel image
Message-ID: <20040315000340.GZ20174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This keeps the alignment of the init task matched with the stack size.
Saves 4k for 4k stacks, keeps system from exploding with 16k. Please apply.

 test-mpm/arch/i386/kernel/vmlinux.lds.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/vmlinux.lds.S~init-task-align arch/i386/kernel/vmlinux.lds.S
--- test/arch/i386/kernel/vmlinux.lds.S~init-task-align	2004-03-14 17:57:42.000000000 -0600
+++ test-mpm/arch/i386/kernel/vmlinux.lds.S	2004-03-14 18:00:02.000000000 -0600
@@ -6,7 +6,8 @@
 #include <linux/config.h>
 #include <asm/page.h>
 #include <asm/asm_offsets.h>
-	
+#include <asm/thread_info.h>
+
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(startup_32)
@@ -61,7 +62,7 @@ SECTIONS
 
   _edata = .;			/* End of data section */
 
-  . = ALIGN(8192);		/* init_task */
+  . = ALIGN(THREAD_SIZE);	/* init_task */
   .data.init_task : { *(.data.init_task) }
 
   /* will be freed after init */

_


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
