Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130767AbQLULGZ>; Thu, 21 Dec 2000 06:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130891AbQLULGO>; Thu, 21 Dec 2000 06:06:14 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:16343 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130767AbQLULGH>; Thu, 21 Dec 2000 06:06:07 -0500
Message-ID: <3A41DDB3.7E38AC7@uow.edu.au>
Date: Thu, 21 Dec 2000 21:38:43 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>, <E147MkJ-00036t-00@the-village.bc.nu>; <20001220142858.A7381@athlon.random> <3A40C8CB.D063E337@uow.edu.au>,
		<3A40C8CB.D063E337@uow.edu.au>; from andrewm@uow.edu.au on Thu, Dec 21, 2000 at 01:57:15AM +1100 <20001220162456.G7381@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> The fact you could mix non-exclusive and exlusive wakeups in the same waitqueue
> was a feature not a misfeature. Then of course you cannot register in two
> waitqueues one with wake-one and one with wake-all but who does that anyways?
> Definitely not an issue for 2.2.x.

Definitely?  Let's think about that.

> I think the real reason for spearating the two things as davem proposed is
> because otherwise we cannot register for a LIFO wake-one in O(1) as we needed
> for accept.

Yes.  In other words, if we try to do O(1) LIFO, we can cause lost wakeups.

> Other thing about your patch, adding TASK_EXCLUSIVE to
> wake_up/wake_up_interruptible is useless.

This enables wake_up_all().



Anyway, this is all just noise.

The key question is: which of the following do we want?

a) A simple, specific accept()-accelerator, and 2.2 remains without
   an exclusive wq API or

b) A general purpose exclusive wq mechanism which does not correctly
   support waiting on two queues simultaneuously where one is
   exclusive or

c) A general purpose exclusive wq mechanism which _does_ support it.

Each choice has merit!  You seem to want b).  davem wants c).

And given that 2.2 has maybe 2-4 years life left in it, I'd
agree with David.  Let's do it once and do it right while the issue
is fresh in our minds.

Yes?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
