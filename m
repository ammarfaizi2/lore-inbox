Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWJALiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWJALiA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWJALhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:37:55 -0400
Received: from mx01.stofanet.dk ([212.10.10.11]:40327 "EHLO mx01.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751827AbWJALhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:37:35 -0400
Date: Sun, 1 Oct 2006 13:36:56 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 2/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <Pine.LNX.4.64.0610011336530.29459@frodo.shire>
References: <20061001112829.630288000@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A minor update to the rt-mutex tester framework.

  scripts/rt-tester/reset-tester.py            |   18 ++++++++++++++++++
  scripts/rt-tester/t2-l1-signal.tst           |    3 +++
  scripts/rt-tester/t3-l1-pi-signal.tst        |    3 ++-
  scripts/rt-tester/t4-l2-pi-deboost.tst       |    2 ++
  scripts/rt-tester/t5-l4-pi-boost-deboost.tst |    2 ++
  5 files changed, 27 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rt/scripts/rt-tester/reset-tester.py
===================================================================
--- /dev/null
+++ linux-2.6.18-rt/scripts/rt-tester/reset-tester.py
@@ -0,0 +1,18 @@
+#!/usr/bin/env python
+
+sysfsprefix = "/sys/devices/system/rttest/rttest"
+statusfile = "/status"
+commandfile = "/command"
+
+for i in range(0,8):
+    cmdstr = "%s:%s" %("99", "0")
+    fname = "%s%d%s" %(sysfsprefix, i, commandfile)
+
+    try:
+        fcmd = open(fname, 'w')
+        fcmd.write(cmdstr)
+        fcmd.close()
+    except Exception,ex:
+        print i
+        print ex
+
Index: linux-2.6.18-rt/scripts/rt-tester/t2-l1-signal.tst
===================================================================
--- linux-2.6.18-rt.orig/scripts/rt-tester/t2-l1-signal.tst
+++ linux-2.6.18-rt/scripts/rt-tester/t2-l1-signal.tst
@@ -75,3 +75,6 @@ T: opcodeeq:		1:	-4
  # Unlock and exit
  C: unlock:		0: 	0
  W: unlocked:		0: 	0
+
+# Reset the -4 opcode from the signal
+C: reset:               1:      0
\ No newline at end of file
Index: linux-2.6.18-rt/scripts/rt-tester/t3-l1-pi-signal.tst
===================================================================
--- linux-2.6.18-rt.orig/scripts/rt-tester/t3-l1-pi-signal.tst
+++ linux-2.6.18-rt/scripts/rt-tester/t3-l1-pi-signal.tst
@@ -95,4 +95,5 @@ C: unlock:		1: 	0
  W: unlocked:		1: 	0


-
+# Reset the -4 opcode from the signal
+C: reset:               2:      0
\ No newline at end of file
Index: linux-2.6.18-rt/scripts/rt-tester/t4-l2-pi-deboost.tst
===================================================================
--- linux-2.6.18-rt.orig/scripts/rt-tester/t4-l2-pi-deboost.tst
+++ linux-2.6.18-rt/scripts/rt-tester/t4-l2-pi-deboost.tst
@@ -121,3 +121,5 @@ W: unlocked:		2:	1
  C: unlock:		0:	0
  W: unlocked:		0:	0

+# Reset the -4 opcode from the signal
+C: reset:               3:      0
\ No newline at end of file
Index: linux-2.6.18-rt/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
===================================================================
--- linux-2.6.18-rt.orig/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
+++ linux-2.6.18-rt/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
@@ -141,3 +141,5 @@ W: unlocked:		2:	2
  W: unlocked:		1:	1
  W: unlocked:		0:	0

+# Reset the -4 opcode from the signal
+C: reset:               4:      0
\ No newline at end of file

--
