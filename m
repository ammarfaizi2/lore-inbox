Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUHABEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUHABEh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 21:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUHABEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 21:04:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:42649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264595AbUHABEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 21:04:36 -0400
Date: Sat, 31 Jul 2004 18:02:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, jbarnes@engr.sgi.com,
       hawkes@sgi.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isolated sched domains for 2.6.8-rc2-mm1
Message-Id: <20040731180240.5dbd3887.akpm@osdl.org>
In-Reply-To: <20040730174651.GA14868@sgi.com>
References: <20040730174651.GA14868@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> Here's a version of the isolated scheduler domain code that I mentioned in an
>  RFC on 7/22.  This patch applies on top of 2.6.8-rc2-mm1 (to include all of
>  the new arch_init_sched_domain code).  This patch also contains the 2 line
>  fix to remove the check of first_cpu(sd->groups->cpumask)) that Jesse
>  sent in earlier.
> 
>  Note that this has not been tested with CONFIG_SCHED_SMT.  I hope that
>  my handling of those instances is OK.

It wasn't even compile-tested :(

diff -puN kernel/sched.c~sched-isolated-sched-domains-fix kernel/sched.c
--- 25/kernel/sched.c~sched-isolated-sched-domains-fix	2004-07-31 18:00:24.258057576 -0700
+++ 25-akpm/kernel/sched.c	2004-07-31 18:00:45.420840344 -0700
@@ -3861,7 +3861,7 @@ __init static void arch_init_sched_domai
 		if (i != first_cpu(this_sibling_map))
 			continue;
 
-		init_sched_build_groups(sched_group_cpus, this_sibling_mask,
+		init_sched_build_groups(sched_group_cpus, this_sibling_map,
 						&cpu_to_cpu_group);
 	}
 #endif
_

