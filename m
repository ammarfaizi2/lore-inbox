Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUHYSD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUHYSD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUHYSD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:03:56 -0400
Received: from holomorphy.com ([207.189.100.168]:19086 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268121AbUHYSBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:01:54 -0400
Date: Wed, 25 Aug 2004 11:01:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [1/2] convert linux/user.h users to asm/user.h
Message-ID: <20040825180138.GA2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819150632.GP11200@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 03:39:07PM +0100, Dave Jones wrote:
>> I noticed that every file that could be built as a module was sucking
>> in sched.h (and therefore, every other include file under the sun).
>> This patch
>[... which bits got moved to more appropriate places...]

On Thu, Aug 19, 2004 at 08:06:32AM -0700, William Lee Irwin III wrote:
> sched.h is such an extreme garbage can header I wouldn't mind seeing the
> whole thing torn completely apart. Every little trimming is good. =)

I hereby declare open season on linux/sched.h!

In preparation for moving all user-related bits out of sched.h and
coopting linux/user.h for this purpose, this patch converts all
inclusions of linux/user.h to asm/user.h

The #error in linux/user.h is blown away by the successor to this
patch, which fills it in with user-related bits split off from sched.h.

vs. 2.6.8.1-mm4


Index: mm4-2.6.8.1/arch/alpha/kernel/alpha_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/alpha/kernel/alpha_ksyms.c	2004-08-25 09:53:58.804142696 -0700
+++ mm4-2.6.8.1/arch/alpha/kernel/alpha_ksyms.c	2004-08-25 09:54:39.877898536 -0700
@@ -8,7 +8,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/socket.h>
 #include <linux/syscalls.h>
Index: mm4-2.6.8.1/arch/alpha/kernel/osf_sys.c
===================================================================
--- mm4-2.6.8.1.orig/arch/alpha/kernel/osf_sys.c	2004-08-25 09:53:58.816140872 -0700
+++ mm4-2.6.8.1/arch/alpha/kernel/osf_sys.c	2004-08-25 09:54:39.878898384 -0700
@@ -21,7 +21,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/utsname.h>
 #include <linux/time.h>
@@ -38,6 +37,7 @@
 #include <linux/uio.h>
 #include <linux/vfs.h>
 
+#include <asm/user.h>
 #include <asm/fpu.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/arch/alpha/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/alpha/kernel/process.c	2004-08-25 09:53:58.817140720 -0700
+++ mm4-2.6.8.1/arch/alpha/kernel/process.c	2004-08-25 09:54:39.878898384 -0700
@@ -20,7 +20,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/utsname.h>
 #include <linux/time.h>
Index: mm4-2.6.8.1/arch/alpha/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/alpha/kernel/ptrace.c	2004-08-25 09:53:58.817140720 -0700
+++ mm4-2.6.8.1/arch/alpha/kernel/ptrace.c	2004-08-25 09:54:39.878898384 -0700
@@ -11,10 +11,10 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/slab.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/alpha/kernel/setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/alpha/kernel/setup.c	2004-08-25 09:53:58.817140720 -0700
+++ mm4-2.6.8.1/arch/alpha/kernel/setup.c	2004-08-25 09:54:39.879898232 -0700
@@ -17,7 +17,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/delay.h>
@@ -39,6 +38,7 @@
 #include <linux/reboot.h>
 #endif
 #include <linux/notifier.h>
+#include <asm/user.h>
 #include <asm/setup.h>
 #include <asm/io.h>
 
Index: mm4-2.6.8.1/arch/arm/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm/kernel/process.c	2004-08-23 16:10:52.000000000 -0700
+++ mm4-2.6.8.1/arch/arm/kernel/process.c	2004-08-25 09:55:32.414911696 -0700
@@ -19,7 +19,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
@@ -27,6 +26,7 @@
 #include <linux/kallsyms.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/leds.h>
