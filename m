Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131423AbQKKQtG>; Sat, 11 Nov 2000 11:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbQKKQs4>; Sat, 11 Nov 2000 11:48:56 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:42171 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131245AbQKKQsl>;
	Sat, 11 Nov 2000 11:48:41 -0500
Date: Sat, 11 Nov 2000 17:48:38 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011111648.RAA27710@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: 2.4.0-test11pre2: one more Pentium IV CPU naming fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The patch below (for 2.4.0-test11pre2) makes include/asm-i386/elf.h's
ELF_PLATFORM be an alias for system_utsname.machine. bugs.h (which
initialises system_utsname.machine) and elf.h use the same algorithm
to map boot_cpu_data.x86 to a name, so it makes sense to share the
name between them, especially if we ever come up with a better naming
scheme (just one place to fix, not two).

This doesn't change any current 2.4 behaviour wrt to the Pentium IV.
However, 2.2.18pre's version of elf.h is currently broken for
the Pentium IV, and I want the same "nice" fix in both kernels.
(I'm sending an equivalent patch to Alan for 2.2.18pre.)

/Mikael

--- linux-2.4.0-test11pre2/include/asm-i386/elf.h.~1~	Tue Oct 31 23:34:20 2000
+++ linux-2.4.0-test11pre2/include/asm-i386/elf.h	Fri Nov 10 16:37:12 2000
@@ -7,6 +7,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
+#include <linux/utsname.h>
 
 typedef unsigned long elf_greg_t;
 
@@ -93,7 +94,7 @@
    For the moment, we have only optimizations for the Intel generations,
    but that could change... */
 
-#define ELF_PLATFORM  ("i386\0i486\0i586\0i686"+(((boot_cpu_data.x86>6?6:boot_cpu_data.x86)-3)*5))
+#define ELF_PLATFORM (system_utsname.machine)
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
