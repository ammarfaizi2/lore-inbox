Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVBWPkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVBWPkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVBWPkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:40:37 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:63204 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261374AbVBWPk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:40:27 -0500
Date: Thu, 24 Feb 2005 00:40:20 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.9.11-rc4-mm1] mips: fixed kernel code resource
 initialization errors
Message-Id: <20050224004020.5ee33126.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following errores.
We need C99 struct initialization.

  CC      arch/mips/kernel/setup.o
arch/mips/kernel/setup.c:89: warning: initialization makes integer from pointer without a cast
arch/mips/kernel/setup.c:89: error: initializer element is not computable at load time
arch/mips/kernel/setup.c:89: error: (near initialization for 'code_resource.start')
arch/mips/kernel/setup.c:90: warning: initialization makes integer from pointer without a cast
arch/mips/kernel/setup.c:90: error: initializer element is not computable at load time
arch/mips/kernel/setup.c:90: error: (near initialization for 'data_resource.start')
make[1]: *** [arch/mips/kernel/setup.o] Error 1
make: *** [arch/mips/kernel] Error 2

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/kernel/setup.c a/arch/mips/kernel/setup.c
--- a-orig/arch/mips/kernel/setup.c	Sun Feb 13 12:05:29 2005
+++ a/arch/mips/kernel/setup.c	Thu Feb 24 00:33:49 2005
@@ -86,8 +86,8 @@
 unsigned long isa_slot_offset;
 EXPORT_SYMBOL(isa_slot_offset);
 
-static struct resource code_resource = { "Kernel code" };
-static struct resource data_resource = { "Kernel data" };
+static struct resource code_resource = { .name = "Kernel code", };
+static struct resource data_resource = { .name = "Kernel data", };
 
 void __init add_memory_region(phys_t start, phys_t size, long type)
 {