Index: mm4-2.6.8.1/arch/arm/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm/kernel/ptrace.c	2004-08-23 16:11:18.000000000 -0700
+++ mm4-2.6.8.1/arch/arm/kernel/ptrace.c	2004-08-25 09:55:43.379244864 -0700
@@ -15,10 +15,10 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/security.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/arm26/kernel/armksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm26/kernel/armksyms.c	2004-08-14 03:55:19.000000000 -0700
+++ mm4-2.6.8.1/arch/arm26/kernel/armksyms.c	2004-08-25 09:55:21.754532320 -0700
@@ -9,7 +9,6 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/user.h>
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
@@ -23,6 +22,7 @@
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 
+#include <asm/user.h>
 #include <asm/byteorder.h>
 #include <asm/elf.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/arch/arm26/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm26/kernel/process.c	2004-08-25 09:53:58.817140720 -0700
+++ mm4-2.6.8.1/arch/arm26/kernel/process.c	2004-08-25 09:54:39.879898232 -0700
@@ -20,13 +20,13 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/leds.h>
Index: mm4-2.6.8.1/arch/arm26/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm26/kernel/ptrace.c	2004-08-25 09:53:58.817140720 -0700
+++ mm4-2.6.8.1/arch/arm26/kernel/ptrace.c	2004-08-25 09:54:39.879898232 -0700
@@ -16,9 +16,9 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/cris/arch-v10/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/cris/arch-v10/kernel/ptrace.c	2004-08-25 09:53:58.817140720 -0700
+++ mm4-2.6.8.1/arch/cris/arch-v10/kernel/ptrace.c	2004-08-25 09:54:39.879898232 -0700
@@ -9,8 +9,8 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/cris/kernel/crisksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/cris/kernel/crisksyms.c	2004-08-14 03:55:48.000000000 -0700
+++ mm4-2.6.8.1/arch/cris/kernel/crisksyms.c	2004-08-25 09:58:33.753344064 -0700
@@ -1,6 +1,5 @@
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/sched.h>
 #include <linux/in6.h>
Index: mm4-2.6.8.1/arch/cris/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/cris/kernel/process.c	2004-08-25 09:53:58.818140568 -0700
+++ mm4-2.6.8.1/arch/cris/kernel/process.c	2004-08-25 09:54:39.880898080 -0700
@@ -110,7 +110,6 @@
 #include <linux/init_task.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/mqueue.h>
 
Index: mm4-2.6.8.1/arch/cris/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/cris/kernel/ptrace.c	2004-08-25 09:53:58.818140568 -0700
+++ mm4-2.6.8.1/arch/cris/kernel/ptrace.c	2004-08-25 09:54:39.880898080 -0700
@@ -64,8 +64,8 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/h8300/kernel/h8300_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/h8300/kernel/h8300_ksyms.c	2004-08-25 09:53:58.818140568 -0700
+++ mm4-2.6.8.1/arch/h8300/kernel/h8300_ksyms.c	2004-08-25 09:54:39.880898080 -0700
@@ -3,7 +3,6 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/in6.h>
 #include <linux/interrupt.h>
Index: mm4-2.6.8.1/arch/h8300/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/h8300/kernel/process.c	2004-08-25 09:53:58.818140568 -0700
+++ mm4-2.6.8.1/arch/h8300/kernel/process.c	2004-08-25 09:54:39.880898080 -0700
@@ -34,11 +34,11 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/traps.h>
Index: mm4-2.6.8.1/arch/h8300/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/h8300/kernel/ptrace.c	2004-08-25 09:53:58.818140568 -0700
+++ mm4-2.6.8.1/arch/h8300/kernel/ptrace.c	2004-08-25 09:54:39.881897928 -0700
@@ -22,9 +22,9 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/config.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/i386/kernel/i386_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/i386/kernel/i386_ksyms.c	2004-08-23 16:10:55.000000000 -0700
+++ mm4-2.6.8.1/arch/i386/kernel/i386_ksyms.c	2004-08-25 09:55:50.992087536 -0700
@@ -1,7 +1,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/smp.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/mca.h>
 #include <linux/sched.h>
Index: mm4-2.6.8.1/arch/i386/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/i386/kernel/process.c	2004-08-25 09:53:58.818140568 -0700
+++ mm4-2.6.8.1/arch/i386/kernel/process.c	2004-08-25 09:54:39.881897928 -0700
@@ -25,7 +25,6 @@
 #include <linux/stddef.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/config.h>
