Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313919AbSDJWv4>; Wed, 10 Apr 2002 18:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313922AbSDJWvz>; Wed, 10 Apr 2002 18:51:55 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:26873 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S313919AbSDJWvx>; Wed, 10 Apr 2002 18:51:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: Urban Widmark <urban@teststation.com>
Subject: Re: Via-Rhine stalls - transmit errors
Date: Wed, 10 Apr 2002 16:46:07 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0204101809010.7762-100000@cola.teststation.com>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02041016460700.28352@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Which frame-1 fix?

This one -> I reduced the frame by one for correct debug mssg.
Not important - I just happened to mention it.

 /*CHANGE*/
  if (debug > 4) { printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot 
%d.\n", dev->name, np->cur_tx-1, entry); }

This was included in this message:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.0/0722.html

You must not have read that one.
it contains lots of stuff about small changes in the code
and also link related issues.


> The addr points to the data to transmit. The next_desc simply makes the
> entries form a ring. I think you can assume that they are ok. But
> otherwise check what is written in via_rhine_start_tx.

I'll assume those are fine - they seem to form a ring.

> It is intentional that one interrupt can remove more than one used buffer.
> via_rhine_tx has a loop that tries to clean up all "dirty" tx descriptors.
> I think that one is ok.
>
> I wonder about the one that removes zero. Why that interrupt happened.
> Maybe it just happened while the previous interrupt was being handled.

Ok, this is actually my fault. i misinterpreted the logs
since I made them too complicated - they precede the interrupt instead of 
follow. That means you were not seing 2 bits removed, then 0, but 
1 bit removed - normal interrupt, then 2 bits removed with 1 interrupt.
So the second case is not an issue.
However, you say that 2 bits with 1 interrupt is fine...
The logs show all timeouts occur after 1 interrupt clears 2 ownership bits,
transmit stops and the queue fills up. What could possibly be causing this?

> You don't print cur_tx and dirty_tx, but the slots they point to are
> strange. You should check what they point to after the tx_timeout routine
> has completed, they should both be 0 by then.

strange? why?
cur_tx points to the next free slot without ownership bit
dirty_tx points to the first slot with ownership bit set 
I checked both after timeout, they point to 0.

/-----------------------/
I'll provide whatever other logs are necessary.
However, I am not sure what to look for.
Additionally, my version of the driver has some stuff that's not in the 
kernel driver. That's why I had listed it all in a previous message
(see link above) to see what to keep and what to get rid of
and then be able to debug an identical driver to the kernel.

Particularly the abort code from the linuxfet driver
seems to make my card stall a lot less or not at all
when transfer is initiated from the same computer.
The logs I generated last message showed a transfer
initiated from the opposite end.




