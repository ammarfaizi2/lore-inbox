Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUG1Ql4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUG1Ql4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUG1Qlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:41:42 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53165 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267298AbUG1QlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:41:06 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc2-mm1
Date: Wed, 28 Jul 2004 09:36:06 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040728020444.4dca7e23.akpm@osdl.org>
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2X9BBCsPlE0OMoA"
Message-Id: <200407280936.06244.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_2X9BBCsPlE0OMoA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday, July 28, 2004 2:04 am, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6
>.8-rc2-mm1/

sd->groups isn't initialized this early (I know because I ran into this when I 
first tried to merge Suresh's patch too).  You've already got the real fix in 
your tree, you just need this little bit torn out.

Thanks,
Jesse

--Boundary-00=_2X9BBCsPlE0OMoA
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

--Boundary-00=_2X9BBCsPlE0OMoA--