@@ -39,6 +38,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/i386/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/i386/kernel/ptrace.c	2004-08-25 09:53:58.818140568 -0700
+++ mm4-2.6.8.1/arch/i386/kernel/ptrace.c	2004-08-25 09:54:39.881897928 -0700
@@ -12,10 +12,10 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/ia64/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/kernel/ptrace.c	2004-08-25 09:53:58.819140416 -0700
+++ mm4-2.6.8.1/arch/ia64/kernel/ptrace.c	2004-08-25 09:54:39.882897776 -0700
@@ -15,9 +15,9 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/smp_lock.h>
-#include <linux/user.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/ptrace_offsets.h>
Index: mm4-2.6.8.1/arch/m68k/kernel/m68k_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68k/kernel/m68k_ksyms.c	2004-08-25 09:53:58.819140416 -0700
+++ mm4-2.6.8.1/arch/m68k/kernel/m68k_ksyms.c	2004-08-25 09:54:39.882897776 -0700
@@ -3,7 +3,6 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/in6.h>
 #include <linux/interrupt.h>
Index: mm4-2.6.8.1/arch/m68k/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68k/kernel/process.c	2004-08-25 09:53:58.819140416 -0700
+++ mm4-2.6.8.1/arch/m68k/kernel/process.c	2004-08-25 09:54:39.882897776 -0700
@@ -22,12 +22,12 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/reboot.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/traps.h>
Index: mm4-2.6.8.1/arch/m68k/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68k/kernel/ptrace.c	2004-08-25 09:53:58.819140416 -0700
+++ mm4-2.6.8.1/arch/m68k/kernel/ptrace.c	2004-08-25 09:54:39.882897776 -0700
@@ -17,9 +17,9 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/config.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/m68k/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68k/kernel/traps.c	2004-08-25 09:53:58.819140416 -0700
+++ mm4-2.6.8.1/arch/m68k/kernel/traps.c	2004-08-25 09:54:39.883897624 -0700
@@ -25,13 +25,13 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/a.out.h>
-#include <linux/user.h>
 #include <linux/string.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/ptrace.h>
 #include <linux/kallsyms.h>
 
+#include <asm/user.h>
 #include <asm/setup.h>
 #include <asm/fpu.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/m68knommu/kernel/m68k_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68knommu/kernel/m68k_ksyms.c	2004-08-25 09:53:58.819140416 -0700
+++ mm4-2.6.8.1/arch/m68knommu/kernel/m68k_ksyms.c	2004-08-25 09:54:39.883897624 -0700
@@ -3,7 +3,6 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/in6.h>
 #include <linux/interrupt.h>
Index: mm4-2.6.8.1/arch/m68knommu/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68knommu/kernel/process.c	2004-08-25 09:53:58.820140264 -0700
+++ mm4-2.6.8.1/arch/m68knommu/kernel/process.c	2004-08-25 09:54:39.883897624 -0700
@@ -25,11 +25,11 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/traps.h>
Index: mm4-2.6.8.1/arch/m68knommu/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68knommu/kernel/ptrace.c	2004-08-25 09:53:58.820140264 -0700
+++ mm4-2.6.8.1/arch/m68knommu/kernel/ptrace.c	2004-08-25 09:54:39.884897472 -0700
@@ -17,9 +17,9 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/config.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/m68knommu/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68knommu/kernel/traps.c	2004-08-25 09:53:58.820140264 -0700
+++ mm4-2.6.8.1/arch/m68knommu/kernel/traps.c	2004-08-25 09:54:39.884897472 -0700
@@ -23,12 +23,12 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/a.out.h>
-#include <linux/user.h>
 #include <linux/string.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/ptrace.h>
 
+#include <asm/user.h>
 #include <asm/setup.h>
 #include <asm/fpu.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/mips/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/kernel/process.c	2004-08-25 09:53:58.820140264 -0700
