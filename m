Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVLJIS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVLJIS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVLJIS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:18:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58304 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964963AbVLJIS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:18:58 -0500
Date: Sat, 10 Dec 2005 00:18:48 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081848.12303.52397.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 01/10] Cpuset: remove marker_pid documentation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove documentation for the cpuset 'marker_pid' feature, that
was in the patch "cpuset: change marker for relative numbering"
That patch was previously pulled from *-mm at my (pj) request.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 Documentation/cpusets.txt |   50 +++-------------------------------------------
 1 files changed, 4 insertions(+), 46 deletions(-)

--- 2.6.15-rc3-mm1.orig/Documentation/cpusets.txt	2005-12-04 02:09:06.423921557 -0800
+++ 2.6.15-rc3-mm1/Documentation/cpusets.txt	2005-12-04 02:32:31.231015268 -0800
@@ -16,9 +16,8 @@ CONTENTS:
   1.3 How are cpusets implemented ?
   1.4 What are exclusive cpusets ?
   1.5 What does notify_on_release do ?
-  1.6 What is a marker_pid ?
-  1.7 What is memory_pressure ?
-  1.8 How do I use cpusets ?
+  1.6 What is memory_pressure ?
+  1.7 How do I use cpusets ?
 2. Usage Examples and Syntax
   2.1 Basic Usage
   2.2 Adding/removing cpus
@@ -178,7 +177,6 @@ containing the following files describin
  - mem_exclusive flag: is memory placement exclusive?
  - tasks: list of tasks (by pid) attached to that cpuset
  - notify_on_release flag: run /sbin/cpuset_release_agent on exit?
- - marker_pid: pid of user task in co-ordinated operation sequence
  - memory_pressure: measure of how much paging pressure in cpuset
 
 In addition, the root cpuset only has the following file:
@@ -260,47 +258,7 @@ boot is disabled (0).  The default value
 is the current value of their parents notify_on_release setting.
 
 
-1.6 What is a marker_pid ?
---------------------------
-
-The marker_pid helps manage cpuset changes safely from user space.
-
-The interface presented to user space for cpusets uses system wide
-numbering of CPUs and Memory Nodes.   It is the responsibility of
-user level code, presumably in a library, to present cpuset-relative
-numbering to applications when that would be more useful to them.
-
-However if a task is moved to a different cpuset, or if the 'cpus' or
-'mems' of a cpuset are changed, then we need a way for such library
-code to detect that its cpuset-relative numbering has changed, when
-expressed using system wide numbering.
-
-The kernel cannot safely allow user code to lock kernel resources.
-The kernel could deliver out-of-band notice of cpuset changes by
-such mechanisms as signals or usermodehelper callbacks, however
-this can't be synchronously delivered to library code linked in
-applications without intruding on the IPC mechanisms available to
-the app.  The kernel could require user level code to do all the work,
-tracking the cpuset state before and during changes, to verify no
-unexpected change occurred, but this becomes an onerous task.
-
-The "marker_pid" cpuset field provides a simple way to make this task
-less onerous on user library code.  A task writes its pid to a cpusets
-"marker_pid" at the start of a sequence of queries and updates,
-and check as it goes that the cpusets marker_pid doesn't change.
-The pread(2) system call does a seek and read in a single call.
-If the marker_pid changes, the user code should retry the required
-sequence of operations.
-
-Anytime that a task modifies the "cpus" or "mems" of a cpuset,
-unless it's pid is in the cpusets marker_pid field, the kernel zeros
-this field.
-
-The above was inspired by the load linked and store conditional
-(ll/sc) instructions in the MIPS II instruction set.
-
-
-1.7 What is memory_pressure ?
+1.6 What is memory_pressure ?
 -----------------------------
 The memory_pressure of a cpuset provides a simple per-cpuset metric
 of the rate that the tasks in a cpuset are attempting to free up in
@@ -357,7 +315,7 @@ the tasks in the cpuset, in units of rec
 times 1000.
 
 
-1.8 How do I use cpusets ?
+1.7 How do I use cpusets ?
 --------------------------
 
 In order to minimize the impact of cpusets on critical kernel

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
