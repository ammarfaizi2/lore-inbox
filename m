Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967132AbWKYTQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967132AbWKYTQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967127AbWKYTQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:16:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58380 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967123AbWKYTPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:15:13 -0500
Date: Sat, 25 Nov 2006 20:15:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] include/linux/bug.h must always #include <linux/module.h>
Message-ID: <20061125191516.GC3702@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the folliwing compile error with CONFIG_BUG=n:

<--  snip  -->

...
  CC      arch/i386/kernel/traps.o
In file included from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm1/arch/i386/kernel/traps.c:32:
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm1/include/linux/bug.h:38: warning: type defaults to 'int' in declaration of 'Elf_Ehdr'
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm1/include/linux/bug.h:38: error: expected ';', ',' or ')' before '*' token
...
make[2]: *** [arch/i386/kernel/traps.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/include/linux/bug.h.old	2006-11-24 23:25:50.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/bug.h	2006-11-24 23:26:04.000000000 +0100
@@ -1,6 +1,7 @@
 #ifndef _LINUX_BUG_H
 #define _LINUX_BUG_H
 
+#include <linux/module.h>
 #include <asm/bug.h>
 
 enum bug_trap_type {
@@ -10,7 +11,6 @@
 };
 
 #ifdef CONFIG_GENERIC_BUG
-#include <linux/module.h>
 #include <asm-generic/bug.h>
 
 static inline int is_warning_bug(const struct bug_entry *bug)