+++ mm4-2.6.8.1/arch/mips/kernel/process.c	2004-08-25 09:54:39.884897472 -0700
@@ -19,11 +19,11 @@
 #include <linux/mman.h>
 #include <linux/personality.h>
 #include <linux/sys.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/init.h>
 #include <linux/completion.h>
 
+#include <asm/user.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
Index: mm4-2.6.8.1/arch/mips/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/kernel/ptrace.c	2004-08-25 09:53:58.820140264 -0700
+++ mm4-2.6.8.1/arch/mips/kernel/ptrace.c	2004-08-25 09:54:39.884897472 -0700
@@ -23,9 +23,9 @@
 #include <linux/ptrace.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-#include <linux/user.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
Index: mm4-2.6.8.1/arch/mips/kernel/ptrace32.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/kernel/ptrace32.c	2004-08-25 09:53:58.820140264 -0700
+++ mm4-2.6.8.1/arch/mips/kernel/ptrace32.c	2004-08-25 09:54:39.884897472 -0700
@@ -22,9 +22,9 @@
 #include <linux/ptrace.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-#include <linux/user.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
Index: mm4-2.6.8.1/arch/mips/kernel/setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/kernel/setup.c	2004-08-25 09:53:58.820140264 -0700
+++ mm4-2.6.8.1/arch/mips/kernel/setup.c	2004-08-25 09:54:39.885897320 -0700
@@ -22,7 +22,6 @@
 #include <linux/string.h>
 #include <linux/unistd.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/utsname.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
@@ -34,6 +33,7 @@
 #include <linux/highmem.h>
 #include <linux/console.h>
 
+#include <asm/user.h>
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
Index: mm4-2.6.8.1/arch/parisc/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/parisc/kernel/ptrace.c	2004-08-25 09:53:58.821140112 -0700
+++ mm4-2.6.8.1/arch/parisc/kernel/ptrace.c	2004-08-25 09:54:39.885897320 -0700
@@ -13,11 +13,11 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/personality.h>
 #include <linux/security.h>
 #include <linux/compat.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/ppc/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/kernel/process.c	2004-08-23 16:11:15.000000000 -0700
+++ mm4-2.6.8.1/arch/ppc/kernel/process.c	2004-08-25 09:56:04.811986592 -0700
@@ -28,7 +28,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/elf.h>
 #include <linux/init.h>
 #include <linux/prctl.h>
@@ -38,6 +37,7 @@
 #include <linux/perfctr.h>
 #include <linux/mqueue.h>
 
+#include <asm/user.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/ppc/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/kernel/ptrace.c	2004-08-14 03:55:09.000000000 -0700
+++ mm4-2.6.8.1/arch/ppc/kernel/ptrace.c	2004-08-25 09:56:18.574894312 -0700
@@ -24,9 +24,9 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/ppc/kernel/softemu8xx.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/kernel/softemu8xx.c	2004-08-14 03:55:33.000000000 -0700
+++ mm4-2.6.8.1/arch/ppc/kernel/softemu8xx.c	2004-08-25 09:56:31.193975920 -0700
@@ -22,10 +22,10 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 
+#include <asm/user.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/ppc/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/kernel/traps.c	2004-08-23 16:10:56.000000000 -0700
+++ mm4-2.6.8.1/arch/ppc/kernel/traps.c	2004-08-25 09:56:41.239448776 -0700
@@ -24,7 +24,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/config.h>
@@ -32,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/prctl.h>
 
+#include <asm/user.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/ppc/platforms/chrp_setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/platforms/chrp_setup.c	2004-08-25 09:53:58.822139960 -0700
+++ mm4-2.6.8.1/arch/ppc/platforms/chrp_setup.c	2004-08-25 09:54:39.885897320 -0700
@@ -19,7 +19,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/major.h>
@@ -38,6 +37,7 @@
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
 
+#include <asm/user.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
Index: mm4-2.6.8.1/arch/ppc/platforms/pmac_setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/platforms/pmac_setup.c	2004-08-25 09:53:58.822139960 -0700
+++ mm4-2.6.8.1/arch/ppc/platforms/pmac_setup.c	2004-08-25 09:54:39.886897168 -0700
@@ -33,7 +33,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/string.h>
@@ -52,6 +51,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 
+#include <asm/user.h>
 #include <asm/reg.h>
 #include <asm/sections.h>
 #include <asm/prom.h>
