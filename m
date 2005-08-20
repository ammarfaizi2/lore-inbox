Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbVHTDSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbVHTDSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVHTDSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:18:52 -0400
Received: from siaag1ah.compuserve.com ([149.174.40.14]:45928 "EHLO
	siaag1ah.compuserve.com") by vger.kernel.org with ESMTP
	id S932647AbVHTDSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:18:52 -0400
Date: Fri, 19 Aug 2005 23:14:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc6] docs: fix misinformation about
  overcommit_memory
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200508192318_MC3-1-A7AE-1D7A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone complained about the docs for vm_overcommit_memory being wrong.
This patch copies the text from the vm documentation into procfs.
Please apply.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
 Documentation/filesystems/proc.txt |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

--- 2.6.13-rc6c.orig/Documentation/filesystems/proc.txt
+++ 2.6.13-rc6c/Documentation/filesystems/proc.txt
@@ -1240,16 +1240,25 @@ swap-intensive.
 overcommit_memory
 -----------------
 
-This file  contains  one  value.  The following algorithm is used to decide if
-there's enough  memory:  if  the  value of overcommit_memory is positive, then
-there's always  enough  memory. This is a useful feature, since programs often
-malloc() huge  amounts  of  memory 'just in case', while they only use a small
-part of  it.  Leaving  this value at 0 will lead to the failure of such a huge
-malloc(), when in fact the system has enough memory for the program to run.
-
-On the  other  hand,  enabling this feature can cause you to run out of memory
-and thrash the system to death, so large and/or important servers will want to
-set this value to 0.
+Controls overcommit of system memory:
+
+0	-	Heuristic overcommit handling. Obvious overcommits of
+		address space are refused. Used for a typical system. It
+		ensures a seriously wild allocation fails while allowing
+		overcommit to reduce swap usage.  root is allowed to
+		allocate slighly more memory in this mode. This is the
+		default.
+
+1	-	Always overcommit. Appropriate for some scientific
+		applications.
+
+2	-	Don't overcommit. The total address space commit
+		for the system is not permitted to exceed swap + a
+		configurable percentage (default is 50) of physical RAM.
+		Depending on the percentage you use, in most situations
+		this means a process will not be killed while accessing
+		pages but will receive errors on memory allocation as
+		appropriate.
 
 nr_hugepages and hugetlb_shm_group
 ----------------------------------
__
Chuck
