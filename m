Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWGBAW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWGBAW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWGBAW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:22:56 -0400
Received: from mx1.pretago.de ([89.110.132.150]:18629 "EHLO mx1.pretago.de")
	by vger.kernel.org with ESMTP id S964886AbWGBAWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:22:55 -0400
From: Markus Schoder <lists@gammarayburst.de>
To: discuss@x86-64.org
Subject: [PATCH] Bring x86-64 ia32 emul in sync with i386 on READ_IMPLIES_EXEC enabling
Date: Sun, 2 Jul 2006 02:22:51 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607020222.51426.lists@gammarayburst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ia32 binaries behave differently with respect to enabling
READ_IMPLIES_EXEC. On i386 a binary with the exec_stack flag set is
executed with READ_IMPLIES_EXEC enabled as well. The same binary
executes without READ_IMPLIES_EXEC on x86-64.

This causes binaries that work on i386 to fail on x86-64 which goes
somewhat against the whole 32 bit emulation idea.

It has been argued that READ_IMPLIES_EXEC should not be enabled at all
for binaries that have the exec_stack flag. Which is probably a valid
point. However until this is clarified I think x86-64 should behave the
same for ia32 binaries as i386.

The following patch brings x86-64 in sync with i386 for ia32 binaries.

Signed-off-by: Markus Schoder <lists@gammarayburst.de>

-----

diff -u -r linux-2.6.17.3.old/arch/x86_64/ia32/ia32_binfmt.c linux-2.6.17.3/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.17.3.old/arch/x86_64/ia32/ia32_binfmt.c   2006-06-18 15:10:19.000000000 +0200
+++ linux-2.6.17.3/arch/x86_64/ia32/ia32_binfmt.c       2006-07-01 16:59:56.121915808 +0200
@@ -182,7 +182,7 @@
 #define user user32

 #define __ASM_X86_64_ELF_H 1
-#define elf_read_implies_exec(ex, have_pt_gnu_stack)   (!(have_pt_gnu_stack))
+#define elf_read_implies_exec(ex, executable_stack)     (executable_stack != EXSTACK_DISABLE_X)
 //#include <asm/ia32.h>
 #include <linux/elf.h>

