Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWCACS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWCACS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWCACS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:18:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10986 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964818AbWCACS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:18:56 -0500
Date: Tue, 28 Feb 2006 18:18:49 -0800
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060228181849.faaf234e.pj@sgi.com>
In-Reply-To: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - the following should address your concerns in patch:

  proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch

where you had to include "../fs/proc/internal.h" in kernel/cpuset.c

Eric wrote (off list in a patch to Andrew, apparently):
> I just refactored fs/proc/base.c to use task_refs to ensure there are not
> long user triggerable hold times of task_struct.  It looks like I missed
> cpuset.c.  Oops.
> 
> This patch updates proc_cpuset_show to handle the task dying between when
> the file is opened and when data is read out.

Thanks for catching this, Eric.

I was just about to send a patch that moved the cpuset_open(),
cpuset_release() and proc_cpuset_operations{} code from kernel
cpuset.c to fs/proc/base.c, leaving behind a now publically
exported proc_cpuset_show() routine that handles the cpuset
specific details.

For lurkers, this is the code that prints a tasks cpuset path
in the file /proc/<pid>/cpuset.  That code had some proc file
specific details buried in its kernel/cpuset.c implementation,
and Eric is changing those proc details.  Proc stuff should go
in proc/fs and cpuset stuff in kernel/cpuset.c

I will remerge with your fixes to handle possibly null task_refs
correctly and try again to send my above patch.

However, I have some debugging to do on this kernel first.

It blows up on boot (ia64 sn2_defconfig).

I haven't started to analyze it any yet.  I don't know if it's a bug
or pilot error yet.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
