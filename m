Return-Path: <linux-kernel-owner+w=401wt.eu-S1161038AbXALJCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbXALJCz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbXALJCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:02:55 -0500
Received: from koto.vergenet.net ([210.128.90.7]:54148 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161038AbXALJCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:02:53 -0500
Date: Fri, 12 Jan 2007 18:00:44 +0900
From: Horms <horms@verge.net.au>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Mohan Kumar M <mohan@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Kdump documentation update for 2.6.20: ia64 portion
Message-ID: <20070112090043.GA27340@verge.net.au>
References: <20070112060724.GC17379@verge.net.au> <10EA09EFD8728347A513008B6B0DA77A086BAA@pdsmsx411.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A086BAA@pdsmsx411.ccr.corp.intel.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fills in the portions for ia64 kexec.

I'm actually not sure what options are required for the dump-capture
kernel, but "init 1 irqpoll maxcpus=1" has been working fine for me.
Or more to the point, I'm not sure if irqpoll is needed or not.

This patch requires the documentation patch update that Vivek Goyal has
been circulating, and I believe is currently in mm. Feel free to fold it
into that change if it makes things easier for anyone.

Take II

Nanhai,

I have noted that vmlinux.gz may also be used. And added a note about the
kernel being able to automatically place the crashkernel region.
Furthermore, I added a note that if manually specified, the region should
be 64Mb aligned to avoid wastage. I notice that the auto placement code
uses 64Mb. But is this strictly neccessary for all page sizes?

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/Documentation/kdump/kdump.txt
===================================================================
--- linux-2.6.orig/Documentation/kdump/kdump.txt	2007-01-12 17:45:19.000000000 +0900
+++ linux-2.6/Documentation/kdump/kdump.txt	2007-01-12 17:59:42.000000000 +0900
@@ -17,7 +17,7 @@
 memory image to a dump file on the local disk, or across the network to
 a remote system.
 
-Kdump and kexec are currently supported on the x86, x86_64, ppc64 and IA64
+Kdump and kexec are currently supported on the x86, x86_64, ppc64 and ia64
 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
@@ -229,7 +229,23 @@
 
 Dump-capture kernel config options (Arch Dependent, ia64)
 ----------------------------------------------------------
-(To be filled)
+
+- No specific options are required to create a dump-capture kernel
+  for ia64, other than those specified in the arch idependent section
+  above. This means that it is possible to use the system kernel
+  as a dump-capture kernel if desired.
+  
+  The crashkernel region can be automatically placed by the system
+  kernel at run time. This is done by specifying the base address as 0,
+  or omitting it all together.
+
+  crashkernel=256M@0
+  or
+  crashkernel=256M
+
+  If the start address is specified, not that the start address of the
+  kernel will be alligned to 64Mb, so any if the start address is not then
+  any space below the alignment point will be wasted.
 
 
 Boot into System Kernel
@@ -248,6 +264,10 @@
 
    On ppc64, use "crashkernel=128M@32M".
 
+   On ia64, 256M@256M is a generous value that typically works.
+   The region may be automatically placed on ia64, see the
+   dump-capture kernel config option notes above.
+
 Load the Dump-capture Kernel
 ============================
 
@@ -266,7 +286,8 @@
 For ppc64:
 	- Use vmlinux
 For ia64:
-	(To be filled)
+	- Use vmlinux or vmlinuz.gz
+
 
 If you are using a uncompressed vmlinux image then use following command
 to load dump-capture kernel.
@@ -282,18 +303,19 @@
    --initrd=<initrd-for-dump-capture-kernel> \
    --append="root=<root-dev> <arch-specific-options>"
 
+Please note, that --args-linux does not need to be specified for ia64.
+It is planned to make this a no-op on that architecture, but for now
+it should be omitted
+
 Following are the arch specific command line options to be used while
 loading dump-capture kernel.
 
-For i386 and x86_64:
+For i386, x86_64 and ia64:
 	"init 1 irqpoll maxcpus=1"
 
 For ppc64:
 	"init 1 maxcpus=1 noirqdistrib"
 
-For IA64
-	(To be filled)
-
 
 Notes on loading the dump-capture kernel:
 
