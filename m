Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVFUJcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVFUJcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVFUJ3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:29:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:37553 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261507AbVFUJ0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:26:22 -0400
Date: Tue, 21 Jun 2005 14:56:13 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: [PATCH] kdump documentation update to introduce use of irqpoll
Message-ID: <20050621092613.GF3746@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following is a patch to update kdump documentation.

Thanks
Vivek

o Specify "irqpoll" command line option which loading second kernel. This
  helps in reducing driver initialization failures in second kernel due
  to shared interrupts.
o Enabled LAPIC/IOAPIC support for UP kernels in second kernel. This reduces
  the chances of devices sharing the irq and hence reduces the chances of
  driver initialization failures in second kernel.
o Build a UP capture kernel and disabled SMP support.  


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-mm1-vivek/Documentation/kdump/kdump.txt |   28 +++++++++++--------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff -puN Documentation/kdump/kdump.txt~kdump-documentation-update Documentation/kdump/kdump.txt
--- linux-2.6.12-mm1/Documentation/kdump/kdump.txt~kdump-documentation-update	2005-06-21 14:48:00.917613512 +0530
+++ linux-2.6.12-mm1-vivek/Documentation/kdump/kdump.txt	2005-06-21 14:48:00.924612448 +0530
@@ -66,12 +66,18 @@ SETUP
 	CONFIG_PHYSICAL_START=0x1000000
    c) Enable "/proc/vmcore support" (Optional, in Pseudo filesystems).
 	CONFIG_PROC_VMCORE=y
-
-  Note: Options a) and b) depend upon "Configure standard kernel features
-	(for small systems)" (under General setup).
-	Option a) also depends on CONFIG_HIGHMEM (under Processor
+   d) Disable SMP support and build a UP kernel (Until it is fixed).
+   	CONFIG_SMP=n
+   e) Enable "Local APIC support on uniprocessors".
+   	CONFIG_X86_UP_APIC=y
+   f) Enable "IO-APIC support on uniprocessors"
+   	CONFIG_X86_UP_IOAPIC=y
+
+  Note:   i) Options a) and b) depend upon "Configure standard kernel features
+	     (for small systems)" (under General setup).
+	 ii) Option a) also depends on CONFIG_HIGHMEM (under Processor
 		type and features).
-	Both option a) and b) are under "Processor type and features".
+	iii) Both option a) and b) are under "Processor type and features".
 
 3) Boot into the first kernel. You are now ready to try out kexec-based crash
    dumps.
@@ -79,7 +85,7 @@ SETUP
 4) Load the second kernel to be booted using:
 
    kexec -p <second-kernel> --crash-dump --args-linux --append="root=<root-dev>
-   maxcpus=1 init 1"
+   init 1 irqpoll"
 
    Note: i) <second-kernel> has to be a vmlinux image. bzImage will not work,
 	    as of now.
@@ -87,12 +93,12 @@ SETUP
 	    is sufficient to represent the physical memory up to 4GB. To store
 	    headers in ELF64 format, specifiy "--elf64-core-headers" on the
 	    kexec command line additionally.
-       iii) For now (or until it is fixed), it's best to build the
-	    second-kernel without multi-processor support, i.e., make it
-	    a uniprocessor kernel.
+       iii) Specify "irqpoll" as command line parameter. This reduces driver
+            initialization failures in second kernel due to shared interrupts.
 
 5) System reboots into the second kernel when a panic occurs. A module can be
-   written to force the panic, for testing purposes.
+   written to force the panic or "ALT-SysRq-c" can be used initiate a crash
+   dump for testing purposes.
 
 6) Write out the dump file using
 
@@ -131,5 +137,5 @@ TODO
 CONTACT
 =======
 
-Hariprasad Nellitheertha - hari at in dot ibm dot com
 Vivek Goyal (vgoyal@in.ibm.com)
+Maneesh Soni (maneesh@in.ibm.com)
_
