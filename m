Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSG1Qli>; Sun, 28 Jul 2002 12:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSG1Qli>; Sun, 28 Jul 2002 12:41:38 -0400
Received: from ppp77-4-71.miem.edu.ru ([194.226.32.71]:13440 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S316906AbSG1Qlh>;
	Sun, 28 Jul 2002 12:41:37 -0400
Message-ID: <3D4419F5.3000104@yahoo.com>
Date: Sun, 28 Jul 2002 20:21:09 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] vm86: Clear AC on INT
Content-Type: multipart/mixed;
 boundary="------------040407000509040300030509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040407000509040300030509
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

According to this:
http://support.intel.com/design/intarch/techinfo/Pentium/instrefi.htm#89126
AC flag is cleared by an INT
instruction executed in real mode.
The attached patch implements that
functionality and solves some
problems recently discussed in
dosemu mailing list.

--------------040407000509040300030509
Content-Type: text/plain;
 name="vm86_ac.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm86_ac.diff"

--- linux/arch/i386/kernel/vm86.c	Sat Jul 27 13:12:38 2002
+++ linux/arch/i386/kernel/vm86.c	Sat Jul 27 23:56:27 2002
@@ -317,6 +317,11 @@
 	regs->eflags &= ~TF_MASK;
 }
 
+static inline void clear_AC(struct kernel_vm86_regs * regs)
+{
+	regs->eflags &= ~AC_MASK;
+}
+
 /* It is correct to call set_IF(regs) from the set_vflags_*
  * functions. However someone forgot to call clear_IF(regs)
  * in the opposite case.
@@ -471,6 +476,7 @@
 	IP(regs) = segoffs & 0xffff;
 	clear_TF(regs);
 	clear_IF(regs);
+	clear_AC(regs);
 	return;
 
 cannot_handle:

--------------040407000509040300030509--

