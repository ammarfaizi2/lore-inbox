Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbVJZXUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbVJZXUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 19:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbVJZXUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 19:20:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50602 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751510AbVJZXUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 19:20:22 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Keith Owens <kaos@ocs.com.au>,
       dipankar@in.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200510262344.37982.ak@suse.de>
References: <Pine.LNX.4.44L0.0510261636580.7186-100000@iolanthe.rowland.org>
	 <200510262344.37982.ak@suse.de>
Content-Type: text/plain
Organization: IBM
Date: Wed, 26 Oct 2005 16:20:20 -0700
Message-Id: <1130368820.3586.213.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 23:44 +0200, Andi Kleen wrote:
> On Wednesday 26 October 2005 22:40, Alan Stern wrote:
> l> On Wed, 26 Oct 2005, Andreas Kleen wrote:
> > 
> > > > Note that the RCU documentation says RCU critical sections are not
> > > > allowed
> > > > to sleep.
> > > 
> > > In this case it would be ok.
> > 
> > I don't understand.  If it's okay for an RCU critical section to sleep in 
> > this case, why wouldn't it be okay always?  What's special here?
> > 
> > Aren't there requirements about critical sections finishing on the same 
> > CPU as they started on?
> 
> 
> Like I wrote earlier: as long as the notifier doesn't unregister itself
> the critical RCU section for the list walk is only a small part of notifier_call_chain.
> It's basically a stable anchor in the list that won't change.

Andy, comment above rcu_read_lock says, "It is illegal to block while in
an RCU read-side critical section."

As i mentioned in the other email we are discussing about "task
notifier" in lse-tech. We thought of using RCU, but one of the
requirements was that the registered function should be able to block,
so we are looking for alternatives.

> 
> The only change needed would be to make these parts unpreemptable and of course
> add a RCU step during unregistration.
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


