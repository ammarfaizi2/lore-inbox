Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUG2WWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUG2WWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267488AbUG2WWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:22:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25043 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265697AbUG2WWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:22:42 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: arch_init_sched_domains() oops
Date: Thu, 29 Jul 2004 15:17:21 -0700
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1091138180.23502.81.camel@nighthawk>
In-Reply-To: <1091138180.23502.81.camel@nighthawk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xdXCBd1S60NVK/g"
Message-Id: <200407291517.21613.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_xdXCBd1S60NVK/g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, July 29, 2004 2:56 pm, Dave Hansen wrote:
> This happened on a NUMA running 2.6.8-rc2-mm1:

Is this stock 2.6.8-rc2-mm1?  If so, you may need the attached patch.

Jesse

--Boundary-00=_xdXCBd1S60NVK/g
Content-Type: text/plain;
  charset="iso-8859-1";
  name="sched-merge-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched-merge-fix.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8-rc2-mm1.orig/kernel/sched.c linux-2.6.8-rc2-mm1/kernel/sched.c
--- linux-2.6.8-rc2-mm1.orig/kernel/sched.c	2004-07-28 09:36:36.000000000 -0700
+++ linux-2.6.8-rc2-mm1/kernel/sched.c	2004-07-28 09:34:45.000000000 -0700
@@ -3770,8 +3770,6 @@ __init static void arch_init_sched_domai
 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
 
 #ifdef CONFIG_NUMA
-		if (i != first_cpu(sd->groups->cpumask))
-			continue;
 		sd = &per_cpu(node_domains, i);
 		group = cpu_to_node_group(i);
 		*sd = SD_NODE_INIT;

--Boundary-00=_xdXCBd1S60NVK/g--
