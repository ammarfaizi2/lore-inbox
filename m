Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUIEHUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUIEHUN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 03:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUIEHUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 03:20:13 -0400
Received: from ozlabs.org ([203.10.76.45]:14539 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266296AbUIEHUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 03:20:08 -0400
Date: Sun, 5 Sep 2004 17:15:49 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com, zwane@fsmlabs.com
Cc: linux-kernel@vger.kernel.org
Subject: Correct ELF section used for out of line spinlocks
Message-ID: <20040905071549.GH7716@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The vmlinux.lds is using .lock.text but __lockfunc was using
.spinlock.text.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN include/linux/spinlock.h~fix_outofline_spinlocks include/linux/spinlock.h
--- gr_work/include/linux/spinlock.h~fix_outofline_spinlocks	2004-09-05 02:05:53.243858818 -0500
+++ gr_work-anton/include/linux/spinlock.h	2004-09-05 02:06:06.177805993 -0500
@@ -38,7 +38,7 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
-#define __lockfunc fastcall __attribute__((section(".spinlock.text")))
+#define __lockfunc fastcall __attribute__((section(".lock.text")))
 
 int __lockfunc _spin_trylock(spinlock_t *lock);
 int __lockfunc _write_trylock(rwlock_t *lock);
_
