Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWHJUYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWHJUYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWHJUOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:48 -0400
Received: from ns.suse.de ([195.135.220.2]:41360 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932316AbWHJTgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:14 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [58/145] x86_64: AUX_DEVICE_INFO is one byte long, use 'movb'
Message-Id: <20060810193613.6650C13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:13 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Diego Calleja <diegocg@gmail.com>
Bugzilla #6552 says:

"In arch/i386/boot/setup.S, movw is used instead of movb for PS/2 mouse
information, although it is unsigned char. This does not harm, because
the jmp instruction overwritten by movw is used before executing movw,
and never be used again"

I've no idea if this is a real bug or how it gets fixed, so I'm submitting
it for review instead of letting it die of boredom in bugzilla. Aditionally
to i386, I've changed x86-64, which mirrors the same code.

Credits to Yoshinori K. Okuji, who found the problem and suggested a fix.


Signed-off-by: Diego Calleja <diegocg@gmail.com>
Signed-off-by: Andi Kleen <ak@suse.de>


---
 arch/i386/boot/setup.S   |    4 ++--
 arch/x86_64/boot/setup.S |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux/arch/i386/boot/setup.S
===================================================================
--- linux.orig/arch/i386/boot/setup.S
+++ linux/arch/i386/boot/setup.S
@@ -494,12 +494,12 @@ no_voyager:	
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax		# aka INITSEG
 	movw	%ax, %ds
-	movw	$0, (0x1ff)			# default is no pointing device
+	movb	$0, (0x1ff)			# default is no pointing device
 	int	$0x11				# int 0x11: equipment list
 	testb	$0x04, %al			# check if mouse installed
 	jz	no_psmouse
 
-	movw	$0xAA, (0x1ff)			# device present
+	movb	$0xAA, (0x1ff)			# device present
 no_psmouse:
 
 #if defined(CONFIG_X86_SPEEDSTEP_SMI) || defined(CONFIG_X86_SPEEDSTEP_SMI_MODULE)
Index: linux/arch/x86_64/boot/setup.S
===================================================================
--- linux.orig/arch/x86_64/boot/setup.S
+++ linux/arch/x86_64/boot/setup.S
@@ -526,12 +526,12 @@ is_disk1:
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax		# aka INITSEG
 	movw	%ax, %ds
-	movw	$0, (0x1ff)			# default is no pointing device
+	movb	$0, (0x1ff)			# default is no pointing device
 	int	$0x11				# int 0x11: equipment list
 	testb	$0x04, %al			# check if mouse installed
 	jz	no_psmouse
 
-	movw	$0xAA, (0x1ff)			# device present
+	movb	$0xAA, (0x1ff)			# device present
 no_psmouse:
 
 #include "../../i386/boot/edd.S"
