Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUFCLcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUFCLcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 07:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUFCLcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 07:32:32 -0400
Received: from ozlabs.org ([203.10.76.45]:23958 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262605AbUFCLca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 07:32:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16575.3256.232409.78417@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jun 2004 21:34:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Use -fPIC instead of -mrelocatable-lib
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ppc32 boot code has a couple of files that are executed very early
on before the kernel is mapped at the address it is linked at.  We
have been using -mrelocatable-lib to compile these files, but
apparently -mrelocatable-lib is deprecated and the gcc developers are
threatening to remove it.  In fact the -fPIC flag does what we need.
This patch changes -mrelocatable-lib to -fPIC.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/syslib/Makefile pmac-2.5/arch/ppc/syslib/Makefile
--- linux-2.5/arch/ppc/syslib/Makefile	2004-05-15 13:32:15.000000000 +1000
+++ pmac-2.5/arch/ppc/syslib/Makefile	2004-05-15 15:05:42.000000000 +1000
@@ -9,8 +9,8 @@
 EXTRA_AFLAGS		:= -Wa,-m405
 endif
 
-CFLAGS_prom_init.o      += -mrelocatable-lib
-CFLAGS_btext.o          += -mrelocatable-lib
+CFLAGS_prom_init.o      += -fPIC
+CFLAGS_btext.o          += -fPIC
 
 obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram.o
 obj-$(CONFIG_PPC_OCP)		+= ocp.o

