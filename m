Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWIALQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWIALQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWIALQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:16:39 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:192 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751479AbWIALQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:16:38 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Make 2.6.18-rc5-mm1 compile
Date: Fri, 1 Sep 2006 12:57:01 +0200
User-Agent: KMail/1.9.4
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609011257.03909.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/i386/kernel/sys_i386.o
arch/i386/kernel/sys_i386.c: In function 'kernel_execve':
arch/i386/kernel/sys_i386.c:262: error: '__NR_execve' undeclared (first use in 
this function)
arch/i386/kernel/sys_i386.c:262: error: (Each undeclared identifier is 
reported only once
arch/i386/kernel/sys_i386.c:262: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/sys_i386.o] Error 1
make: *** [arch/i386/kernel] Error 2

It's just a missing #include for the __NR_execve define -- fix below.

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>
--- linux-2.6.17/arch/i386/kernel/sys_i386.c.ark	2006-09-01 12:43:34.000000000 
+0200
+++ linux-2.6.17/arch/i386/kernel/sys_i386.c	2006-09-01 12:43:46.000000000 
+0200
@@ -21,6 +21,7 @@
 #include <linux/utsname.h>
 
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 #include <asm/ipc.h>
 
 /*
