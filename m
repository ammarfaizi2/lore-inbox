Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWFWNFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWFWNFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWFWNFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:05:38 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:7357 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964807AbWFWNFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:05:37 -0400
Date: Fri, 23 Jun 2006 15:05:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, arjan@infradead.org, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [patch 8/8] lock validator: add s390 to supported options
Message-ID: <20060623130506.GD9446@osiris.boeblingen.de.ibm.com>
References: <20060614142503.GI1241@osiris.boeblingen.de.ibm.com> <20060619150547.0b6213b1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619150547.0b6213b1.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 03:05:47PM -0700, Andrew Morton wrote:
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> >
> >  config DEBUG_SPINLOCK_ALLOC
> >  	bool "Spinlock debugging: detect incorrect freeing of live spinlocks"
> > -	depends on DEBUG_SPINLOCK && X86
> > +	depends on DEBUG_SPINLOCK && (X86 || S390)
> 
> Can we please stomp this out before it starts to look like
> CONFIG_FRAME_POINTER?
> 
> We should define CONFIG_ARCH_SUPPORTS_LOCKDEP down in
> arch/[i386|x86_64|s390]/Kconfig and use that in lib/Kconfig.debug.

How about this:

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add LOCKDEP_SUPPORT config option per architecture.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/i386/Kconfig.debug   |    4 ++++
 arch/s390/Kconfig.debug   |    4 ++++
 arch/x86_64/Kconfig.debug |    4 ++++
 lib/Kconfig.debug         |   10 +++++-----
 4 files changed, 17 insertions(+), 5 deletions(-)

Index: linux-2.6.17-mm1/arch/i386/Kconfig.debug
===================================================================
--- linux-2.6.17-mm1.orig/arch/i386/Kconfig.debug
+++ linux-2.6.17-mm1/arch/i386/Kconfig.debug
@@ -4,6 +4,10 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
 source "lib/Kconfig.debug"
 
 config EARLY_PRINTK
Index: linux-2.6.17-mm1/arch/s390/Kconfig.debug
===================================================================
--- linux-2.6.17-mm1.orig/arch/s390/Kconfig.debug
+++ linux-2.6.17-mm1/arch/s390/Kconfig.debug
@@ -4,6 +4,10 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
 source "lib/Kconfig.debug"
 
 endmenu
Index: linux-2.6.17-mm1/arch/x86_64/Kconfig.debug
===================================================================
--- linux-2.6.17-mm1.orig/arch/x86_64/Kconfig.debug
+++ linux-2.6.17-mm1/arch/x86_64/Kconfig.debug
@@ -4,6 +4,10 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
 source "lib/Kconfig.debug"
 
 config DEBUG_RODATA
Index: linux-2.6.17-mm1/lib/Kconfig.debug
===================================================================
--- linux-2.6.17-mm1.orig/lib/Kconfig.debug
+++ linux-2.6.17-mm1/lib/Kconfig.debug
@@ -159,7 +159,7 @@ config DEBUG_SPINLOCK
 
 config DEBUG_SPINLOCK_ALLOC
 	bool "Spinlock debugging: detect incorrect freeing of live spinlocks"
-	depends on DEBUG_SPINLOCK && (X86 || S390)
+	depends on LOCKDEP_SUPPORT && DEBUG_SPINLOCK
 	select LOCKDEP
 	help
 	 This feature will check whether any held spinlock is incorrectly
@@ -208,7 +208,7 @@ config PROVE_SPIN_LOCKING
 
 config DEBUG_RWLOCK_ALLOC
 	bool "rw-lock debugging: detect incorrect freeing of live rwlocks"
-	depends on DEBUG_SPINLOCK && (X86 || S390)
+	depends on LOCKDEP_SUPPORT && DEBUG_SPINLOCK
 	select LOCKDEP
 	help
 	 This feature will check whether any held rwlock is incorrectly
@@ -265,7 +265,7 @@ config DEBUG_MUTEXES
 
 config DEBUG_MUTEX_ALLOC
 	bool "Mutex debugging: detect incorrect freeing of live mutexes"
-	depends on DEBUG_MUTEXES && (X86 || S390)
+	depends on LOCKDEP_SUPPORT && DEBUG_MUTEXES
 	select LOCKDEP
 	help
 	 This feature will check whether any held mutex is incorrectly
@@ -321,7 +321,7 @@ config DEBUG_RWSEMS
 
 config DEBUG_RWSEM_ALLOC
 	bool "rwsem debugging: detect incorrect freeing of live rwsems"
-	depends on DEBUG_RWSEMS && (X86 || S390)
+	depends on LOCKDEP_SUPPORT && DEBUG_RWSEMS
 	select LOCKDEP
 	help
 	 This feature will check whether any held rwsem is incorrectly
@@ -373,7 +373,7 @@ config LOCKDEP
 	select FRAME_POINTER
 	select KALLSYMS
 	select KALLSYMS_ALL
-	depends on X86 || S390
+	depends on LOCKDEP_SUPPORT
 
 config DEBUG_NON_NESTED_UNLOCKS
 	bool "Detect non-nested unlocks"