Index: mm4-2.6.8.1/arch/ppc/platforms/prep_setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/platforms/prep_setup.c	2004-08-25 09:53:58.822139960 -0700
+++ mm4-2.6.8.1/arch/ppc/platforms/prep_setup.c	2004-08-25 09:54:39.886897168 -0700
@@ -24,7 +24,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/major.h>
@@ -40,6 +39,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 
+#include <asm/user.h>
 #include <asm/sections.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
Index: mm4-2.6.8.1/arch/ppc/platforms/residual.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/platforms/residual.c	2004-08-25 09:53:58.822139960 -0700
+++ mm4-2.6.8.1/arch/ppc/platforms/residual.c	2004-08-25 09:54:39.886897168 -0700
@@ -29,7 +29,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/major.h>
@@ -40,6 +39,7 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
+#include <asm/user.h>
 #include <asm/sections.h>
 #include <asm/mmu.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/arch/ppc/syslib/m8260_setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/syslib/m8260_setup.c	2004-08-25 09:53:58.822139960 -0700
+++ mm4-2.6.8.1/arch/ppc/syslib/m8260_setup.c	2004-08-25 09:54:39.887897016 -0700
@@ -21,7 +21,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/major.h>
@@ -33,6 +32,7 @@
 #include <linux/ide.h>
 #include <linux/seq_file.h>
 
+#include <asm/user.h>
 #include <asm/mmu.h>
 #include <asm/residual.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/arch/ppc/syslib/m8xx_setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/syslib/m8xx_setup.c	2004-08-25 09:53:58.822139960 -0700
+++ mm4-2.6.8.1/arch/ppc/syslib/m8xx_setup.c	2004-08-25 09:54:39.887897016 -0700
@@ -21,7 +21,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/major.h>
@@ -34,6 +33,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 
+#include <asm/user.h>
 #include <asm/mmu.h>
 #include <asm/reg.h>
 #include <asm/residual.h>
Index: mm4-2.6.8.1/arch/ppc64/kernel/chrp_setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc64/kernel/chrp_setup.c	2004-08-25 09:53:58.821140112 -0700
+++ mm4-2.6.8.1/arch/ppc64/kernel/chrp_setup.c	2004-08-25 09:54:39.887897016 -0700
@@ -24,7 +24,6 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/major.h>
@@ -43,6 +42,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 
+#include <asm/user.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/arch/ppc64/kernel/pmac_setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc64/kernel/pmac_setup.c	2004-08-25 09:53:58.821140112 -0700
+++ mm4-2.6.8.1/arch/ppc64/kernel/pmac_setup.c	2004-08-25 09:54:39.887897016 -0700
@@ -33,7 +33,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/string.h>
@@ -52,6 +51,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 
+#include <asm/user.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
 #include <asm/prom.h>
Index: mm4-2.6.8.1/arch/ppc64/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc64/kernel/process.c	2004-08-25 09:53:58.821140112 -0700
+++ mm4-2.6.8.1/arch/ppc64/kernel/process.c	2004-08-25 09:54:39.888896864 -0700
@@ -27,7 +27,6 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/elf.h>
 #include <linux/init.h>
 #include <linux/init_task.h>
@@ -36,6 +35,7 @@
 #include <linux/kallsyms.h>
 #include <linux/version.h>
 
+#include <asm/user.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/ppc64/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc64/kernel/ptrace.c	2004-08-25 09:53:58.821140112 -0700
+++ mm4-2.6.8.1/arch/ppc64/kernel/ptrace.c	2004-08-25 09:54:39.888896864 -0700
@@ -24,10 +24,10 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/ppc64/kernel/ptrace32.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc64/kernel/ptrace32.c	2004-08-25 09:53:58.821140112 -0700
+++ mm4-2.6.8.1/arch/ppc64/kernel/ptrace32.c	2004-08-25 09:54:39.888896864 -0700
@@ -24,9 +24,9 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/ppc64/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc64/kernel/traps.c	2004-08-25 09:53:58.821140112 -0700
+++ mm4-2.6.8.1/arch/ppc64/kernel/traps.c	2004-08-25 09:54:39.888896864 -0700
@@ -24,12 +24,12 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/module.h>
 
