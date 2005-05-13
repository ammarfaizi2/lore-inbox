Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVEMVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVEMVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVEMVbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:31:00 -0400
Received: from orb.pobox.com ([207.8.226.5]:7882 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261642AbVEMV1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:27:54 -0400
Date: Fri, 13 May 2005 16:27:45 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, V Srivatsa <vatsa@in.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513212745.GJ3614@otto>
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513123216.GB3968@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 06:02:17PM +0530, Dinakar Guniguntala wrote:
> On Wed, May 11, 2005 at 02:51:56PM -0500, Nathan Lynch wrote:
> 
> > This trace is what should be fixed -- we're trying to schedule while
> > the machine is "stopped" (all cpus except for one spinning with
> > interrupts off).  I'm not too familiar with the cpusets code but I
> > would like to stay away from nesting these semaphores if at all
> > possible.
> 
> Vatsa pointed out another scenario where cpusets+hotplug is currently
> broken. attach_task in cpuset.c is called without holding the hotplug 
> lock and it is possible to call set_cpus_allowed for a task with no 
> online cpus. 
> Given this I think the patch I sent first is the most appropriate
> patch.

Your original patch is deadlocky since cpuset_cpus_allowed() does
task_lock() while write_lock_irq(&tasklist_lock) is already held by
migrate_live_tasks().


Nathan
