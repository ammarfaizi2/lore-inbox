Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVFHTEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVFHTEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFHTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:04:44 -0400
Received: from fmr22.intel.com ([143.183.121.14]:18357 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261546AbVFHTE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:04:29 -0400
Date: Wed, 8 Jun 2005 12:03:26 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: lk <linux_kernel@patni.com>
Cc: helen monte <hzmonte@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How does 2.6 SMP scheduler initially assign a thread to a run queue?
Message-ID: <20050608120325.A5554@unix-os.sc.intel.com>
References: <BAY102-F24530D3EE13EBCA2B13336A0FA0@phx.gbl> <000e01c56c27$765c4510$5e91a8c0@patni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000e01c56c27$765c4510$5e91a8c0@patni.com>; from linux_kernel@patni.com on Wed, Jun 08, 2005 at 06:11:55PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 06:11:55PM +0530, lk wrote:
> > In the 2.6 kernel, there is one run queue per CPU, in case of an SMP.
> > After a thread is created, how does the scheduler determine which run
> > queue it goes to?  
> 
> First it forked process (child) gets the same CPU as that of parent.
> forking a child gets the same CPU and later part of fork will call 
> wake_up_new_task () to fetch the run-queue of the CPU and 
> __activate_task () is called to move task into run-queue. 
> Later rescheduling of the process may move process to another
> run-queues.

In -mm kernels, Nick has recently added balance on exec/fork.

> > By the way, in an SMT/hyperthreading processor, does the latest kernel
> > version assign one run queue per physical CPU, or per virtual 
> > processor?
> > 
> 
> one run-queue per physical CPU

No. Each logical processor has its own runqueue.

thanks,
suresh