+#include <asm/user.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/s390/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/s390/kernel/process.c	2004-08-25 09:53:58.823139808 -0700
+++ mm4-2.6.8.1/arch/s390/kernel/process.c	2004-08-25 09:54:39.889896712 -0700
@@ -29,7 +29,6 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -38,6 +37,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/s390/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/s390/kernel/ptrace.c	2004-08-25 09:53:58.823139808 -0700
+++ mm4-2.6.8.1/arch/s390/kernel/ptrace.c	2004-08-25 09:54:39.889896712 -0700
@@ -29,9 +29,9 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/s390/kernel/setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/s390/kernel/setup.c	2004-08-25 09:53:58.823139808 -0700
+++ mm4-2.6.8.1/arch/s390/kernel/setup.c	2004-08-25 09:54:39.889896712 -0700
@@ -23,7 +23,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
@@ -37,6 +36,7 @@
 #include <linux/seq_file.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/smp.h>
Index: mm4-2.6.8.1/arch/sh/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh/kernel/ptrace.c	2004-08-25 09:53:58.823139808 -0700
+++ mm4-2.6.8.1/arch/sh/kernel/ptrace.c	2004-08-25 09:54:39.890896560 -0700
@@ -18,10 +18,10 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/slab.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/sh/kernel/sh_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh/kernel/sh_ksyms.c	2004-08-25 09:53:58.823139808 -0700
+++ mm4-2.6.8.1/arch/sh/kernel/sh_ksyms.c	2004-08-25 09:54:39.890896560 -0700
@@ -1,7 +1,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/smp.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/sched.h>
 #include <linux/in6.h>
Index: mm4-2.6.8.1/arch/sh64/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh64/kernel/process.c	2004-08-25 09:53:58.823139808 -0700
+++ mm4-2.6.8.1/arch/sh64/kernel/process.c	2004-08-25 09:54:39.890896560 -0700
@@ -44,7 +44,6 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/unistd.h>
@@ -52,6 +51,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/sh64/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh64/kernel/ptrace.c	2004-08-25 09:53:58.824139656 -0700
+++ mm4-2.6.8.1/arch/sh64/kernel/ptrace.c	2004-08-25 09:54:39.890896560 -0700
@@ -26,8 +26,8 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 
+#include <asm/user.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/sh64/kernel/setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh64/kernel/setup.c	2004-08-25 09:53:58.824139656 -0700
+++ mm4-2.6.8.1/arch/sh64/kernel/setup.c	2004-08-25 09:54:39.891896408 -0700
@@ -34,7 +34,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
@@ -48,6 +47,7 @@
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/initrd.h>
+#include <asm/user.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/sh64/kernel/sh_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh64/kernel/sh_ksyms.c	2004-08-25 09:53:58.824139656 -0700
+++ mm4-2.6.8.1/arch/sh64/kernel/sh_ksyms.c	2004-08-25 09:54:39.891896408 -0700
@@ -13,7 +13,6 @@
 #include <linux/rwsem.h>
 #include <linux/module.h>
 #include <linux/smp.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/sched.h>
 #include <linux/in6.h>
Index: mm4-2.6.8.1/arch/sparc/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc/kernel/process.c	2004-08-25 09:53:58.825139504 -0700
+++ mm4-2.6.8.1/arch/sparc/kernel/process.c	2004-08-25 09:54:39.891896408 -0700
@@ -20,7 +20,6 @@
 #include <linux/stddef.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/config.h>
 #include <linux/smp.h>
