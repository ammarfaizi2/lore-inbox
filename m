Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264237AbVBDTjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264237AbVBDTjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbVBDTjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:39:51 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:64779 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S266556AbVBDTjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:39:01 -0500
Message-ID: <4203CF43.20703@tuxrocks.com>
Date: Fri, 04 Feb 2005 12:38:43 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       UML Devel <user-mode-linux-devel@lists.sourceforge.net>,
       "Frank Denis (Jedi/Sector One)" <lkml@pureftpd.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Dike <jdike@addtoit.com>
Subject: Fix compilation of UML after the stack-randomization patches
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070607010000030806070102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607010000030806070102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The stack randomization patches that went into 2.6.11-rc3-mm1 broke 
compilation of ARCH=um.  This patch fixes compiling by adding 
arch_align_stack back in.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
Acked-By: Jeff Dike <jdike@addtoit.com>

Frank
-- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com

--------------070607010000030806070102
Content-Type: text/plain;
 name="um-2.6.11-randomization-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="um-2.6.11-randomization-fix"

diff -Naur linux-2.6.11-rc3-mm1_bak/arch/um/kernel/process_kern.c linux-2.6.11-rc3-mm1/arch/um/kernel/process_kern.c
--- linux-2.6.11-rc3-mm1_bak/arch/um/kernel/process_kern.c	2005-02-04 12:09:03.000000000 -0700
+++ linux-2.6.11-rc3-mm1/arch/um/kernel/process_kern.c	2005-02-04 12:16:59.000000000 -0700
@@ -21,6 +21,7 @@
 #include "linux/spinlock.h"
 #include "linux/proc_fs.h"
 #include "linux/ptrace.h"
+#include "linux/random.h"
 #include "asm/unistd.h"
 #include "asm/mman.h"
 #include "asm/segment.h"
@@ -479,6 +480,14 @@
 	return 2;
 }
 
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (randomize_va_space)
+		sp -= get_random_int() % 8192;
+	return sp & ~0xf;
+}
+
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

--------------070607010000030806070102--
