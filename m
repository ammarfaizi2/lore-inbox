Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVEKTwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVEKTwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVEKTwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:52:15 -0400
Received: from orb.pobox.com ([207.8.226.5]:29100 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261287AbVEKTwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:52:07 -0400
Date: Wed, 11 May 2005 14:51:56 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, V Srivatsa <vatsa@in.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050511195156.GE3614@otto>
References: <20050511191654.GA3916@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511191654.GA3916@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 12:46:54AM +0530, Dinakar Guniguntala wrote:
> 
> cpusets+hotplug+preempt hangs up the machine, if both
> cpuset and hotplug operations are going on simultaneously
> 
> I also get this oops first
> 
> scheduling while atomic: cpuoff.sh/0x00000001/25331
>  [<c040195d>] schedule+0xa4d/0xa60
>  [<c0401b25>] wait_for_completion+0xc5/0xf0
>  [<c011a200>] default_wake_function+0x0/0x20
>  [<c0400cd3>] __down+0x83/0x110
>  [<c011a200>] default_wake_function+0x0/0x20
>  [<c0400eab>] __down_failed+0x7/0xc
>  [<c0141fe7>] .text.lock.cpuset+0x105/0x15e
>  [<c011b860>] move_task_off_dead_cpu+0x130/0x1f0
>  [<c011ba7c>] migrate_live_tasks+0x8c/0x90
>  [<c011be25>] migration_call+0x75/0x2c0
>  [<c01423f2>] __stop_machine_run+0x92/0xb0
>  [<c012e0dd>] notifier_call_chain+0x2d/0x50
>  [<c013a6fb>] cpu_down+0x16b/0x2a0
>  [<c027ddfb>] store_online+0x5b/0x80
>  [<c027ae15>] sysdev_store+0x35/0x40
>  [<c019f43e>] flush_write_buffer+0x3e/0x50
>  [<c019f4a8>] sysfs_write_file+0x58/0x80
>  [<c0163d26>] vfs_write+0xc6/0x180
>  [<c0163eb1>] sys_write+0x51/0x80
>  [<c01034e5>] syscall_call+0x7/0xb

This trace is what should be fixed -- we're trying to schedule while
the machine is "stopped" (all cpus except for one spinning with
interrupts off).  I'm not too familiar with the cpusets code but I
would like to stay away from nesting these semaphores if at all
possible.

Will you share your testcase please?


Nathan
