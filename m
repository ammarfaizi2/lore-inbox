Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269738AbUJAKKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269738AbUJAKKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269742AbUJAKJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:09:04 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:9358 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269738AbUJAKI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:08:59 -0400
Date: Fri, 1 Oct 2004 12:10:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, kai@germaschewski.name, sam@ravnborg.org,
       davidm@hpl.hp.com
Subject: [ia64 patch 2.6.9-rc3] build: ccache/distcc fix for ia64
Message-ID: <20041001101040.GA25104@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the (tested) patch below fixes ccache/distcc-assisted building of the
ia64 tree. (CC is "ccache distcc gcc" in that case, not a simple
one-word "gcc" - this confused the check-gas and toolchain-flags
scripts.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/ia64/Makefile.orig
+++ linux/arch/ia64/Makefile
@@ -24,8 +24,8 @@ cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -
 CFLAGS_KERNEL	:= -mconstant-gp
 
 GCC_VERSION     := $(call cc-version)
-GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas $(CC) $(OBJDUMP))
-CPPFLAGS += $(shell $(srctree)/arch/ia64/scripts/toolchain-flags $(CC) $(OBJDUMP) $(READELF))
+GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
+CPPFLAGS += $(shell $(srctree)/arch/ia64/scripts/toolchain-flags "$(CC)" "$(OBJDUMP)" "$(READELF)")
 
 ifeq ($(GAS_STATUS),buggy)
 $(error Sorry, you need a newer version of the assember, one that is built from	\
