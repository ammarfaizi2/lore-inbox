Return-Path: <linux-kernel-owner+w=401wt.eu-S932725AbWLNNnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWLNNnK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWLNNnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:43:10 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:59384
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932726AbWLNNnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:43:09 -0500
Date: Thu, 14 Dec 2006 05:43:04 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: [PATCH 5/5] lock stat kills lock meter for -rt (makefile)
Message-ID: <20061214134304.GE22194@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Build system changes.

bill


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make.diff"

============================================================
--- kernel/Kconfig.preempt	3148bd94270ea0a853d8e443616cd7a668dd0d3b
+++ kernel/Kconfig.preempt	d63831dbfbb9e68386bfc862fd2dd1a8f1e9779f
@@ -176,3 +176,12 @@ config RCU_TRACE
 
 	  Say Y here if you want to enable RCU tracing
 	  Say N if you are unsure.
+
+config LOCK_STAT
+	bool "Lock contention statistics tracking in /proc"
+	depends on PREEMPT_RT && !DEBUG_RT_MUTEXES
+	default y
+	help
+	  General lock statistics tracking with regard to contention in
+	  /proc/lock_stat/contention
+
============================================================
--- kernel/Makefile	0690fbe8c605a1c7e24b7b94d05a96ea32574aab
+++ kernel/Makefile	08087775b67b7ac1682dac0310003ef7ecbd7e70
@@ -63,6 +63,7 @@ obj-$(CONFIG_TASKSTATS) += taskstats.o t
 obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
+obj-$(CONFIG_LOCK_STAT) += lock_stat.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is

--HnQK338I3UIa/qiP--
