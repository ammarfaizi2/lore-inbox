Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUHYTru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUHYTru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268411AbUHYTrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:47:46 -0400
Received: from holomorphy.com ([207.189.100.168]:1679 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268421AbUHYTnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:43:06 -0400
Date: Wed, 25 Aug 2004 12:43:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [2/4] move sigpending to sched.h
Message-ID: <20040825194304.GF2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com> <20040825180138.GA2793@holomorphy.com> <20040825180342.GB2793@holomorphy.com> <20040825193921.GC2793@holomorphy.com> <20040825194207.GE2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825194207.GE2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 12:39:21PM -0700, William Lee Irwin III wrote:
>> This series removes the dependency of sched.h on signal.h
>> Atop the just-posted user bits atop 2.6.8.1-mm4.

On Wed, Aug 25, 2004 at 12:42:07PM -0700, William Lee Irwin III wrote:
> Sorry, this is the real 1/4.
> Move sigqueue-related bits to include/linux/signal.h

Move sigpending -related bits to include/linux/sched.h

Index: mm4-2.6.8.1/include/linux/sched.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/sched.h	2004-08-25 11:11:27.993358504 -0700
+++ mm4-2.6.8.1/include/linux/sched.h	2004-08-25 11:43:53.764556320 -0700
@@ -259,6 +259,11 @@
 	spinlock_t		siglock;
 };
 
+struct sigpending {
+	struct list_head list;
+	sigset_t signal;
+};
+
 /*
  * NOTE! "signal_struct" does not have it's own
  * locking, because a shared signal_struct always
Index: mm4-2.6.8.1/include/linux/signal.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/signal.h	2004-08-25 11:13:45.762414424 -0700
+++ mm4-2.6.8.1/include/linux/signal.h	2004-08-25 11:44:18.280829280 -0700
@@ -25,11 +25,6 @@
 /* flags values. */
 #define SIGQUEUE_PREALLOC	1
 
-struct sigpending {
-	struct list_head list;
-	sigset_t signal;
-};
-
 /*
  * Define some primitives to manipulate sigset_t.
  */
