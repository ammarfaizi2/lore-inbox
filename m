Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031826AbWLGIG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031826AbWLGIG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031827AbWLGIG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:06:58 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:4386 "EHLO
	outbound0.sv.meer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031826AbWLGIG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:06:57 -0500
Subject: [PATCH 1/5 -mm] fault-injection: Correct, disambiguate, and
	reformat documentation.
From: Don Mullis <dwm@meer.net>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 00:06:52 -0800
Message-Id: <1165478812.2706.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct, disambiguate, and reformat documentation.

Signed-off-by: Don Mullis <dwm@meer.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/fault-injection/failmodule.sh       |    4 -
 Documentation/fault-injection/fault-injection.txt |   70 +++++++++++-----------
 2 files changed, 37 insertions(+), 37 deletions(-)

Index: linux-2.6.18/Documentation/fault-injection/failmodule.sh
===================================================================
--- linux-2.6.18.orig/Documentation/fault-injection/failmodule.sh
+++ linux-2.6.18/Documentation/fault-injection/failmodule.sh
@@ -26,6 +26,6 @@ fi
 # Disable any fault injection
 echo 0 > /debug/$1/stacktrace-depth
 
-echo `cat /sys/module/$2/sections/.text` > /debug/$1/address-start
-echo `cat /sys/module/$2/sections/.exit.text` > /debug/$1/address-end
+echo `cat /sys/module/$2/sections/.text` > /debug/$1/require-start
+echo `cat /sys/module/$2/sections/.exit.text` > /debug/$1/require-end
 echo $STACKTRACE_DEPTH > /debug/$1/stacktrace-depth
Index: linux-2.6.18/Documentation/fault-injection/fault-injection.txt
===================================================================
--- linux-2.6.18.orig/Documentation/fault-injection/fault-injection.txt
+++ linux-2.6.18/Documentation/fault-injection/fault-injection.txt
@@ -17,7 +17,7 @@ o fail_page_alloc
 
 o fail_make_request
 
-  injects disk IO errors on permitted devices by
+  injects disk IO errors on devices permitted by setting
   /sys/block/<device>/make-it-fail or
   /sys/block/<device>/<partition>/make-it-fail. (generic_make_request())
 
@@ -29,16 +29,16 @@ o debugfs entries
 fault-inject-debugfs kernel module provides some debugfs entries for runtime
 configuration of fault-injection capabilities.
 
-- /debug/*/probability:
+- /debug/fail*/probability:
 
 	likelihood of failure injection, in percent.
 	Format: <percent>
 
-	Note that one-failure-per-handred is a very high error rate
-	for some testcases. Please set probably=100 and configure
-	/debug/*/interval for such testcases.
+	Note that one-failure-per-hundred is a very high error rate
+	for some testcases.  Consider setting probability=100 and configure
+	/debug/fail*/interval for such testcases.
 
-- /debug/*/interval:
+- /debug/fail*/interval:
 
 	specifies the interval between failures, for calls to
 	should_fail() that pass all the other tests.
@@ -46,37 +46,36 @@ configuration of fault-injection capabil
 	Note that if you enable this, by setting interval>1, you will
 	probably want to set probability=100.
 
-- /debug/*/times:
+- /debug/fail*/times:
 
 	specifies how many times failures may happen at most.
 	A value of -1 means "no limit".
 
-- /debug/*/space:
+- /debug/fail*/space:
 
 	specifies an initial resource "budget", decremented by "size"
 	on each call to should_fail(,size).  Failure injection is
 	suppressed until "space" reaches zero.
 
-- /debug/*/verbose
+- /debug/fail*/verbose
 
 	Format: { 0 | 1 | 2 }
-	specifies the verbosity of the messages when failure is injected.
-	We default to 0 (no extra messages), setting it to '1' will
-	print only to tell failure happened, '2' will print call trace too -
-	it is useful to debug the problems revealed by fault injection
-	capabilities.
+	specifies the verbosity of the messages when failure is
+	injected.  '0' means no messages; '1' will print only a single
+	log line per failure; '2' will print a call trace too -- useful
+	to debug the problems revealed by fault injection.
 
-- /debug/*/task-filter:
+- /debug/fail*/task-filter:
 
-	Format: { 0 | 1 }
-	A value of '0' disables filtering by process (default).
+	Format: { 'Y' | 'N' }
+	A value of 'N' disables filtering by process (default).
 	Any positive value limits failures to only processes indicated by
 	/proc/<pid>/make-it-fail==1.
 
-- /debug/*/require-start:
-- /debug/*/require-end:
-- /debug/*/reject-start:
-- /debug/*/reject-end:
+- /debug/fail*/require-start:
+- /debug/fail*/require-end:
+- /debug/fail*/reject-start:
+- /debug/fail*/reject-end:
 
 	specifies the range of virtual addresses tested during
 	stacktrace walking.  Failure is injected only if some caller
@@ -85,22 +84,23 @@ configuration of fault-injection capabil
 	Default required range is [0,ULONG_MAX) (whole of virtual address space).
 	Default rejected range is [0,0).
 
-- /debug/*/stacktrace-depth:
+- /debug/fail*/stacktrace-depth:
 
 	specifies the maximum stacktrace depth walked during search
-	for a caller within [address-start,address-end).
+	for a caller within [require-start,require-end) OR
+	[reject-start,reject-end).
 
 - /debug/fail_page_alloc/ignore-gfp-highmem:
 
-	Format: { 0 | 1 }
-	default is 0, setting it to '1' won't inject failures into
+	Format: { 'Y' | 'N' }
+	default is 'N', setting it to 'Y' won't inject failures into
 	highmem/user allocations.
 
 - /debug/failslab/ignore-gfp-wait:
 - /debug/fail_page_alloc/ignore-gfp-wait:
 
-	Format: { 0 | 1 }
-	default is 0, setting it to '1' will inject failures
+	Format: { 'Y' | 'N' }
+	default is 'N', setting it to 'Y' will inject failures
 	only into non-sleep allocations (GFP_ATOMIC allocations).
 
 o Boot option
@@ -124,22 +124,22 @@ o define the fault attributes
   Please see the definition of struct fault_attr in fault-inject.h
   for details.
 
-o provide the way to configure fault attributes
+o provide a way to configure fault attributes
 
 - boot option
 
   If you need to enable the fault injection capability from boot time, you can
-  provide boot option to configure it. There is a helper function for it.
+  provide boot option to configure it. There is a helper function for it:
 
-  setup_fault_attr(attr, str);
+	setup_fault_attr(attr, str);
 
 - debugfs entries
 
   failslab, fail_page_alloc, and fail_make_request use this way.
-  There is a helper function for it.
+  Helper functions:
 
-  init_fault_attr_entries(entries, attr, name);
-  void cleanup_fault_attr_entries(entries);
+	init_fault_attr_entries(entries, attr, name);
+	void cleanup_fault_attr_entries(entries);
 
 - module parameters
 
@@ -149,9 +149,9 @@ o provide the way to configure fault att
 
 o add a hook to insert failures
 
-  should_fail() returns 1 when failures should happen.
+  Upon should_fail() returning true, client code should inject a failure.
 
-	should_fail(attr,size);
+	should_fail(attr, size);
 
 Application Examples
 --------------------