@@ -30,6 +29,7 @@
 #include <linux/pm.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/auxio.h>
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/arch/sparc/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc/kernel/ptrace.c	2004-08-25 09:53:58.825139504 -0700
+++ mm4-2.6.8.1/arch/sparc/kernel/ptrace.c	2004-08-25 09:54:39.892896256 -0700
@@ -14,11 +14,11 @@
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/arch/sparc/kernel/setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc/kernel/setup.c	2004-08-25 09:53:58.825139504 -0700
+++ mm4-2.6.8.1/arch/sparc/kernel/setup.c	2004-08-25 09:54:39.892896256 -0700
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/initrd.h>
 #include <asm/smp.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/delay.h>
@@ -32,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/root_dev.h>
 
+#include <asm/user.h>
 #include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/arch/sparc64/kernel/binfmt_aout32.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc64/kernel/binfmt_aout32.c	2004-08-25 09:53:58.824139656 -0700
+++ mm4-2.6.8.1/arch/sparc64/kernel/binfmt_aout32.c	2004-08-25 09:54:39.892896256 -0700
@@ -22,12 +22,12 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/slab.h>
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
Index: mm4-2.6.8.1/arch/sparc64/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc64/kernel/process.c	2004-08-23 16:11:15.000000000 -0700
+++ mm4-2.6.8.1/arch/sparc64/kernel/process.c	2004-08-25 09:56:51.115947320 -0700
@@ -24,7 +24,6 @@
 #include <linux/stddef.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/config.h>
 #include <linux/reboot.h>
@@ -32,6 +31,7 @@
 #include <linux/compat.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/sparc64/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc64/kernel/ptrace.c	2004-08-25 09:53:58.824139656 -0700
+++ mm4-2.6.8.1/arch/sparc64/kernel/ptrace.c	2004-08-25 09:54:39.892896256 -0700
@@ -15,11 +15,11 @@
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
 
+#include <asm/user.h>
 #include <asm/asi.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/sparc64/kernel/setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc64/kernel/setup.c	2004-08-25 09:53:58.824139656 -0700
+++ mm4-2.6.8.1/arch/sparc64/kernel/setup.c	2004-08-25 09:54:39.893896104 -0700
@@ -14,7 +14,6 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <asm/smp.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/delay.h>
@@ -33,6 +32,7 @@
 #include <linux/cpu.h>
 #include <linux/initrd.h>
 
+#include <asm/user.h>
 #include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/arch/v850/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/v850/kernel/process.c	2004-08-25 09:53:58.825139504 -0700
+++ mm4-2.6.8.1/arch/v850/kernel/process.c	2004-08-25 09:54:39.893896104 -0700
@@ -22,10 +22,10 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/reboot.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
Index: mm4-2.6.8.1/arch/v850/kernel/v850_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/v850/kernel/v850_ksyms.c	2004-08-25 09:53:58.825139504 -0700
+++ mm4-2.6.8.1/arch/v850/kernel/v850_ksyms.c	2004-08-25 09:54:39.893896104 -0700
@@ -3,7 +3,6 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/in6.h>
 #include <linux/interrupt.h>
Index: mm4-2.6.8.1/arch/x86_64/ia32/ia32_aout.c
===================================================================
--- mm4-2.6.8.1.orig/arch/x86_64/ia32/ia32_aout.c	2004-08-25 09:53:58.826139352 -0700
+++ mm4-2.6.8.1/arch/x86_64/ia32/ia32_aout.c	2004-08-25 09:54:39.893896104 -0700
@@ -20,12 +20,12 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/slab.h>
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
Index: mm4-2.6.8.1/arch/x86_64/ia32/tls32.c
===================================================================
--- mm4-2.6.8.1.orig/arch/x86_64/ia32/tls32.c	2004-08-25 09:53:58.826139352 -0700
+++ mm4-2.6.8.1/arch/x86_64/ia32/tls32.c	2004-08-25 09:54:39.894895952 -0700
@@ -1,8 +1,8 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
-#include <linux/user.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/desc.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/x86_64/kernel/process.c
===================================================================
--- mm4-2.6.8.1.orig/arch/x86_64/kernel/process.c	2004-08-25 09:53:58.825139504 -0700
+++ mm4-2.6.8.1/arch/x86_64/kernel/process.c	2004-08-25 09:54:39.894895952 -0700
@@ -25,7 +25,6 @@
 #include <linux/elfcore.h>
 #include <linux/smp.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/module.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
