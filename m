Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWHIR5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWHIR5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWHIR5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:57:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60825 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750987AbWHIR5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:57:23 -0400
Date: Wed, 9 Aug 2006 13:56:42 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, arjan@infradead.org
Subject: Re: [BUG?] possible recursive locking detected (blkdev_open)
Message-ID: <20060809175642.GC10930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, arjan@infradead.org
References: <200608090757.32006.eike-kernel@sf-tec.de> <20060809013034.ac15526a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809013034.ac15526a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 01:30:34AM -0700, Andrew Morton wrote:
 > On Wed, 9 Aug 2006 07:57:31 +0200
 > Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
 > 
 > > =============================================
 > > [ INFO: possible recursive locking detected ]
 > > ---------------------------------------------
 > 
 > kernel version?
 
This question comes up time after time when we get lockdep reports.
Lets do the same thing we do for oopses - print out the version in the report.
It's an extra line of output though.  We could tack it on the end of the
INFO: lines, but that screws up Ingo's pretty output.

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6/kernel/lockdep.c~	2006-08-09 13:53:49.000000000 -0400
+++ linux-2.6/kernel/lockdep.c	2006-08-09 13:53:59.000000000 -0400
@@ -36,6 +36,7 @@
 #include <linux/stacktrace.h>
 #include <linux/debug_locks.h>
 #include <linux/irqflags.h>
+#include <linux/utsname.h>
 
 #include <asm/sections.h>
@@ -524,6 +524,9 @@ print_circular_bug_header(struct lock_li
 
 	printk("\n=======================================================\n");
 	printk(  "[ INFO: possible circular locking dependency detected ]\n");
+	printk(  "%s %.*s\n", system_utsname.release,
+		(int)strcspn(system_utsname.version, " "),
+		system_utsname.version);
 	printk(  "-------------------------------------------------------\n");
 	printk("%s/%d is trying to acquire lock:\n",
 		curr->comm, curr->pid);
@@ -705,6 +708,9 @@ print_bad_irq_dependency(struct task_str
 	printk("\n======================================================\n");
 	printk(  "[ INFO: %s-safe -> %s-unsafe lock order detected ]\n",
 		irqclass, irqclass);
+	printk(  "%s %.*s\n", system_utsname.release,
+		(int)strcspn(system_utsname.version, " "),
+		system_utsname.version);
 	printk(  "------------------------------------------------------\n");
 	printk("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
 		curr->comm, curr->pid,
@@ -786,6 +792,9 @@ print_deadlock_bug(struct task_struct *c
 
 	printk("\n=============================================\n");
 	printk(  "[ INFO: possible recursive locking detected ]\n");
+	printk(  "%s %.*s\n", system_utsname.release,
+		(int)strcspn(system_utsname.version, " "),
+		system_utsname.version);
 	printk(  "---------------------------------------------\n");
 	printk("%s/%d is trying to acquire lock:\n",
 		curr->comm, curr->pid);
@@ -1368,6 +1377,9 @@ print_irq_inversion_bug(struct task_stru
 
 	printk("\n=========================================================\n");
 	printk(  "[ INFO: possible irq lock inversion dependency detected ]\n");
+	printk(  "%s %.*s\n", system_utsname.release,
+		(int)strcspn(system_utsname.version, " "),
+		system_utsname.version);
 	printk(  "---------------------------------------------------------\n");
 	printk("%s/%d just changed the state of lock:\n",
 		curr->comm, curr->pid);
@@ -1462,6 +1474,9 @@ print_usage_bug(struct task_struct *curr
 
 	printk("\n=================================\n");
 	printk(  "[ INFO: inconsistent lock state ]\n");
+	printk(  "%s %.*s\n", system_utsname.release,
+		(int)strcspn(system_utsname.version, " "),
+		system_utsname.version);
 	printk(  "---------------------------------\n");
 
 	printk("inconsistent {%s} -> {%s} usage.\n",

-- 
http://www.codemonkey.org.uk
