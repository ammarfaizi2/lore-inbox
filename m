Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423241AbWANAhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423241AbWANAhe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423242AbWANAhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:37:34 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:56972 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1423241AbWANAhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:37:34 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] uml: fix symbol for mktime
Message-Id: <E1ExZPt-0002e7-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 14 Jan 2006 01:37:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  LD      .tmp_vmlinux1
/usr/lib/gcc-lib/i486-linux/3.3.4/../../../libc.a(mktime.o): In function `timelocal':
: multiple definition of `mktime'
kernel/built-in.o:kernel/time.c:604: first defined here
/usr/bin/ld: Warning: size of symbol `mktime' changed from 134 in kernel/built-in.o to 44 in /usr/lib/gcc-lib/i486-linux/3.3.4/../../../libc.a(mktime.o)
collect2: ld returned 1 exit status

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/arch/um/Makefile
===================================================================
--- linux.orig/arch/um/Makefile	2006-01-13 22:47:23.000000000 +0100
+++ linux/arch/um/Makefile	2006-01-13 22:49:01.000000000 +0100
@@ -67,7 +67,8 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 # in CFLAGS.  Otherwise, it would cause ld to complain about the two different
 # errnos.
 
-CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
+CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
+	-Dmktime=kernel_mktime
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
 include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
