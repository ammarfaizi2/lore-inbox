Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbUDNILQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263959AbUDNILQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:11:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1668 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263949AbUDNIKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:10:54 -0400
Message-ID: <407CF201.408@pobox.com>
Date: Wed, 14 Apr 2004 04:10:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
References: <407CEB91.1080503@pobox.com>	<20040414005832.083de325.akpm@osdl.org> <20040414010240.0e9f4115.akpm@osdl.org>
In-Reply-To: <20040414010240.0e9f4115.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080706060301030005000808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080706060301030005000808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
>> buffer_error() was always supposed to be temporary.  Once per month someone
>> reports the one in __find_get_block_slow(), but that's all.  The only
>> reason for keeping it around is as a debug aid to filesystem developers.
>>
>> We could make it a no-op if !CONFIG_BUFFER_DEBUG.
> 
> 
> But even if we do that, the compiler cannot optimise away things like:
> 
> 	if (atomic_read(&bh->b_count) == 0 &&
> 			!PageLocked(bh->b_page) &&
> 			!PageWriteback(bh->b_page))
> 		do {} while (0);

Nod.


> so if it offends you, go kill the thing outright.

If you like config variables, here's a second patch (untested but should 
be obvious).  As a side note, we need a Kconfig for generic debugging 
options...

I would rather not kill the code in submit_bh() outright, just disable 
it for non-filesystem developers.

For me, buffer_error() definition is secondary to disabling these 
checks-that-noone-hits in the submit_bh() fast path.

	Jeff



--------------080706060301030005000808
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== arch/alpha/Kconfig 1.36 vs edited =====
--- 1.36/arch/alpha/Kconfig	Sat Mar 20 13:29:54 2004
+++ edited/arch/alpha/Kconfig	Wed Apr 14 04:03:41 2004
@@ -690,6 +690,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/arm/Kconfig 1.53 vs edited =====
--- 1.53/arch/arm/Kconfig	Thu Apr  8 15:41:09 2004
+++ edited/arch/arm/Kconfig	Wed Apr 14 04:03:58 2004
@@ -724,6 +724,13 @@
 	  you are concerned with the code size or don't want to see these
 	  messages.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 # These options are only for real kernel hackers who want to get their hands dirty. 
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
===== arch/arm26/Kconfig 1.11 vs edited =====
--- 1.11/arch/arm26/Kconfig	Mon Mar  1 10:52:18 2004
+++ edited/arch/arm26/Kconfig	Wed Apr 14 04:03:47 2004
@@ -316,6 +316,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 # These options are only for real kernel hackers who want to get their hands dirty. 
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
===== arch/i386/Kconfig 1.116 vs edited =====
--- 1.116/arch/i386/Kconfig	Mon Apr 12 13:54:45 2004
+++ edited/arch/i386/Kconfig	Wed Apr 14 04:04:34 2004
@@ -1286,6 +1286,13 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	help
===== arch/ia64/Kconfig 1.69 vs edited =====
--- 1.69/arch/ia64/Kconfig	Mon Apr 12 21:50:46 2004
+++ edited/arch/ia64/Kconfig	Wed Apr 14 04:04:46 2004
@@ -503,6 +503,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config SYSVIPC_COMPAT
 	bool
 	depends on COMPAT && SYSVIPC
===== arch/m68k/Kconfig 1.31 vs edited =====
--- 1.31/arch/m68k/Kconfig	Thu Feb 26 06:25:58 2004
+++ edited/arch/m68k/Kconfig	Wed Apr 14 04:04:50 2004
@@ -688,6 +688,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/mips/Kconfig 1.24 vs edited =====
--- 1.24/arch/mips/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/mips/Kconfig	Wed Apr 14 04:05:05 2004
@@ -1253,6 +1253,13 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
===== arch/parisc/Kconfig 1.28 vs edited =====
--- 1.28/arch/parisc/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/parisc/Kconfig	Wed Apr 14 04:05:10 2004
@@ -222,6 +222,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/ppc/Kconfig 1.57 vs edited =====
--- 1.57/arch/ppc/Kconfig	Tue Mar 30 10:39:41 2004
+++ edited/arch/ppc/Kconfig	Wed Apr 14 04:05:26 2004
@@ -1209,6 +1209,13 @@
 	  debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
 	depends PPC_OF
===== arch/ppc64/Kconfig 1.52 vs edited =====
--- 1.52/arch/ppc64/Kconfig	Mon Apr 12 13:54:05 2004
+++ edited/arch/ppc64/Kconfig	Wed Apr 14 04:05:16 2004
@@ -395,6 +395,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/s390/Kconfig 1.25 vs edited =====
--- 1.25/arch/s390/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/s390/Kconfig	Wed Apr 14 04:05:32 2004
@@ -397,6 +397,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
 	help
===== arch/sparc/Kconfig 1.28 vs edited =====
--- 1.28/arch/sparc/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/sparc/Kconfig	Wed Apr 14 04:06:04 2004
@@ -448,6 +448,13 @@
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 endmenu
 
 source "security/Kconfig"
===== arch/sparc64/Kconfig 1.50 vs edited =====
--- 1.50/arch/sparc64/Kconfig	Fri Mar 19 01:04:54 2004
+++ edited/arch/sparc64/Kconfig	Wed Apr 14 04:05:51 2004
@@ -679,6 +679,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config STACK_DEBUG
 	depends on DEBUG_KERNEL
 	bool "Stack Overflow Detection Support"
===== arch/um/Kconfig 1.14 vs edited =====
--- 1.14/arch/um/Kconfig	Mon Apr 12 13:53:57 2004
+++ edited/arch/um/Kconfig	Wed Apr 14 04:06:09 2004
@@ -233,6 +233,13 @@
         If you're truly short on disk space or don't expect to report any
         bugs back to the UML developers, say N, otherwise say Y.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config FRAME_POINTER
 	bool
 	default y if DEBUG_INFO
===== arch/v850/Kconfig 1.21 vs edited =====
--- 1.21/arch/v850/Kconfig	Mon Feb 16 19:42:32 2004
+++ edited/arch/v850/Kconfig	Wed Apr 14 04:06:12 2004
@@ -320,6 +320,13 @@
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL
===== arch/x86_64/Kconfig 1.47 vs edited =====
--- 1.47/arch/x86_64/Kconfig	Mon Apr 12 13:53:56 2004
+++ edited/arch/x86_64/Kconfig	Wed Apr 14 04:06:16 2004
@@ -471,6 +471,13 @@
 	  Please note that this option requires new binutils.
 	  If you don't debug the kernel, you can say N.
 	  
+config DEBUG_BUFFERS
+	bool "Enable additional filesystem buffer_head checks"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, additional checks are performed that aid
+	  filesystem development.
+
 config FRAME_POINTER
        bool "Compile the kernel with frame pointers"
        help
===== fs/buffer.c 1.237 vs edited =====
--- 1.237/fs/buffer.c	Wed Apr 14 03:18:09 2004
+++ edited/fs/buffer.c	Wed Apr 14 04:06:40 2004
@@ -2688,6 +2688,7 @@
 {
 	struct bio *bio;
 
+#ifdef CONFIG_DEBUG_BUFFERS
 	BUG_ON(!buffer_locked(bh));
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
@@ -2698,6 +2699,7 @@
 		buffer_error();
 	if (rw == READ && buffer_dirty(bh))
 		buffer_error();
+#endif
 
 	/* Only clear out a write error when rewriting */
 	if (test_set_buffer_req(bh) && rw == WRITE)

--------------080706060301030005000808--

