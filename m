Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTAEKj0>; Sun, 5 Jan 2003 05:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTAEKj0>; Sun, 5 Jan 2003 05:39:26 -0500
Received: from daimi.au.dk ([130.225.16.1]:38349 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S264646AbTAEKjZ>;
	Sun, 5 Jan 2003 05:39:25 -0500
Message-ID: <3E180D5C.996D8129@daimi.au.dk>
Date: Sun, 05 Jan 2003 11:47:56 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] VM86 patch
Content-Type: multipart/mixed;
 boundary="------------145B55840E6590168DBF7CE4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------145B55840E6590168DBF7CE4
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Is there some reason for not applying
http://dosemu.sourceforge.net/stas/traps.diff
to the 2.5 kernel? Or was it just forgotten?

I have attached a version that applies cleanly
to 2.5.54.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
--------------145B55840E6590168DBF7CE4
Content-Type: text/plain; charset=us-ascii;
 name="vm86.2.5.54.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm86.2.5.54.patch"

diff -Nur linux.old/arch/i386/kernel/traps.c linux.new/arch/i386/kernel/traps.c
--- linux.old/arch/i386/kernel/traps.c	Sun Jan  5 11:26:56 2003
+++ linux.new/arch/i386/kernel/traps.c	Sun Jan  5 11:28:20 2003
@@ -320,8 +320,12 @@
 static inline void do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
-	if (vm86 && regs->eflags & VM_MASK)
-		goto vm86_trap;
+	if (regs->eflags & VM_MASK) {
+		if (vm86)
+			goto vm86_trap;
+		else
+			goto trap_signal;
+	}
 
 	if (!(regs->xcs & 3))
 		goto kernel_trap;

--------------145B55840E6590168DBF7CE4--

