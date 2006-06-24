Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933167AbWFXAIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167AbWFXAIp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933165AbWFXAIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:08:45 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:26617 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S933164AbWFXAIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:08:44 -0400
Message-ID: <449C828A.2090705@bigpond.net.au>
Date: Sat, 24 Jun 2006 10:08:42 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: "John T. Kohl" <jtk@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH] Per-task watchers: Enable inheritance
References: <1150879635.21787.964.camel@stark>	 <6c4pybmv19.fsf@sumu.lexma.ibm.com> <1151105584.21787.1571.camel@stark>
In-Reply-To: <1151105584.21787.1571.camel@stark>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 24 Jun 2006 00:08:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Fri, 2006-06-23 at 17:17 -0400, John T. Kohl wrote:
>>>>>>> "MattH" ==   <matthltc@us.ibm.com> writes:
>> MattH> This allows per-task watchers to implement inheritance of the
>> MattH> same function and/or data in response to the initialization of
>> MattH> new tasks. A watcher might implement inheritance using the
>> MattH> following notifier_call snippet:
>>
>> I think this would meet our needs--we (MVFS) need to initialize some new
>> state in a child process based on our state in the parent process
>> (essentially, module-private inherited per-process state).  It may still
>> be a bit clumsy to find the per-process state in other situations,
>> though.  While a process is executing our module's code, would it be
>> safe to traverse current's notifier chain to find our state?
> 
> 	Hmm. We may need to be careful with terminology here. Keep in mind that
> a task is not the same as the userspace concept of a  "process".
> 
> 	When a task is executing a module's code it will be safe to traverse
> the task's notifier chain to find state. It will *not* be safe to
> traverse the notifier chain of other tasks -- even if the other task is
> a thread in the same "process".

Yes, the client has to make its own arrangements for protecting this 
type of thing.

The "per process CPU caps" code that I'm working on using task watchers 
has to address these issues and indications (so far) are that they're 
solvable.  I should be in a position to post that code early next week 
and, hopefully, that will give some insight into what can be achieved 
with this type of mechanism.  What I've done might not be the best way 
to solve the issues involved but it should provide a starting point for 
discussion :-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
