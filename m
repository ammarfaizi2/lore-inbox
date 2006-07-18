Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWGRL4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWGRL4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGRL4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:56:16 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:30481 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751322AbWGRL4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:56:15 -0400
Date: Tue, 18 Jul 2006 13:56:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 5/6] s390: .align 4096 statements in head.S
Message-ID: <20060718115622.GE20884@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] .align 4096 statements in head.S

SLES9 binutils don't like .align 4096 statements in head.S. Work around this
by using .org statements.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head31.S |    4 ++--
 arch/s390/kernel/head64.S |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-07-18 13:40:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-07-18 13:40:46.000000000 +0200
@@ -273,7 +273,7 @@ startup_continue:
 .Lbss_end:  .long _end
 .Lparmaddr: .long PARMAREA
 .Lsccbaddr: .long .Lsccb
-	.align	4096
+	.org	0x12000
 .Lsccb:
 	.hword	0x1000			# length, one page
 	.byte	0x00,0x00,0x00
@@ -290,7 +290,7 @@ startup_continue:
 .Lscpincr2:
 	.quad	0x00
 	.fill	3984,1,0
-	.align	4096
+	.org	0x13000
 
 #ifdef CONFIG_SHARED_KERNEL
 	.org	0x100000
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-07-18 13:40:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-07-18 13:40:46.000000000 +0200
@@ -268,7 +268,7 @@ startup_continue:
 .Lparmaddr:
 	.quad	PARMAREA
 
-	.align 4096
+	.org	0x12000
 .Lsccb:
 	.hword 0x1000			# length, one page
 	.byte 0x00,0x00,0x00
@@ -285,7 +285,7 @@ startup_continue:
 .Lscpincr2:
 	.quad 0x00
 	.fill 3984,1,0
-	.align 4096
+	.org	0x13000
 
 #ifdef CONFIG_SHARED_KERNEL
 	.org   0x100000
