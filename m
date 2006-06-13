Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWFMTzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWFMTzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWFMTzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:55:05 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:3807 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932150AbWFMTzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:55:03 -0400
Date: Tue, 13 Jun 2006 21:55:02 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH -mm] i386 usercopy.c opcode reordering (pipelining)
Message-ID: <20060613195502.GE24167@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this one wrote to register %0 and immediately right-shifted it,
so let's andl register %3 first for better parallelism (rrright?).

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc6-mm2.orig/arch/i386/lib/usercopy.c linux-2.6.17-rc6-mm2.my/arch/i386/lib/usercopy.c
--- linux-2.6.17-rc6-mm2.orig/arch/i386/lib/usercopy.c	2006-06-13 19:28:09.000000000 +0200
+++ linux-2.6.17-rc6-mm2.my/arch/i386/lib/usercopy.c	2006-06-13 19:38:11.000000000 +0200
@@ -646,8 +646,8 @@
 		"	subl %0,%3\n"					\
 		"4:	rep; movsb\n"					\
 		"	movl %3,%0\n"					\
-		"	shrl $2,%0\n"					\
 		"	andl $3,%3\n"					\
+		"	shrl $2,%0\n"					\
 		"	.align 2,0x90\n"				\
 		"0:	rep; movsl\n"					\
 		"	movl %3,%0\n"					\
@@ -682,8 +682,8 @@
 		"	subl %0,%3\n"					\
 		"4:	rep; movsb\n"					\
 		"	movl %3,%0\n"					\
-		"	shrl $2,%0\n"					\
 		"	andl $3,%3\n"					\
+		"	shrl $2,%0\n"					\
 		"	.align 2,0x90\n"				\
 		"0:	rep; movsl\n"					\
 		"	movl %3,%0\n"					\
