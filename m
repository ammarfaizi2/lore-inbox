Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVASH5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVASH5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVASH50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:57:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52927 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261631AbVASHd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:27 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 25/29] crashdump-documentation
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <crashdump-documentation-11061198972662@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-crash-shutdown-apic-shutdown-11061198971134@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
	<x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
	<kexec-ppc-support-11061198973302@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-nmi-shootdown-11061198973234@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-snapshot-registers-11061198972173@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-apic-shutdown-11061198971134@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have addressed the worst of the documentation changes
that come about from the current refacatoring.

From: Hariprasad Nellitheertha <hari@in.ibm.com>

This patch contains the documentation for the kexec based crash dump tool.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 00-INDEX  |    2 +
 kdump.txt |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-apic-shutdown/Documentation/00-INDEX linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/Documentation/00-INDEX
--- linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-apic-shutdown/Documentation/00-INDEX	Fri Jan 14 04:28:28 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/Documentation/00-INDEX	Tue Jan 18 23:16:08 2005
@@ -140,6 +140,8 @@
 	- info on the in-kernel binary support for Java(tm).
 kbuild/
 	- directory with info about the kernel build process.
+kdumpt.txt
+	- mini HowTo on getting the crash dump code to work.
 kernel-doc-nano-HOWTO.txt
 	- mini HowTo on generation and location of kernel documentation files.
 kernel-docs.txt
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-apic-shutdown/Documentation/kdump.txt linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/Documentation/kdump.txt
--- linux-2.6.11-rc1-mm1-nokexec-x86-crash_shutdown-apic-shutdown/Documentation/kdump.txt	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/Documentation/kdump.txt	Tue Jan 18 23:16:08 2005
@@ -0,0 +1,98 @@
+Documentation for kdump - the kexec based crash dumping solution
+================================================================
+
+DESIGN
+======
+
+We use kexec to reboot to a second kernel whenever a dump needs to be taken.
+This second kernel is booted with with very little memory (configurable
+at compile time). The first kernel reserves the section of memory that the
+second kernel uses. This ensures that on-going DMA from the first kernel
+does not corrupt the second kernel. The first 640k of physical memory is
+needed irrespective of where the kernel loads at. Hence, this region is
+backed up before reboot.
+
+In the second kernel, "old memory" can be accessed in two ways. The
+first one is through a device interface. We can create a /dev/oldmem or
+whatever and write out the memory in raw format. The second interface is
+through /proc/vmcore. This exports the dump as an ELF format file which
+can be written out using any file copy command (cp, scp, etc). Further, gdb
+can be used to perform some minimal debugging on the dump file. Both these
+methods ensure that there is correct ordering of the dump pages (corresponding
+to the first 640k that has been relocated).
+
+SETUP
+=====
+
+1) Obtain the appropriate -mm tree patch and apply it on to the vanilla
+   kernel tree.
+
+2) Two kernels need to be built in order to get this feature working.
+
+   For the first kernel, choose the default values for the following options.
+
+   a) Physical address where the kernel is loaded
+   b) kexec system call
+   c) kernel crash dumps
+
+   All the options are under "Processor type and features"
+
+   For the second kernel, change (a) to 16MB. If you want to choose another
+   value here, ensure "location from where the crash dumping kernel will boot
+   (MB)" under (c) reflects the same value.
+
+   Also ensure you have CONFIG_HIGHMEM on.
+
+3) Boot into the first kernel. You are now ready to try out kexec based crash
+   dumps.
+
+4) Load the second kernel to be booted using
+
+   kexec -p <second-kernel> --args-linux --append="root=<root-dev> dump
+   init 1 memmap=exactmap memmap=640k@0 memmap=32M@16M"
+
+   Note that <second-kernel> has to be a vmlinux image. bzImage will not
+   work, as of now.
+
+5) System reboots into the second kernel when a panic occurs.
+   You could write a module to call panic, for testing purposes.
+
+6) Write out the dump file using
+
+   cp /proc/vmcore <dump-file>
+
+You can also access the dump as a device for a linear/raw view. To do this,
+you will need the kd-oldmem-<version>.patch built into the kernel. To create
+the device, type
+
+  mknod /dev/oldmem c 1 12
+
+Use "dd" with suitable options for count, bs and skip to access specific
+portions of the dump.
+
+ANALYSIS
+========
+
+You can run gdb on the dump file copied out of /proc/vmcore. Use vmlinux built
+with -g and run
+
+  gdb vmlinux <dump-file>
+
+Stack trace for the task on processor 0, register display, memory display
+work fine.
+
+TODO
+====
+
+1) Provide a kernel-pages only view for the dump. This could possibly turn up
+   as /proc/vmcore-kern.
+2) Provide register contents of all processors (similar to what multi-threaded
+   core dumps does).
+3) Modify "crash" to make it recognize this dump.
+4) Make the i386 kernel boot from any location so we can run the second kernel
+   from the reserved location instead of the current approach.
+
+CONTACT
+=======
+
+Hariprasad Nellitheertha - hari at in dot ibm dot com
