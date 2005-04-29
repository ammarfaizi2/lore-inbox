Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVD2DJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVD2DJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 23:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVD2DJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 23:09:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:36253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262366AbVD2DJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 23:09:17 -0400
Date: Thu, 28 Apr 2005 20:08:45 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, sharyathi@in.ibm.com,
       fastboot@lists.osdl.org, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Kdump docs.
Message-Id: <20050428200845.5211ec37.rddunlap@osdl.org>
In-Reply-To: <20050428091119.73568208.rddunlap@osdl.org>
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
	<OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
	<20050425160925.3a48adc5.rddunlap@osdl.org>
	<20050426085448.GB4234@in.ibm.com>
	<20050427122312.358f5bd6.rddunlap@osdl.org>
	<20050428114416.GA5706@in.ibm.com>
	<20050428091119.73568208.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 09:11:19 -0700 Randy.Dunlap wrote:

| Wheeeeeeeeee.  Great, we (I) can do without cachefs,
| and when I do that, kexec + kdump works.
| First time that I've seen kdump work.  :)


Vivek, Hari, Andrew-

Here's a patch to make Documentation/kdump.txt cleaner & clearer.

---

From: Randy Dunlap <rddunlap@osdl.org>

Cleanups and clear-ups for kdump doc:
  typos, punctuation, 80 columns, examples.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
---

 Documentation/kdump.txt |   89 ++++++++++++++++++++++++++++--------------------
 1 files changed, 52 insertions(+), 37 deletions(-)

diff -Naurp ./Documentation/kdump.txt~kdump_docco ./Documentation/kdump.txt
--- ./Documentation/kdump.txt~kdump_docco	2005-04-22 10:01:39.000000000 -0700
+++ ./Documentation/kdump.txt	2005-04-28 19:55:03.000000000 -0700
@@ -1,4 +1,4 @@
-Documentation for kdump - the kexec based crash dumping solution
+Documentation for kdump - the kexec-based crash dumping solution
 ================================================================
 
 DESIGN
@@ -11,10 +11,10 @@ DMA from the first kernel does not corru
 
 All the necessary information about Core image is encoded in ELF format and
 stored in reserved area of memory before crash. Physical address of start of
-elf header is passed to new kernel through command line parameter elfcorehdr=.
+ELF header is passed to new kernel through command line parameter elfcorehdr=.
 
-On i386, first 640k of physical memory is needed to boot, irrespctive of where
-the kernel loads at. Hence, this region is backed up by kexec just before
+On i386, the first 640 KB of physical memory is needed to boot, irrespective
+of where the kernel loads. Hence, this region is backed up by kexec just before
 rebooting into the new kernel.
 
 In the second kernel, "old memory" can be accessed in two ways.
@@ -22,59 +22,72 @@ In the second kernel, "old memory" can b
 - The first one is through a /dev/oldmem device interface. A capture utility
   can read the device file and write out the memory in raw format. This is raw
   dump of memory and analysis/capture tool should be intelligent enough to
-  determine where to look for the right information. Elf headers (elfcorehdr=)
+  determine where to look for the right information. ELF headers (elfcorehdr=)
   can become handy here.
 
 - The second interface is through /proc/vmcore. This exports the dump as an ELF
   format file which can be written out using any file copy command
   (cp, scp, etc). Further, gdb can be used to perform limited debugging on
   the dump file. This method ensures methods ensure that there is correct
-  ordering of the dump pages (corresponding to the first 640k that has been
+  ordering of the dump pages (corresponding to the first 640 KB that has been
   relocated).
 
 SETUP
 =====
 
-1) Obtain the appropriate -mm tree patch and apply it on to the vanilla
-   kernel tree.
+1) Download and build the appropriate version of kexec-tools.
 
-2) Obtain appropriate version of kexec-tools.
+2) Download and build the appropriate (latest) kexec/kdump (-mm) kernel
+   patchset and apply it to the vanilla kernel tree.
 
-3) Two kernels need to be built in order to get this feature working.
+   Two kernels need to be built in order to get this feature working.
 
