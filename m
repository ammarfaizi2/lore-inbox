Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWDGSCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWDGSCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWDGSCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:02:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:49539 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964837AbWDGSCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:02:15 -0400
Subject: Re: [PATCH 2.6.17-rc1-mm1] sched_domain-handle-kmalloc-failure-fix
From: Dave Hansen <haveblue@us.ibm.com>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Eric Whitney <eric.whitney@hp.com>
In-Reply-To: <1144353528.5162.190.camel@localhost.localdomain>
References: <1144353528.5162.190.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 11:01:33 -0700
Message-Id: <1144432893.24221.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-06 at 15:58 -0400, Lee Schermerhorn wrote:
> 2.6.17-rc1-mm1 hangs during boot on HP rx8620 and dl585 -- both 4 node
> NUMA platforms.  Problem is in build_sched_domains() setting up the
> sched_group_nodes[] lists, resulting from patch:
> sched_domain-handle-kmalloc-failure.patch
> 
> The referenced patch does not propagate the "next" pointer from the head
> of the list, resulting in a loop between the last 2 groups in the list.
> This causes a tight loop/hang in init_numa_sched_groups_power() because 
> 'sg->next' never == 'group_head' when you have > 2 nodes. 

Wow.  I'm incredibly impressed that you tracked that down.  I can't
believe how horribly unintelligible that code is.

I ran into the same freeze on a 4-node NUMA-Q.  Your patch fixed it.

Is there any good reason that sched domains has to roll its own linked
lists?  Why not use list_heads?  Seems like it would avoid crappy
problems like this.

-- Dave

