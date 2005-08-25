Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVHYLyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVHYLyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 07:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVHYLyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 07:54:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:55481 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964947AbVHYLyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 07:54:35 -0400
Date: Thu, 25 Aug 2005 15:58:51 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: [PATCH] Kdump: Documentation Update
Message-ID: <20050825102851.GA4437@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o There are minor changes in command line options in kexec-tools for kdump.
  This patch updates the documentation to reflect those changes.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.13-rc7-root/Documentation/kdump/kdump.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -puN Documentation/kdump/kdump.txt~kdump-documentation-update Documentation/kdump/kdump.txt
--- linux-2.6.13-rc7/Documentation/kdump/kdump.txt~kdump-documentation-update	2005-08-25 15:29:03.000000000 +0530
+++ linux-2.6.13-rc7-root/Documentation/kdump/kdump.txt	2005-08-25 15:50:34.000000000 +0530
@@ -39,8 +39,7 @@ SETUP
    and apply http://lse.sourceforge.net/kdump/patches/kexec-tools-1.101-kdump.patch
    and after that build the source.
 
-2) Download and build the appropriate (latest) kexec/kdump (-mm) kernel
-   patchset and apply it to the vanilla kernel tree.
+2) Download and build the appropriate (2.6.13-rc1 onwards) vanilla kernel.
 
    Two kernels need to be built in order to get this feature working.
 
@@ -84,15 +83,16 @@ SETUP
 
 4) Load the second kernel to be booted using:
 
-   kexec -p <second-kernel> --crash-dump --args-linux --append="root=<root-dev>
-   init 1 irqpoll"
+   kexec -p <second-kernel> --args-linux --elf32-core-headers
+   --append="root=<root-dev> init 1 irqpoll"
 
    Note: i) <second-kernel> has to be a vmlinux image. bzImage will not work,
 	    as of now.
-	ii) By default ELF headers are stored in ELF32 format (for i386). This
-	    is sufficient to represent the physical memory up to 4GB. To store
-	    headers in ELF64 format, specifiy "--elf64-core-headers" on the
-	    kexec command line additionally.
+	ii) By default ELF headers are stored in ELF64 format. Option
+	    --elf32-core-headers forces generation of ELF32 headers. gdb can
+	    not open ELF64 headers on 32 bit systems. So creating ELF32
+	    headers can come handy for users who have got non-PAE systems and
+	    hence have memory less than 4GB.
        iii) Specify "irqpoll" as command line parameter. This reduces driver
             initialization failures in second kernel due to shared interrupts.
 
_
