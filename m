Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752174AbWFWXj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbWFWXj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 19:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbWFWXj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 19:39:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:8070 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752174AbWFWXj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 19:39:57 -0400
Subject: Re: [PATCH] Per-task watchers: Enable inheritance
From: Matt Helsley <matthltc@us.ibm.com>
To: "John T. Kohl" <jtk@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
In-Reply-To: <6c4pybmv19.fsf@sumu.lexma.ibm.com>
References: <1150879635.21787.964.camel@stark>
	 <6c4pybmv19.fsf@sumu.lexma.ibm.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 16:33:04 -0700
Message-Id: <1151105584.21787.1571.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 17:17 -0400, John T. Kohl wrote:
> >>>>> "MattH" ==   <matthltc@us.ibm.com> writes:
> 
> MattH> This allows per-task watchers to implement inheritance of the
> MattH> same function and/or data in response to the initialization of
> MattH> new tasks. A watcher might implement inheritance using the
> MattH> following notifier_call snippet:
> 
> I think this would meet our needs--we (MVFS) need to initialize some new
> state in a child process based on our state in the parent process
> (essentially, module-private inherited per-process state).  It may still
> be a bit clumsy to find the per-process state in other situations,
> though.  While a process is executing our module's code, would it be
> safe to traverse current's notifier chain to find our state?

	Hmm. We may need to be careful with terminology here. Keep in mind that
a task is not the same as the userspace concept of a  "process".

	When a task is executing a module's code it will be safe to traverse
the task's notifier chain to find state. It will *not* be safe to
traverse the notifier chain of other tasks -- even if the other task is
a thread in the same "process".

Cheers,
	-Matt Helsley

