Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263215AbVGAEoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbVGAEoT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 00:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbVGAEoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 00:44:19 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:26754 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S263215AbVGAEoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 00:44:13 -0400
Date: Fri, 1 Jul 2005 00:40:27 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc1] i386: fix incorrect TSS entry for LDT
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, eliad lubovsky <eliadl@013.net>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200507010043_MC3-1-A32F-B78B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The LDT entry in the i386 TSS needs to be a selector, not an entry number.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Index: 2.6.13-rc1/include/asm-i386/processor.h
===================================================================
--- 2.6.13-rc1.orig/include/asm-i386/processor.h        2005-06-30 15:46:17.176906000 -0400
+++ 2.6.13-rc1/include/asm-i386/processor.h     2005-07-01 00:23:38.666906000 -0400
@@ -474,7 +474,7 @@
        .esp0           = sizeof(init_stack) + (long)&init_stack,       \
        .ss0            = __KERNEL_DS,                                  \
        .ss1            = __KERNEL_CS,                                  \
-       .ldt            = GDT_ENTRY_LDT,                                \
+       .ldt            = GDT_ENTRY_LDT * 8,                            \
        .io_bitmap_base = INVALID_IO_BITMAP_OFFSET,                     \
        .io_bitmap      = { [ 0 ... IO_BITMAP_LONGS] = ~0 },            \
 }


--
Chuck
