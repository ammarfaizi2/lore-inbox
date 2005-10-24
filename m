Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVJXP7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVJXP7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVJXP7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:59:41 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:64270 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751128AbVJXP7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:59:40 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: [PATCH 2.6.14-rc5-mm1] UML: fix compile part-2
Message-Id: <E1EU4jP-0005lz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 17:59:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error:

  LD      .tmp_vmlinux1
arch/um/kernel/built-in.o(.text+0x577a): In function `do_gettimeofday':
arch/um/kernel/time.c:128: undefined reference to `clock_was_set'
collect2: ld returned 1 exit status

ktimers patch left all clock_was_set() calls in place presumably
because they will be reused at a later time (?).  So this patch does
the same.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/arch/um/kernel/time.c
===================================================================
--- linux.orig/arch/um/kernel/time.c	2005-09-02 11:17:38.000000000 +0200
+++ linux/arch/um/kernel/time.c	2005-10-24 13:26:20.000000000 +0200
@@ -114,8 +114,8 @@ void time_init(void)
 	wall_to_monotonic.tv_nsec = -now.tv_nsec;
 }
 
-/* Declared in linux/time.h, which can't be included here */
-extern void clock_was_set(void);
+/* Defined in linux/ktimer.h, which can't be included here */
+#define clock_was_set()		do { } while (0)
 
 void do_gettimeofday(struct timeval *tv)
 {
