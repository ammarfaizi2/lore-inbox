Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993152AbWJUQvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993152AbWJUQvr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993151AbWJUQvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4792 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2993150AbWJUQvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:41 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [11/19] i386: Fix fake return address
Message-Id: <20061021165131.4FDD813C4D@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:31 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeremy Fitzhardinge <jeremy@goop.org>
The fake return address was being set to __KERNEL_PDA, rather than 0.
Push it earlier while %eax still equals 0.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>

---
 arch/i386/kernel/head.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/i386/kernel/head.S
===================================================================
--- linux.orig/arch/i386/kernel/head.S
+++ linux/arch/i386/kernel/head.S
@@ -317,7 +317,7 @@ is386:	movl $2,%ecx		# set MP
 	movl %eax,%gs
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
-	pushl %eax		# fake return address
+	pushl $0		# fake return address for unwinder
 #ifdef CONFIG_SMP
 	movb ready, %cl
 	movb $1, ready
