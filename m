Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131399AbQKKQug>; Sat, 11 Nov 2000 11:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131245AbQKKQu0>; Sat, 11 Nov 2000 11:50:26 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:54715 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131399AbQKKQuM>;
	Sat, 11 Nov 2000 11:50:12 -0500
Date: Sat, 11 Nov 2000 17:50:01 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011111650.RAA27725@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: 2.2.18pre Pentium IV bug fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

2.2.18pre's include/asm-i386/elf.h is currently broken for the
Pentium IV (out of bounds array indexing error).
Since ELF_PLATFORM is identical to system_utsname.machine, the
patch below simply tosses ELF_PLATFORM's broken name generation
code and uses system_utsname.machine instead.
There is no behavioural change for P6 and lesser CPUs.

/Mikael


--- linux-2.2.18pre21/include/asm-i386/elf.h.~1~	Tue Aug 10 19:00:00 1999
+++ linux-2.2.18pre21/include/asm-i386/elf.h	Fri Nov 10 14:57:39 2000
@@ -7,6 +7,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
+#include <linux/utsname.h>
 
 typedef unsigned long elf_greg_t;
 
@@ -93,7 +94,7 @@
    For the moment, we have only optimizations for the Intel generations,
    but that could change... */
 
-#define ELF_PLATFORM  ("i386\0i486\0i586\0i686"+((boot_cpu_data.x86-3)*5))
+#define ELF_PLATFORM (system_utsname.machine)
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) \
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
