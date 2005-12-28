Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVL1Lrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVL1Lrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 06:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVL1Lrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 06:47:33 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:60343 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932528AbVL1LrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 06:47:20 -0500
Date: Wed, 28 Dec 2005 12:47:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Message-ID: <20051228114701.GC3003@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allow gcc4 compilers to optimize unit-at-a-time - which results in gcc
having a wider scope when optimizing. This also results in smaller code
when optimizing for size. (gcc4 does not have the stack footprint
problem of gcc3 compilers.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
----

 arch/i386/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/arch/i386/Makefile
===================================================================
--- linux.orig/arch/i386/Makefile
+++ linux/arch/i386/Makefile
@@ -42,9 +42,9 @@ include $(srctree)/arch/i386/Makefile.cp
 GCC_VERSION			:= $(call cc-version)
 cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
 
-# Disable unit-at-a-time mode, it makes gcc use a lot more stack
-# due to the lack of sharing of stacklots.
-CFLAGS += $(call cc-option,-fno-unit-at-a-time)
+# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
+# a lot more stack due to the lack of sharing of stacklots:
+CFLAGS				+= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo "-fno-unit-at-a-time"; fi ;)
 
 CFLAGS += $(cflags-y)
 
