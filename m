Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUJOQh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUJOQh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUJOQgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:36:50 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:64206 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S268170AbUJOQeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:34:46 -0400
Date: Fri, 15 Oct 2004 12:29:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] [2.6] Avoid silly recompile when LOCALVERSION changes
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410151233_MC3-1-8C4F-6F81@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This is really annoying...

  Any code that needs the kernel release name should include <utsname.h>
and use system_utsname.release instead of referring to UTS_RELEASE
from <version.h>

  sound/core/info.c and drivers/block/floppy.c need fixing as well.

  And at first glance, drivers/scsi/sg.c seems not to need version.h at all...

  drivers/scsi/aic7xxx and drivers/serial/8250*.c are also affected but they seem
more problematic.


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- linux-2.6.9-rc4/arch/i386/kernel/process.c.orig     2004-10-15 11:48:01.000000000 -0400
+++ linux-2.6.9-rc4/arch/i386/kernel/process.c  2004-10-15 11:55:57.711016144 -0400
@@ -28,7 +28,7 @@
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/config.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
@@ -230,7 +230,7 @@
 
        if (regs->xcs & 3)
                printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
-       printk(" EFLAGS: %08lx    %s  (%s)\n",regs->eflags, print_tainted(),UTS_RELEASE);
+       printk(" EFLAGS: %08lx    %s  (%s)\n",regs->eflags, print_tainted(), system_utsname.release);
        printk("EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
                regs->eax,regs->ebx,regs->ecx,regs->edx);
        printk("ESI: %08lx EDI: %08lx EBP: %08lx",
--- linux-2.6.9-rc4/arch/i386/kernel/traps.c.orig       2004-10-15 11:48:15.000000000 -0400
+++ linux-2.6.9-rc4/arch/i386/kernel/traps.c    2004-10-15 11:54:00.000000000 -0400
@@ -25,7 +25,7 @@
 #include <linux/highmem.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
 #include <linux/kprobes.h>
 
 #ifdef CONFIG_EISA
@@ -233,7 +233,7 @@
        printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\nEFLAGS: %08lx"
                        "   (%s) \n",
                smp_processor_id(), 0xffff & regs->xcs, regs->eip,
-               print_tainted(), regs->eflags, UTS_RELEASE);
+               print_tainted(), regs->eflags, system_utsname.release);
        print_symbol("EIP is at %s\n", regs->eip);
        printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
                regs->eax, regs->ebx, regs->ecx, regs->edx);



--Chuck Ebbert  15-Oct-04  12:28:34
