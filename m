Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWFZNDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWFZNDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWFZNDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:03:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:34520 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932235AbWFZNDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:03:36 -0400
To: "" <matthltc@us.ibm.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Peter Williams" <pwil3058@bigpond.net.au>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Jes Sorensen" <jes@sgi.com>,
       "LSE-Tech" <lse-tech@lists.sourceforge.net>, "" <sekharan@us.ibm.com>,
       "Alan Stern" <stern@rowland.harvard.edu>,
       "Balbir Singh" <balbir@in.ibm.com>,
       "Shailabh Nagar" <nagar@watson.ibm.com>
Subject: Re: [PATCH] Per-task watchers: Enable inheritance
X-US-Snail: Rational Software, IBM Software Group, 20 Maguire Road, Lexington, MA  02421-3112
References: <1150879635.21787.964.camel@stark>
	<6c4pybmv19.fsf@sumu.lexma.ibm.com>
	<1151105584.21787.1571.camel@stark>
From: jtk@us.ibm.com (John T. Kohl)
Date: 26 Jun 2006 09:03:23 -0400
In-Reply-To: <1151105584.21787.1571.camel@stark>
Message-ID: <6clkrk3w84.fsf@sumu.lexma.ibm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matt" ==   <matthltc@us.ibm.com> writes:

Matt> On Fri, 2006-06-23 at 17:17 -0400, John T. Kohl wrote:
>> >>>>> "MattH" ==   <matthltc@us.ibm.com> writes:
>> 
MattH> This allows per-task watchers to implement inheritance of the
MattH> same function and/or data in response to the initialization of
MattH> new tasks. A watcher might implement inheritance using the
MattH> following notifier_call snippet:
>> 
>> I think this would meet our needs--we (MVFS) need to initialize some new
>> state in a child process based on our state in the parent process
>> (essentially, module-private inherited per-process state).  It may still
>> be a bit clumsy to find the per-process state in other situations,
>> though.  While a process is executing our module's code, would it be
>> safe to traverse current's notifier chain to find our state?

Matt> 	Hmm. We may need to be careful with terminology here. Keep in mind that
Matt> a task is not the same as the userspace concept of a  "process".

Right, sorry, I was imprecise in my wording.  What MVFS wants is per-task
private state and state inheritance on task forks.

Matt> 	When a task is executing a module's code it will be safe to traverse
Matt> the task's notifier chain to find state. It will *not* be safe to
Matt> traverse the notifier chain of other tasks -- even if the other task is
Matt> a thread in the same "process".

I'm curious to see Peter's prototype code (mentioned in his reply).  I
worry that to get safe access to the parent task's private state during
fork, we'll need something like a private hash table for our private
per-task state.  Ideally we'd like to just be able to find stuff hanging
off the task structure directly.

-- 
John Kohl
Senior Software Engineer - Rational Software - IBM Software Group
Lexington, Massachusetts, USA
jtk@us.ibm.com
<http://www.ibm.com/software/rational/>
