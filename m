Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWDGR0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWDGR0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWDGR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:26:37 -0400
Received: from fmr18.intel.com ([134.134.136.17]:54220 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S964825AbWDGR0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:26:36 -0400
Subject: [PATCH] Kconfig.debug: Set DEBUG_MUTEX to off by default
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Intel
Date: Fri, 07 Apr 2006 09:56:48 -0700
Message-Id: <1144429008.25886.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

DEBUG_MUTEX flag is on by default in current kernel configuration.
 
During performance testing, we saw mutex debug functions like
mutex_debug_check_no_locks_freed (called by kfree()) is expensive as it
goes through a global list of memory areas with mutex lock and do the
checking.  For benchmarks such as Volanomark and Hackbench, we have seen
more than 40% drop in performance on some platforms.  We suggest to set
DEBUG_MUTEX off by default.  Or at least do that later when we feel that
the mutex changes in the current code have stabilized.

Tim Chen

Signed-off-by: Tim Chen <tim.c.chen@intel.com>

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -101,7 +101,7 @@ config DEBUG_PREEMPT
 
 config DEBUG_MUTEXES
 	bool "Mutex debugging, deadlock detection"
-	default y
+	default n
 	depends on DEBUG_KERNEL
 	help
 	 This allows mutex semantics violations and mutex related deadlocks


