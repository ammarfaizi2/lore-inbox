Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWBHGoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWBHGoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWBHGnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:52 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35971 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161022AbWBHGnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:13 -0500
Message-Id: <20060208064903.678740000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 12/23] [SPARC64]: Kill compat_sys_clock_settime sign extension stub.
Content-Disposition: inline; filename=kill-compat_sys_clock_settime-sign-extension-stub.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

    
It's wrong and totally unneeded.

Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/sparc64/kernel/sys32.S   |    1 -
 arch/sparc64/kernel/systbls.S |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.15.3/arch/sparc64/kernel/sys32.S
===================================================================
--- linux-2.6.15.3.orig/arch/sparc64/kernel/sys32.S
+++ linux-2.6.15.3/arch/sparc64/kernel/sys32.S
@@ -84,7 +84,6 @@ SIGN2(sys32_fadvise64_64, compat_sys_fad
 SIGN2(sys32_bdflush, sys_bdflush, %o0, %o1)
 SIGN1(sys32_mlockall, sys_mlockall, %o0)
 SIGN1(sys32_nfsservctl, compat_sys_nfsservctl, %o0)
-SIGN1(sys32_clock_settime, compat_sys_clock_settime, %o1)
 SIGN1(sys32_clock_nanosleep, compat_sys_clock_nanosleep, %o1)
 SIGN1(sys32_timer_settime, compat_sys_timer_settime, %o1)
 SIGN1(sys32_io_submit, compat_sys_io_submit, %o1)
Index: linux-2.6.15.3/arch/sparc64/kernel/systbls.S
===================================================================
--- linux-2.6.15.3.orig/arch/sparc64/kernel/systbls.S
+++ linux-2.6.15.3/arch/sparc64/kernel/systbls.S
@@ -71,7 +71,7 @@ sys_call_table32:
 /*240*/	.word sys_munlockall, sys32_sched_setparam, sys32_sched_getparam, sys32_sched_setscheduler, sys32_sched_getscheduler
 	.word sys_sched_yield, sys32_sched_get_priority_max, sys32_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys32_getsid, sys_fdatasync, sys32_nfsservctl
-	.word sys_ni_syscall, sys32_clock_settime, compat_sys_clock_gettime, compat_sys_clock_getres, sys32_clock_nanosleep
+	.word sys_ni_syscall, compat_sys_clock_settime, compat_sys_clock_gettime, compat_sys_clock_getres, sys32_clock_nanosleep
 /*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, sys32_timer_settime, compat_sys_timer_gettime, sys_timer_getoverrun
 	.word sys_timer_delete, sys32_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys32_mq_open, sys_mq_unlink

--