-   First kernel:
-   a) Enable "kexec system call" feature.
-   b) Enable "sysfs file system support" (Pseudo filesystems).
-   c) Boot into first kernel with command line "crashkernel=Y@X".  Put
-      appropriate values for X and Y. Y denotes, how much memory to reserve for
-      second kernel, and X denotes at what physical address reserved memory
-      section starts. For example, crashkernel=48M@16M.
-
-   Second kernel:
-   a) Enable "kernel crash dumps" feature.
-   b) Specifiy a suitable value for "Physical address where the kernel is
-      loaded". Typically this value should be same as X (See option c) above).
-   c) Enable "/proc/vmcore support" (Optional).
-
-      Note: Option a) and b) depend upon "Configure standard kernel feature
-            (for small systems)".
-	    Option a) also depends on CONFIG_HIGHMEM.
-	    Both option a) and b) are under "Processor Types and Features"
+  A) First kernel:
+   a) Enable "kexec system call" feature (in Processor type and features).
+	CONFIG_KEXEC=y
+   b) This kernel's physical load address should be the default value of
+      0x100000 (0x100000, 1 MB) (in Processor type and features).
+	CONFIG_PHYSICAL_START=0x100000
+   c) Enable "sysfs file system support" (in Pseudo filesystems).
+	CONFIG_SYSFS=y
+   d) Boot into first kernel with the command line parameter "crashkernel=Y@X".
+      Use appropriate values for X and Y. Y denotes how much memory to reserve
+      for the second kernel, and X denotes at what physical address the reserved
+      memory section starts. For example: "crashkernel=64M@16M".
+
+  B) Second kernel:
+   a) Enable "kernel crash dumps" feature (in Processor type and features).
+	CONFIG_CRASH_DUMP=y
+   b) Specify a suitable value for "Physical address where the kernel is
+      loaded" (in Processor type and features). Typically this value
+      should be same as X (See option b) above, e.g., 16 MB or 0x1000000.
+	CONFIG_PHYSICAL_START=0x1000000
+   c) Enable "/proc/vmcore support" (Optional, in Pseudo filesystems).
+	CONFIG_PROC_VMCORE=y
+
+  Note: Options a) and b) depend upon "Configure standard kernel features
+	(for small systems)" (under General setup).
+	Option a) also depends on CONFIG_HIGHMEM (under Processor
+		type and features).
+	Both option a) and b) are under "Processor type and features".
 
-3) Boot into the first kernel. You are now ready to try out kexec based crash
+3) Boot into the first kernel. You are now ready to try out kexec-based crash
    dumps.
 
-4) Load the second kernel to be booted using
+4) Load the second kernel to be booted using:
 
    kexec -p <second-kernel> --crash-dump --args-linux --append="root=<root-dev>
    maxcpus=1 init 1"
 
    Note: i) <second-kernel> has to be a vmlinux image. bzImage will not work,
 	    as of now.
-	ii) By default elf headers are stored in ELF32 format(for i386). This is
-	    sufficient to represent the physical memory up to 4GB. To store
-	    headers in ELF64 format, specifiy "--elf64-core-headers" on kexec
-	    command line additionally.
+	ii) By default ELF headers are stored in ELF32 format (for i386). This
+	    is sufficient to represent the physical memory up to 4GB. To store
+	    headers in ELF64 format, specifiy "--elf64-core-headers" on the
+	    kexec command line additionally.
+       iii) For now (or until it is fixed), it's best to build the
+	    second-kernel without multi-processor support, i.e., make it
+	    a uniprocessor kernel.
 
 5) System reboots into the second kernel when a panic occurs. A module can be
    written to force the panic, for testing purposes.
@@ -83,14 +96,16 @@ SETUP
 
    cp /proc/vmcore <dump-file>
 
-   Dump can also be accessed as a /dev/oldmem device for a linear/raw view.
-   To create the device, type
+   Dump memory can also be accessed as a /dev/oldmem device for a linear/raw
+   view.  To create the device, type:
 
    mknod /dev/oldmem c 1 12
 
    Use "dd" with suitable options for count, bs and skip to access specific
    portions of the dump.
 
+   Entire memory:  dd if=/dev/oldmem of=oldmem.001
+
 ANALYSIS
 ========
 
@@ -102,7 +117,7 @@ Limited analysis can be done using gdb o
 Stack trace for the task on processor 0, register display, memory display
 work fine.
 
-Note: gdb can not analyse core files generated in ELF64 format for i386.
+Note: gdb cannot analyse core files generated in ELF64 format for i386.
 
 TODO
 ====

