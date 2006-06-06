Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWFFNfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWFFNfx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWFFNfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:35:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:43151 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932167AbWFFNfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:35:52 -0400
Date: Tue, 6 Jun 2006 15:34:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: 2.6.18 -mm pi-futex merge
In-Reply-To: <1149597128.16247.40.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606061530330.17704@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
 <1149597128.16247.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Jun 2006, Steven Rostedt wrote:

> On Sun, 2006-06-04 at 13:50 -0700, Andrew Morton wrote:
> 
> > pi-futex-futex-code-cleanups.patch
> > pi-futex-robust-futex-docs-fix.patch
> > pi-futex-introduce-debug_check_no_locks_freed.patch
> > pi-futex-introduce-warn_on_smp.patch
> > pi-futex-add-plist-implementation.patch
> > pi-futex-scheduler-support-for-pi.patch
> > pi-futex-rt-mutex-core.patch
> > pi-futex-rt-mutex-docs.patch
> > pi-futex-rt-mutex-docs-update.patch
> > pi-futex-rt-mutex-debug.patch
> > pi-futex-rt-mutex-tester.patch
> > pi-futex-rt-mutex-futex-api.patch
> > pi-futex-futex_lock_pi-futex_unlock_pi-support.patch
> > #
> > futex_requeue-optimization.patch
> > 
> >  Priority-inheriting futexes.  I don't have a clue how this code works,
> >  but it sure has a lot of trylocks for something which allegedly works. 
> >  Will merge.

Please also include the patch below to fix defaults and dependencies. 
Thomas, could you please also provide a little more verbose help text?
BTW what's the correct spelling - RT Mutex, rt mutex or rt-mutex?

bye, Roman


[PATCH] fix rt-mutex defaults and dependencies

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 lib/Kconfig.debug |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6-mm/lib/Kconfig.debug
===================================================================
--- linux-2.6-mm.orig/lib/Kconfig.debug	2006-06-06 15:24:45.000000000 +0200
+++ linux-2.6-mm/lib/Kconfig.debug	2006-06-06 15:25:30.000000000 +0200
@@ -158,7 +158,6 @@ config DEBUG_MUTEX_DEADLOCKS
 
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
-	default y
 	depends on DEBUG_KERNEL && RT_MUTEXES
 	help
 	 This allows rt mutex semantics violations and rt mutex related
@@ -171,8 +170,7 @@ config DEBUG_PI_LIST
 
 config RT_MUTEX_TESTER
 	bool "Built-in scriptable tester for rt-mutexes"
-	depends on RT_MUTEXES
-	default n
+	depends on DEBUG_KERNEL && RT_MUTEXES
 	help
 	  This option enables a rt-mutex tester.
 
