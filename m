Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272942AbRINEPh>; Fri, 14 Sep 2001 00:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273277AbRINEP3>; Fri, 14 Sep 2001 00:15:29 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29077 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272942AbRINEPR>; Fri, 14 Sep 2001 00:15:17 -0400
Date: Thu, 13 Sep 2001 21:14:31 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: shreenivasa H V <shreenihv@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler policy
Message-ID: <20010913211431.A1021@w-mikek2.sequent.com>
In-Reply-To: <20010914022756.9487.qmail@nwcst280.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010914022756.9487.qmail@nwcst280.netaddress.usa.net>; from shreenihv@usa.net on Thu, Sep 13, 2001 at 09:27:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 09:27:56PM -0500, shreenivasa H V wrote:
> Hi,
> 
> In process scheduling, when an epoch ends because of the current process
> completing its time quantum (and all the runnable ones having finished their
> respective quantums), at the start of the new epoch, will the current running
> process retain the cpu (assuming all the runnable ones are of the same
> priority)?

Short answer, for UP kernels yes.

If all the tasks on the runqueue have the same priority (nice value),
then they will all (almost) have the same goodness value at the start
of the new epoch.  However, tasks with the same memory map as the
currently running task will get their goodness value boosted by 1.
The next task to run will be the first one found that has the same
memory map as the currently running task.  The check for 'still_running'
ensures that the the currently running task will be found first.

Not sure if this is by design, but this is what the code does.

Also, note that this is only true for UP kernels.  In SMP, there
are other factors to consider and a level of unpredictability
due to racing with other CPUs as a result of dropping the runqueue
lock during the 'recalculate' operation.

-- 
Mike Kravetz                                  kravetz@us.ibm.com
IBM Linux Technology Center       (we're not at Sequent anymore)
