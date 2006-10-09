Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933005AbWJIT2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbWJIT2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbWJIT2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:28:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38591 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S933005AbWJIT2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:28:03 -0400
Date: Mon, 9 Oct 2006 20:28:03 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] s390 traps.c __user annotations
Message-ID: <20061009192803.GV29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/kernel/traps.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 05bf3cc..66375a5 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -474,7 +474,7 @@ #ifdef CONFIG_MATHEMU
 			signal = math_emu_b3(opcode, regs);
                 } else if (opcode[0] == 0xed) {
 			get_user(*((__u32 *) (opcode+2)),
-				 (__u32 *)(location+1));
+				 (__u32 __user *)(location+1));
 			signal = math_emu_ed(opcode, regs);
 		} else if (*((__u16 *) opcode) == 0xb299) {
 			get_user(*((__u16 *) (opcode+2)), location+1);
@@ -499,7 +499,7 @@ #ifdef CONFIG_MATHEMU
 		info.si_signo = signal;
 		info.si_errno = 0;
 		info.si_code = SEGV_MAPERR;
-		info.si_addr = (void *) location;
+		info.si_addr = (void __user *) location;
 		do_trap(interruption_code, signal,
 			"user address fault", regs, &info);
 	} else
@@ -520,10 +520,10 @@ asmlinkage void 
 specification_exception(struct pt_regs * regs, long interruption_code)
 {
         __u8 opcode[6];
-	__u16 *location = NULL;
+	__u16 __user *location = NULL;
 	int signal = 0;
 
-	location = (__u16 *) get_check_address(regs);
+	location = (__u16 __user *) get_check_address(regs);
 
 	/*
 	 * We got all needed information from the lowcore and can
@@ -632,7 +632,7 @@ #ifdef CONFIG_MATHEMU
 			break;
                 case 0xed:
 			get_user(*((__u32 *) (opcode+2)),
-				 (__u32 *)(location+1));
+				 (__u32 __user *)(location+1));
 			signal = math_emu_ed(opcode, regs);
 			break;
 	        case 0xb2:
-- 
1.4.2.GIT

