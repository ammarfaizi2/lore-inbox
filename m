Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbWFZSwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWFZSwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWFZSwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:52:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:42443 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932650AbWFZSwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:52:13 -0400
Date: Mon, 26 Jun 2006 11:52:47 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       arjan@infradead.org, ioe-lkml@rameria.de, greg@kroah.com,
       pbadari@us.ibm.com, mrmacman_g4@mac.com, hugh@veritas.com,
       vatsa@in.ibm.com
Subject: [PATCH 1/3] rcutorture: catchup doc fixes for idle-hz tests
Message-ID: <20060626185247.GA2141@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060626184821.GA2091@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626184821.GA2091@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just catches the RCU torture documentation up with the recent
fixes that test RCU for architectures that turn of the scheduling-clock
interrupt for idle CPUs and the addition of a SUCCESS/FAILURE
indication, fixing up an obsolete comment as well.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 Documentation/RCU/torture.txt |   12 +++++++++++-
 kernel/rcutorture.c           |    2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17/Documentation/RCU/torture.txt linux-2.6.17-torturedoc/Documentation/RCU/torture.txt
--- linux-2.6.17/Documentation/RCU/torture.txt	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-torturedoc/Documentation/RCU/torture.txt	2006-06-24 11:34:36.000000000 -0700
@@ -35,6 +35,15 @@ stat_interval	The number of seconds betw
 		be printed -only- when the module is unloaded, and this
 		is the default.
 
+shuffle_interval
+		The number of seconds to keep the test threads affinitied
+		to a particular subset of the CPUs.  Used in conjunction
+		with test_no_idle_hz.
+
+test_no_idle_hz	Whether or not to test the ability of RCU to operate in
+		a kernel that disables the scheduling-clock interrupt to
+		idle CPUs.  Boolean parameter, "1" to test, "0" otherwise.
+
 verbose		Enable debug printk()s.  Default is disabled.
 
 
@@ -119,4 +128,5 @@ The following script may be used to tort
 
 The output can be manually inspected for the error flag of "!!!".
 One could of course create a more elaborate script that automatically
-checked for such errors.
+checked for such errors.  The "rmmod" command forces a "SUCCESS" or
+"FAILURE" indication to be printk()ed.
diff -urpNa -X dontdiff linux-2.6.17/kernel/rcutorture.c linux-2.6.17-torturedoc/kernel/rcutorture.c
--- linux-2.6.17/kernel/rcutorture.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-torturedoc/kernel/rcutorture.c	2006-06-23 16:28:08.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * Read-Copy Update /proc-based torture test facility
+ * Read-Copy Update module-based torture test facility
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