Index: mm4-2.6.8.1/arch/x86_64/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/x86_64/kernel/ptrace.c	2004-08-25 09:53:58.825139504 -0700
+++ mm4-2.6.8.1/arch/x86_64/kernel/ptrace.c	2004-08-25 09:54:39.894895952 -0700
@@ -14,10 +14,10 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
 
+#include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/x86_64/kernel/setup.c
===================================================================
--- mm4-2.6.8.1.orig/arch/x86_64/kernel/setup.c	2004-08-25 09:53:58.826139352 -0700
+++ mm4-2.6.8.1/arch/x86_64/kernel/setup.c	2004-08-25 09:54:39.895895800 -0700
@@ -21,7 +21,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
@@ -40,6 +39,7 @@
 #include <linux/acpi.h>
 #include <linux/kallsyms.h>
 #include <linux/edd.h>
+#include <asm/user.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/x86_64/kernel/x8664_ksyms.c	2004-08-25 09:53:58.826139352 -0700
+++ mm4-2.6.8.1/arch/x86_64/kernel/x8664_ksyms.c	2004-08-25 09:54:39.895895800 -0700
@@ -1,7 +1,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/smp.h>
-#include <linux/user.h>
 #include <linux/sched.h>
 #include <linux/in6.h>
 #include <linux/interrupt.h>
@@ -15,6 +14,7 @@
 #include <linux/tty.h>
 #include <linux/ioctl32.h>
 
+#include <asm/user.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
Index: mm4-2.6.8.1/drivers/ide/ppc/mpc8xx.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/ide/ppc/mpc8xx.c	2004-08-25 09:53:58.826139352 -0700
+++ mm4-2.6.8.1/drivers/ide/ppc/mpc8xx.c	2004-08-25 09:54:39.895895800 -0700
@@ -20,7 +20,6 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/major.h>
@@ -31,6 +30,7 @@
 #include <linux/ide.h>
 #include <linux/bootmem.h>
 
+#include <asm/user.h>
 #include <asm/mpc8xx.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
Index: mm4-2.6.8.1/fs/binfmt_aout.c
===================================================================
--- mm4-2.6.8.1.orig/fs/binfmt_aout.c	2004-08-25 09:53:58.826139352 -0700
+++ mm4-2.6.8.1/fs/binfmt_aout.c	2004-08-25 09:54:39.895895800 -0700
@@ -19,12 +19,12 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/slab.h>
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/init.h>
 
+#include <asm/user.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
Index: mm4-2.6.8.1/fs/binfmt_flat.c
===================================================================
--- mm4-2.6.8.1.orig/fs/binfmt_flat.c	2004-08-25 09:53:58.827139200 -0700
+++ mm4-2.6.8.1/fs/binfmt_flat.c	2004-08-25 09:54:39.896895648 -0700
@@ -30,13 +30,13 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
-#include <linux/user.h>
 #include <linux/slab.h>
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/init.h>
 #include <linux/flat.h>
 
+#include <asm/user.h>
 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/fs/proc/kcore.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/kcore.c	2004-08-25 09:53:58.827139200 -0700
+++ mm4-2.6.8.1/fs/proc/kcore.c	2004-08-25 09:54:39.896895648 -0700
@@ -12,7 +12,6 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
-#include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
Index: mm4-2.6.8.1/include/linux/elfcore.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/elfcore.h	2004-08-25 09:53:58.827139200 -0700
+++ mm4-2.6.8.1/include/linux/elfcore.h	2004-08-25 09:54:39.896895648 -0700
@@ -4,7 +4,7 @@
 #include <linux/types.h>
 #include <linux/signal.h>
 #include <linux/time.h>
-#include <linux/user.h>
+#include <asm/user.h>
 
 struct elf_siginfo
 {
Index: mm4-2.6.8.1/include/linux/user.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/user.h	2004-08-25 09:53:58.827139200 -0700
+++ mm4-2.6.8.1/include/linux/user.h	2004-08-25 09:54:39.896895648 -0700
@@ -1 +1 @@
-#include <asm/user.h>
+#error do not include this header
