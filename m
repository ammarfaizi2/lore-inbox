Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRGSXpt>; Thu, 19 Jul 2001 19:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbRGSXpj>; Thu, 19 Jul 2001 19:45:39 -0400
Received: from [198.99.130.100] ([198.99.130.100]:63617 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S266263AbRGSXp2>;
	Thu, 19 Jul 2001 19:45:28 -0400
Message-Id: <200107192245.f6JMjcR08865@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7pre8aa1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Jul 2001 18:45:38 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Only in 2.4.7pre6aa1: 51_uml-ac-to-aa-2.bz2
> Only in 2.4.7pre8aa1/: 51_uml-ac-to-aa-3.bz2
>         Moved part of it in the tux directory so it can compile
>         without tux (in reality I got errno compilation error
>         but it's low prio and I'll sort it out later, Jeff Dike any
>         hint is welcome ;).

This is the patch I sent to Alan a while back which works around the problem.

rmk suggested a better way which I'll add at some point.

				Jeff


diff -Naur -X exclude-files ac_cur/arch/um/Makefile ac/arch/um/Makefile
--- ac_cur/arch/um/Makefile	Mon Jul  9 13:05:03 2001
+++ ac/arch/um/Makefile	Mon Jul  9 13:26:21 2001
@@ -20,6 +20,8 @@
 LINK_PROFILE = $(PROFILE) -Wl,--wrap,__monstartup
 endif
 
+CFLAGS := $(subst -fno-common,,$(CFLAGS))
+
 SUBDIRS += $(ARCH_DIR)/fs $(ARCH_DIR)/drivers $(ARCH_DIR)/kernel \
 	$(ARCH_DIR)/sys-$(SUBARCH)


