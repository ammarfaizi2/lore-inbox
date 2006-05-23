Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWEWSR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWEWSR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWEWSR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:17:59 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:62903 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751155AbWEWSR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:17:58 -0400
Date: Tue, 23 May 2006 20:17:57 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Gareth Hughes <gareth@valinux.com>
Subject: [PATCH] -mm: make i387 mxcsr_feature_mask __read_mostly
Message-ID: <20060523181757.GA2566@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] -mm: make using_apic_timer __read_mostly
User-Agent: Mutt/1.4.2.1i
X-Priority: none

Hello all,

i386 run-tested on 2.6.17-rc4-mm3 (no x86_64 testing possible here).

this might collide with recent i386/x86_64 reunification efforts, though...

Signed-off-by: Andreas Mohr <andi@lisas.de>



diff -urN linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/i387.c linux-2.6.17-rc4-mm3.my/arch/i386/kernel/i387.c
--- linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/i387.c	2006-05-23 17:48:39.000000000 +0200
+++ linux-2.6.17-rc4-mm3/arch/i386/kernel/i387.c	2006-05-17 12:45:18.000000000 +0200
@@ -25,7 +25,7 @@
 #define HAVE_HWFP 1
 #endif
 
-static unsigned long mxcsr_feature_mask = 0xffffffff;
+static unsigned long mxcsr_feature_mask __read_mostly = 0xffffffff;
 
 void mxcsr_feature_mask_init(void)
 {
diff -urN linux-2.6.17-rc4-mm3.orig/arch/x86_64/kernel/i387.c linux-2.6.17-rc4-mm3.my/arch/x86_64/kernel/i387.c
--- linux-2.6.17-rc4-mm3.orig/arch/x86_64/kernel/i387.c	2006-05-23 17:50:02.000000000 +0200
+++ linux-2.6.17-rc4-mm3/arch/x86_64/kernel/i387.c	2006-05-23 20:11:41.000000000 +0200
@@ -24,7 +24,7 @@
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 
-unsigned int mxcsr_feature_mask = 0xffffffff;
+unsigned int mxcsr_feature_mask __read_mostly = 0xffffffff;
 
 void mxcsr_feature_mask_init(void)
 {
