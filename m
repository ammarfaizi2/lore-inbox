Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932864AbWJGVIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864AbWJGVIa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWJGVI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 17:08:29 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:4550 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S932864AbWJGVI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 17:08:29 -0400
Message-ID: <452816A9.3080208@twisted-brains.org>
Date: Sat, 07 Oct 2006 23:05:45 +0200
From: Marcel Siegert <mws@twisted-brains.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.19-rc1 fix compilation/linking error in arch/x86_64_kernel/traps.c
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi linus,

the following compilation error:

CC      arch/x86_64/kernel/traps.o
arch/x86_64/kernel/traps.c: In function 'print_trace_warning_symbol':
arch/x86_64/kernel/traps.c:375: warning: implicit declaration of function 'print_symbol'

causing the following linking error
arch/x86_64/kernel/built-in.o: In function `print_trace_warning_symbol':
traps.c:(.text+0x2f85): undefined reference to `print_symbol'
make: *** [vmlinux] Error 1

is being fixed with the following patch.



Description: fix missing include of kallsyms.h in arch/x86_64/kernel/traps.c

Signed-off-by: Marcel Siegert <mws@twisted-brains.org>

--- linux/arch/x86_64/kernel/traps.c    2006-10-07 22:33:07.000000000 +0200
+++ linux-2.6.19-rc1-patched/arch/x86_64/kernel/traps.c 2006-10-06 15:20:18.801485944 +0200
@@ -29,7 +29,7 @@
  #include <linux/kprobes.h>
  #include <linux/kexec.h>
  #include <linux/unwind.h>
-
+#include <linux/kallsyms.h>
  #include <asm/system.h>
  #include <asm/uaccess.h>
  #include <asm/io.h>



