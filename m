Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263105AbUJ2GOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbUJ2GOz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 02:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUJ2GOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 02:14:55 -0400
Received: from mail.renesas.com ([202.234.163.13]:49085 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S263105AbUJ2GOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 02:14:52 -0400
Date: Fri, 29 Oct 2004 15:14:35 +0900 (JST)
Message-Id: <20041029.151435.576023126.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc1] [m32r] Fix a typo of delay.c
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch fixes a typo of arch/m32r/lib/delay.c.
It is required to fix a compile error for non-CONFIG_ISA_DUAL_ISSUE 
configuration.

Thanks.

NOTE:
  The m32r has a kind of ISA (instruction set architecture) 
  like a 2-way VLIW.  Originally the m32r has two types of 16-bit/32-bit
  instructions.  Only 16-bit instruction pair can be executed in parallel
  on a m32r chip with dual issuing support (e.g. M32700).

  According to the insturction dual issuing of the m32r, 
  a programmer/compiler can explicitly put two 16-bit instructions 
  into an instruction word, which are to be executed in parallel.

  ex. Assembly coding style of two 16-bit instruncions; insn A and B:

    1) insn A
       insn B              ; sequential execution (implicit)

    2) insn A -> insn B	   ; sequential execution (explicit)

    3) insn A || insn B	   ; parallel execution


Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/lib/delay.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -ruNp a/arch/m32r/lib/delay.c b/arch/m32r/lib/delay.c
--- a/arch/m32r/lib/delay.c	2004-10-19 06:55:35.000000000 +0900
+++ b/arch/m32r/lib/delay.c	2004-10-29 13:05:36.000000000 +0900
@@ -51,7 +51,7 @@ void __delay(unsigned long loops)
 		"addi	%0, #-1			\n\t"
 		"bgtz	%0, 1b			\n\t"
 		" .fillinsn			\n\t"
-		"2:i				\n\t"
+		"2:				\n\t"
 		: "+r" (loops)
 		: "r" (0)
 	);

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
