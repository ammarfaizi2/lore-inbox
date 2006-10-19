Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWJSJV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWJSJV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWJSJV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:21:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39306 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030359AbWJSJV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:21:57 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@google.com>, Paul Menage <menage@google.com>,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Rohit Seth <rohitseth@google.com>, Robin Holt <holt@sgi.com>,
       dipankar@in.ibm.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Jackson <pj@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Date: Thu, 19 Oct 2006 02:21:50 -0700
Message-Id: <20061019092150.17547.50354.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] cpuset: minor code refinements
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

A couple of minor code simplifications to the
kernel/cpuset.c code.  No functional change.
Just a little less code and a little more readable.

Signed-off-by: Paul Jackson <pj@sgi.com>

---
 kernel/cpuset.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

--- 2.6.19-rc1-mm1.orig/kernel/cpuset.c	2006-10-19 01:06:29.000000000 -0700
+++ 2.6.19-rc1-mm1/kernel/cpuset.c	2006-10-19 01:06:49.000000000 -0700
@@ -729,9 +729,11 @@ static int validate_change(const struct 
 	}
 
 	/* Remaining checks don't apply to root cpuset */
-	if ((par = cur->parent) == NULL)
+	if (cur == &top_cpuset)
 		return 0;
 
+	par = cur->parent;
+
 	/* We must be a subset of our parent cpuset */
 	if (!is_cpuset_subset(trial, par))
 		return -EACCES;
@@ -1060,10 +1062,7 @@ static int update_flag(cpuset_flagbits_t
 	cpu_exclusive_changed =
 		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
 	mutex_lock(&callback_mutex);
-	if (turning_on)
-		set_bit(bit, &cs->flags);
-	else
-		clear_bit(bit, &cs->flags);
+	cs->flags = trialcs.flags;
 	mutex_unlock(&callback_mutex);
 
 	if (cpu_exclusive_changed)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
