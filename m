Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVCAVuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVCAVuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVCAVuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:50:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:52702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262044AbVCAVto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:49:44 -0500
Date: Tue, 1 Mar 2005 13:49:16 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, ralf@linux-mips.org,
       schwidefsky@de.ibm.com
Subject: Re: 2.6.11-rc5-mm1
Message-ID: <20050301214916.GJ28536@shell0.pdx.osdl.net>
References: <20050301012741.1d791cd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301012741.1d791cd2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> - I seem to be getting a lot of patches which don't compile if you breathe
>   on the .config file, let alone if you try them on another architecture.  It
>   would be nice to receive less such patches, please.

The ia64 audit bit is likely my fault from the audit header detangle.
I did try w/ and w/out CONFIG_AUDITSYSCALL set, but only on one arch.
I also did a grep, but was only looking at audit_putname/getname, and
missed the others.  I just did a more complete grep of the symbols that
can get config'd away (including CONFIG_AUDIT as well), and I think
there's a few more missing pieces.  Sorry about that.  Jeff, Ralf,
Martin, these look ok?

thanks,
-chris
--

A closer sweep of configurable audit symbols shows the following need
audit.h included when audit.h is detangled from fs.h as in -mm.

	arch/um/kernel/ptrace.c    for audit_syscall_entry/exit
	arch/s390/kernel/ptrace.c  for audit_syscall_entry/exit
	arch/mips/kernel/ptrace.c  for audit_syscall_entry/exit

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== arch/um/kernel/ptrace.c 1.21 vs edited =====
--- 1.21/arch/um/kernel/ptrace.c	2005-01-20 20:59:15 -08:00
+++ edited/arch/um/kernel/ptrace.c	2005-03-01 13:23:06 -08:00
@@ -9,6 +9,7 @@
 #include "linux/smp_lock.h"
 #include "linux/security.h"
 #include "linux/ptrace.h"
+#include "linux/audit.h"
 #ifdef CONFIG_PROC_MM
 #include "linux/proc_mm.h"
 #endif
===== arch/s390/kernel/ptrace.c 1.28 vs edited =====
--- 1.28/arch/s390/kernel/ptrace.c	2005-01-04 18:48:19 -08:00
+++ edited/arch/s390/kernel/ptrace.c	2005-03-01 13:22:45 -08:00
@@ -31,6 +31,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/audit.h>
 
 #include <asm/segment.h>
 #include <asm/page.h>
===== arch/mips/kernel/ptrace.c 1.15 vs edited =====
--- 1.15/arch/mips/kernel/ptrace.c	2005-01-30 22:20:14 -08:00
+++ edited/arch/mips/kernel/ptrace.c	2005-03-01 13:24:48 -08:00
@@ -25,6 +25,7 @@
 #include <linux/smp_lock.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/audit.h>
 
 #include <asm/cpu.h>
 #include <asm/fpu.h>
