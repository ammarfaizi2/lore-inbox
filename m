Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275175AbRJJKAk>; Wed, 10 Oct 2001 06:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275183AbRJJKAa>; Wed, 10 Oct 2001 06:00:30 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43663 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275175AbRJJKA0>; Wed, 10 Oct 2001 06:00:26 -0400
Date: Wed, 10 Oct 2001 15:36:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010153613.A17580@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <Pine.LNX.4.33.0110100230170.1518-100000@penguin.transmeta.com> Linus Torvalds wrote:

> On Wed, 10 Oct 2001, Rusty Russell wrote:
>>
>> If noone *holds* a reference, you can remove it "sometime later",
>> where "sometime later" is (for example) after every CPU has scheduled.

> Ehh.. One of those readers can hold on to the thing while waiting for
> something else to happen.

> Looking up a data structure and copying it to user space or similar is
> _the_ most common operation for any lookup. You MUST NOT free it just
> because we scheduled away. Scheduling points have zero meaning in real
> life.

How does locking inside the kernel help you here ? You could face 
the same situation even if you protect the data by locking. 
Perhaps, I am missing something here. So, a specific example would help.


> So you'll need a reference count to actually keep such a data structure
> alive _over_ a schedule. Or all the readers need to copy the data too
> before they actually start using it. At which point you've made your code
> a _lot_ slower than the locking version.

Only relevant issue I can see here is preemption - if you hold
a reference and get preempted out it is still a context switch
and the logic of "when the data can be really deleted" must take
into account such context switches. Alternatively, you could
disable preemption while traversing such lists.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
