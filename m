Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbTCWIqp>; Sun, 23 Mar 2003 03:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262982AbTCWIqo>; Sun, 23 Mar 2003 03:46:44 -0500
Received: from mail.bytecamp.net ([195.127.199.19]:48647 "EHLO
	mail.bytecamp.net") by vger.kernel.org with ESMTP
	id <S262981AbTCWIqn>; Sun, 23 Mar 2003 03:46:43 -0500
Subject: [PATCH] Tiny compile include fix
From: Christian Neumair <chris@gnome-de.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048411249.27971.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 23 Mar 2003 10:20:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!
The patch sent with this email fixes the following compile problem:

-- snip --
In file included from arch/i386/kernel/acpi/boot.c:34:
include/asm-i386/mach-numaq/mach_apic.h: In function
`setup_portio_remap':
include/asm-i386/mach-numaq/mach_apic.h:96: `xquad_portio' undeclared
(first use in this function)
include/asm-i386/mach-numaq/mach_apic.h:96: (Each undeclared identifier
is reported only once
include/asm-i386/mach-numaq/mach_apic.h:96: for each function it appears
in.)
include/asm-i386/mach-numaq/mach_apic.h:96: warning: implicit
declaration of function `ioremap'
include/asm-i386/mach-numaq/mach_apic.h:96: `XQUAD_PORTIO_BASE'
undeclared (first use in this function)
include/asm-i386/mach-numaq/mach_apic.h:96: `XQUAD_PORTIO_QUAD'
undeclared (first use in this function)
include/asm-i386/mach-numaq/mach_mpparse.h: At top level:
include/asm-i386/mach-numaq/mach_mpparse.h:5: warning:
`smp_read_mpc_oem' declared `static' but never defined
make[2]: *** [arch/i386/kernel/acpi/boot.o] Fehler 1
make[1]: *** [arch/i386/kernel/acpi] Fehler 2
make: *** [arch/i386/kernel] Fehler 2
-- snap --

This is my first patch sent to this ML so I hope to have respected all
formal guidelines.

regs,
 Chris

Index: arch/i386/kernel/acpi/boot.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/acpi/boot.c,v
retrieving revision 1.4
diff -u -r1.4 boot.c
--- arch/i386/kernel/acpi/boot.c	27 Feb 2003 16:44:23 -0000	1.4
+++ arch/i386/kernel/acpi/boot.c	23 Mar 2003 07:59:32 -0000
@@ -26,9 +26,10 @@
 #include <linux/init.h>
 #include <linux/config.h>
 #include <linux/acpi.h>
-#include <asm/pgalloc.h>
 #include <asm/apic.h>
+#include <asm/io.h>
 #include <asm/mpspec.h>
+#include <asm/pgalloc.h>
 
 #if defined (CONFIG_X86_LOCAL_APIC)
 #include <mach_apic.h>


