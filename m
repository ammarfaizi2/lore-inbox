Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVIVIdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVIVIdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVIVIdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:33:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:38107 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751448AbVIVIc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:32:59 -0400
Date: Thu, 22 Sep 2005 14:02:49 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, anderson@redhat.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO to kernel core dumps
Message-ID: <20050922083249.GD3753@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050921065633.GC3780@in.ibm.com> <m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com> <20050922073914.GA3753@in.ibm.com> <20050922004648.07a4147f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922004648.07a4147f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 12:46:48AM -0700, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > > - Why do you avoid storing the current task on the other cpus?
> >  > 
> >  > - Can't we derive the current task from the existing register information
> >  >   already captured.  
> > 
> >  It can be done but as Dave suggested but that requires significant amount 
> >  of job to be done as one has to traverse through the active task stacks and
> >  look for crash_kexec(). An easier/simpler way is that kernel itself can 
> >  report it.  Netdump, diskdump already do it. I think for simplicity, it 
> >  makes sense to export this information from kernel in the form of note.
> > 
> >  Only issue I could think of is stack overflow and current might be 
> >  corrupted after panic.
> > 
> 
> Yes, traversing the task_structs in a crashed kernel sounds like a poor
> idea.
> 

Andrew, traversal of task_structs will not be done in crashed kernel. It
will be done in user space by "crash" (if required, during post crash analysis).

In this case we are simply copying "current" pointer of panicking task in 
an elf note.

	kdumpinfo.panic_tsk = current;

Thanks
Vivek
