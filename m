Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbUKUIrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUKUIrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 03:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUKUIqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 03:46:24 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:62719 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261926AbUKUIp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 03:45:27 -0500
Date: Sun, 21 Nov 2004 17:45:20 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc2-mm2] mips: fixed fls warning
Message-Id: <20041121174520.1ab02935.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following fls warning on MIPS.

  CC      arch/mips/kernel/offset.s
In file included from include/asm/system.h:18,
                 from include/asm/bitops.h:34,
                 from include/linux/bitops.h:77,
                 from include/linux/thread_info.h:20,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/mips/kernel/offset.c:14:
include/linux/kernel.h: In function `roundup_pow_of_two':
include/linux/kernel.h:120: warning: implicit declaration of function `fls'

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/include/asm-mips/system.h a/include/asm-mips/system.h
--- a-orig/include/asm-mips/system.h	Sat Oct 23 06:39:07 2004
+++ a/include/asm-mips/system.h	Wed Nov 10 08:00:10 2004
@@ -13,9 +13,8 @@
 #define _ASM_SYSTEM_H
 
 #include <linux/config.h>
-#include <asm/sgidefs.h>
-
-#include <linux/kernel.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
 
 #include <asm/addrspace.h>
 #include <asm/ptrace.h>

