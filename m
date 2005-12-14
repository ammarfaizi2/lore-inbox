Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVLNUXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVLNUXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVLNUXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:23:07 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:18106 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964940AbVLNUXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:23:06 -0500
Subject: Re: kernel-2.6.15-rc5-rt2 - compilation error
	=?ISO-8859-1?Q?=91RWSEM=5FACTIVE=5FBIAS=92?= undeclared
From: Steven Rostedt <rostedt@goodmis.org>
To: art@usfltd.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <200512141157.AA15073854@usfltd.com>
References: <200512141157.AA15073854@usfltd.com>
Content-Type: text/plain; charset=iso-8859-7
Date: Wed, 14 Dec 2005 15:22:52 -0500
Message-Id: <1134591773.13138.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 11:57 -0600, art wrote:
> kernel-2.6.15-rc5-rt2 - compilation error ¡RWSEM_ACTIVE_BIAS¢ undeclared
> 
> gcc version 4.0.2
> ........
>   CC      lib/kref.o
>   CC      lib/prio_tree.o
>   CC      lib/radix-tree.o
>   CC      lib/rbtree.o
>   CC      lib/rwsem.o
> lib/rwsem.c: In function ¡__rwsem_do_wake¢:
> lib/rwsem.c:57: warning: implicit declaration of function ¡rwsem_atomic_update¢
> lib/rwsem.c:57: error: ¡RWSEM_ACTIVE_BIAS¢ undeclared (first use in this function)

Art,

Use this patch.

Ingo,

Could you please apply this.

-- Steve


Index: linux-2.6.15-rc5-rt2/arch/i386/Kconfig
===================================================================
--- linux-2.6.15-rc5-rt2.orig/arch/i386/Kconfig	2005-12-14 14:37:01.000000000 -0500
+++ linux-2.6.15-rc5-rt2/arch/i386/Kconfig	2005-12-14 15:19:53.000000000 -0500
@@ -245,8 +245,7 @@
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
-	depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT
-	default y
+	default y if !RWSEM_GENERIC_SPINLOCK
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
Index: linux-2.6.15-rc5-rt2/arch/i386/Kconfig.cpu
===================================================================
--- linux-2.6.15-rc5-rt2.orig/arch/i386/Kconfig.cpu	2005-12-14 14:36:56.000000000 -0500
+++ linux-2.6.15-rc5-rt2/arch/i386/Kconfig.cpu	2005-12-14 15:19:53.000000000 -0500
@@ -229,11 +229,6 @@
 	depends on M386
 	default y
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	depends on !M386
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y


