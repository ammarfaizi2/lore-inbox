Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVHTHLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVHTHLM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 03:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVHTHLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 03:11:12 -0400
Received: from siaag2ai.mx.compuserve.com ([149.174.40.147]:34770 "EHLO
	siaag2ai.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932078AbVHTHLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 03:11:11 -0400
Date: Sat, 20 Aug 2005 03:07:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc6] docs: fix misinformation about
  overcommit_memory
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <200508200310_MC3-1-A7BC-D1C1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005 20:24:26 -0700, Andrew Morton wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > +Controls overcommit of system memory:
> 
> It should explain what "overcommit" is.


Here is an improved version.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 Documentation/filesystems/proc.txt |   42 ++++++++++++++++++++++++++++---------
 1 files changed, 32 insertions(+), 10 deletions(-)

--- 2.6.13-rc6c.orig/Documentation/filesystems/proc.txt
+++ 2.6.13-rc6c/Documentation/filesystems/proc.txt
@@ -1240,16 +1240,38 @@ swap-intensive.
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
+Controls overcommit of system memory, possibly allowing processes
+to allocate (but not use) more memory than is actually available.
+
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
+		for the system is not permitted to exceed swap plus a
+		configurable percentage (default is 50) of physical RAM.
+		Depending on the percentage you use, in most situations
+		this means a process will not be killed while attempting
+		to use already-allocated memory but will receive errors
+		on memory allocation as	appropriate.
+
+overcommit_ratio
+----------------
+
+Percentage of physical memory size to include in overcommit calculations
+(see above.)
+
+Memory allocation limit = swapspace + physmem * (overcommit_ratio / 100)
+
+	swapspace = total size of all swap areas
+	physmem = size of physical memory in system
 
 nr_hugepages and hugetlb_shm_group
 ----------------------------------
__
Chuck
