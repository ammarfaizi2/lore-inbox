Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVCSN3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVCSN3a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCSNWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:22:54 -0500
Received: from coderock.org ([193.77.147.115]:4488 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262468AbVCSNRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:49 -0500
Subject: [patch 07/10] arch/i386/kernel/traps.c: fix sparse warnings
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:35 +0100
Message-Id: <20050319131735.930951ECA8@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/kernel/traps.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -puN arch/i386/kernel/traps.c~sparse-arch_i386_kernel_traps arch/i386/kernel/traps.c
--- kj/arch/i386/kernel/traps.c~sparse-arch_i386_kernel_traps	2005-03-18 20:05:19.000000000 +0100
+++ kj-domen/arch/i386/kernel/traps.c	2005-03-18 20:05:19.000000000 +0100
@@ -233,22 +233,22 @@ void show_registers(struct pt_regs *regs
 	 * time of the fault..
 	 */
 	if (in_kernel) {
-		u8 *eip;
+		u8 __user *eip;
 
 		printk("\nStack: ");
 		show_stack(NULL, (unsigned long*)esp);
 
 		printk("Code: ");
 
-		eip = (u8 *)regs->eip - 43;
+		eip = (u8 __user *)regs->eip - 43;
 		for (i = 0; i < 64; i++, eip++) {
 			unsigned char c;
 
-			if (eip < (u8 *)PAGE_OFFSET || __get_user(c, eip)) {
+			if (eip < (u8 __user *)PAGE_OFFSET || __get_user(c, eip)) {
 				printk(" Bad EIP value.");
 				break;
 			}
-			if (eip == (u8 *)regs->eip)
+			if (eip == (u8 __user *)regs->eip)
 				printk("<%02x> ", c);
 			else
 				printk("%02x ", c);
@@ -272,13 +272,13 @@ static void handle_BUG(struct pt_regs *r
 
 	if (eip < PAGE_OFFSET)
 		goto no_bug;
-	if (__get_user(ud2, (unsigned short *)eip))
+	if (__get_user(ud2, (unsigned short __user *)eip))
 		goto no_bug;
 	if (ud2 != 0x0b0f)
 		goto no_bug;
-	if (__get_user(line, (unsigned short *)(eip + 2)))
+	if (__get_user(line, (unsigned short __user *)(eip + 2)))
 		goto bug;
-	if (__get_user(file, (char **)(eip + 4)) ||
+	if (__get_user(file, (char * __user *)(eip + 4)) ||
 		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
 		file = "<bad filename>";
 
_
