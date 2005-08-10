Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVHJAkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVHJAkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVHJAkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:40:51 -0400
Received: from fmr22.intel.com ([143.183.121.14]:453 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751003AbVHJAkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:40:51 -0400
Date: Tue, 9 Aug 2005 17:40:42 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Darren Hart <dvhltc@us.ibm.com>, "lkml," <linux-kernel@vger.kernel.org>,
       "Piggin, Nick" <piggin@cyberone.com.au>,
       "Dobson, Matt" <colpatch@us.ibm.com>, nickpiggin@yahoo.com.au,
       mingo@elte.hu
Subject: Re: sched_domains SD_BALANCE_FORK and sched_balance_self
Message-ID: <20050809174042.C1938@unix-os.sc.intel.com>
References: <42F3F669.2080101@us.ibm.com> <20050809150331.A1938@unix-os.sc.intel.com> <1187700000.1123625998@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1187700000.1123625998@flay>; from mbligh@mbligh.org on Tue, Aug 09, 2005 at 03:19:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 03:19:58PM -0700, Martin J. Bligh wrote:
> --On Tuesday, August 09, 2005 15:03:32 -0700 "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> 
> > On Fri, Aug 05, 2005 at 04:29:45PM -0700, Darren Hart wrote:
> >> I have some concerns as to the intent vs.  actual implementation of 
> >> SD_BALANCE_FORK and the sched_balance_fork() routine.
> > 
> > Intent and implementation match. Problem is with the intent ;-)
> > 
> > This has the intent info.
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=147cbb4bbe991452698f0772d8292f22825710ba
> > 
> > To solve these issues, we need to make the sched domain and its parameters
> > CMP aware. And dynamically we need to adjust these parameters based
> > on the system properties.
> 
> Can you explain the purpose of doing balance on both fork and exec?
> The reason we did it at exec time is that it's much cheaper to do 
> than at fork - you have very, very little state to deal with. The vast 
> majority of things that fork will exec immediately thereafter.
> 
> Balance on clone make some sort of sense, since you know they're not
> going to exec afterwards. We've thrashed through this many times before
> and decided that unless there was an explicit hint from userspace,
> balance on fork was not a good thing to do in the general case. Not only
> based on a large range of testing, but also previous experience from other
> Unix's. What new data came forth to change this?

I agree with you. I will let Nick(the author) have a take at this.

> > We can choose the leastly loaded CPU in the home node and we can let the
> > load balance to move it to other nodes if there is an imbalance.
> 
> Is that what it's actually doing now? That's not what Nick told me at
> Kernel Summit, but is the correct thing to do for clone, I think.

We don't do it today. But I would like to see that.

thanks,
suresh
