Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVGROPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVGROPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVGROPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:15:15 -0400
Received: from Quebec-HSE-ppp231061.qc.sympatico.ca ([69.159.205.163]:31216
	"EHLO cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261754AbVGROPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:15:13 -0400
Subject: [PATCH] try_to_freeze call fixes.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <christoph@lameter.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121657807.13493.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 18 Jul 2005 13:36:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Here are fixes for four try_to_freeze calls that are still (incorrectly)
using a parameter after the recent try_to_freeze() changes.

Regards,

Nigel

Signed-Off by: Nigel Cunningham <nigel@suspend2.net>

 mips/kernel/irixsig.c  |    2 +-
 mips/kernel/signal32.c |    2 +-
 sh/kernel/signal.c     |    2 +-
 sh64/kernel/signal.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
diff -ruNp 202-more-try-to-freeze.patch-old/arch/mips/kernel/irixsig.c 202-more-try-to-freeze.patch-new/arch/mips/kernel/irixsig.c
--- 202-more-try-to-freeze.patch-old/arch/mips/kernel/irixsig.c	2005-06-20 11:46:44.000000000 +1000
+++ 202-more-try-to-freeze.patch-new/arch/mips/kernel/irixsig.c	2005-07-09 20:41:44.000000000 +1000
@@ -178,7 +178,7 @@ asmlinkage int do_irix_signal(sigset_t *
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze(0))
+	if (try_to_freeze())
 		goto no_signal;
 
 	if (!oldset)
diff -ruNp 202-more-try-to-freeze.patch-old/arch/mips/kernel/signal32.c 202-more-try-to-freeze.patch-new/arch/mips/kernel/signal32.c
--- 202-more-try-to-freeze.patch-old/arch/mips/kernel/signal32.c	2005-06-20 11:46:44.000000000 +1000
+++ 202-more-try-to-freeze.patch-new/arch/mips/kernel/signal32.c	2005-07-09 20:41:44.000000000 +1000
@@ -774,7 +774,7 @@ int do_signal32(sigset_t *oldset, struct
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze(0))
+	if (try_to_freeze())
 		goto no_signal;
 
 	if (!oldset)
diff -ruNp 202-more-try-to-freeze.patch-old/arch/sh/kernel/signal.c 202-more-try-to-freeze.patch-new/arch/sh/kernel/signal.c
--- 202-more-try-to-freeze.patch-old/arch/sh/kernel/signal.c	2005-06-20 11:46:47.000000000 +1000
+++ 202-more-try-to-freeze.patch-new/arch/sh/kernel/signal.c	2005-07-09 20:41:45.000000000 +1000
@@ -579,7 +579,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze(0))
+	if (try_to_freeze())
 		goto no_signal;
 
 	if (!oldset)
diff -ruNp 202-more-try-to-freeze.patch-old/arch/sh64/kernel/signal.c 202-more-try-to-freeze.patch-new/arch/sh64/kernel/signal.c
--- 202-more-try-to-freeze.patch-old/arch/sh64/kernel/signal.c	2005-06-20 11:46:47.000000000 +1000
+++ 202-more-try-to-freeze.patch-new/arch/sh64/kernel/signal.c	2005-07-09 20:41:45.000000000 +1000
@@ -697,7 +697,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze(0))
+	if (try_to_freeze())
 		goto no_signal;
 
 	if (!oldset)

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

