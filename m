Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWDAExL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWDAExL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 23:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWDAExL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 23:53:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39127 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751496AbWDAExK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 23:53:10 -0500
Date: Fri, 31 Mar 2006 23:53:09 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: cell compile fixes.
Message-ID: <20060401045309.GA22149@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing include for __NR_syscalls, and missing sys_splice() that
causes build-time failure due to compile-time bounds check on spu_syscall_table.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/arch/powerpc/platforms/cell/spufs/run.c~	2006-03-30 15:48:17.000000000 -0500
+++ linux-2.6.16.noarch/arch/powerpc/platforms/cell/spufs/run.c	2006-03-30 15:48:25.000000000 -0500
@@ -2,6 +2,7 @@
 #include <linux/ptrace.h>
 
 #include <asm/spu.h>
+#include <asm/unistd.h>
 
 #include "spufs.h"
 
--- linux-2.6.16.noarch/arch/powerpc/platforms/cell/spu_callbacks.c~	2006-03-31 21:53:04.000000000 -0500
+++ linux-2.6.16.noarch/arch/powerpc/platforms/cell/spu_callbacks.c	2006-03-31 21:53:43.000000000 -0500
@@ -316,6 +316,7 @@ void *spu_syscall_table[] = {
 	[__NR_pselect6]			sys_ni_syscall, /* sys_pselect */
 	[__NR_ppoll]			sys_ni_syscall, /* sys_ppoll */
 	[__NR_unshare]			sys_unshare,
+	[__NR_splice]			sys_splice,
 };
 
 long spu_sys_callback(struct spu_syscall_block *s)
