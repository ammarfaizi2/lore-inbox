Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUKSJ06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUKSJ06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUKSJ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:26:57 -0500
Received: from ozlabs.org ([203.10.76.45]:39127 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261330AbUKSJ0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:26:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16797.47236.732462.744153@cargo.ozlabs.ibm.com>
Date: Fri, 19 Nov 2004 20:10:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Fix compilation with recent toolchains
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent ppc64 toolchains don't create dot symbols (i.e. a globally
visible ".foo" symbol for the text of function foo) any more.  This
breaks the kernel compile because we refer to function text addresses
in the system call table.  Fortunately there is an option,
-mcall-aixdesc, which restores the previous behaviour, and even more
fortunately, old ppc64 toolchains understand the option as well as new
ones.  This patch adds -mcall-aixdesc to CFLAGS in
arch/ppc64/Makefile.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/Makefile test/arch/ppc64/Makefile
--- linux-2.5/arch/ppc64/Makefile	2004-10-27 07:32:57.000000000 +1000
+++ test/arch/ppc64/Makefile	2004-11-19 16:13:41.744205744 +1100
@@ -32,7 +32,8 @@
 
 LDFLAGS		:= -m elf64ppc
 LDFLAGS_vmlinux	:= -Bstatic -e $(KERNELLOAD) -Ttext $(KERNELLOAD)
-CFLAGS		+= -msoft-float -pipe -mminimal-toc -mtraceback=none
+CFLAGS		+= -msoft-float -pipe -mminimal-toc -mtraceback=none \
+		   -mcall-aixdesc
 
 ifeq ($(CONFIG_POWER4_ONLY),y)
 	CFLAGS += $(call cc-option,-mcpu=power4)
