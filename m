Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130230AbRAQNE3>; Wed, 17 Jan 2001 08:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130406AbRAQNET>; Wed, 17 Jan 2001 08:04:19 -0500
Received: from web5205.mail.yahoo.com ([216.115.106.86]:35338 "HELO
	web5205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130230AbRAQNER>; Wed, 17 Jan 2001 08:04:17 -0500
Message-ID: <20010117130415.9423.qmail@web5205.mail.yahoo.com>
Date: Wed, 17 Jan 2001 05:04:15 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: qlogicfc.c hard lockups in 2.4.0 - solved?
To: Chris Loveland <chris.loveland@trebia.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the hangs were actually CAUSED by the messages
being printked.  If I make those go away, it stops
getting unhappy.  (I suspect repeatedly printk-ing
stuff from the middle of the scsi layer with
interrupts disabled and other fun stuff occuring is
not a good thing.  Delays something or other long
enough to trigger a watchdog timer and make the system
go bye-bye.)

Increasing the handle array thingy to 511 seems to
have made the problem go away for me almost entirely. 
(Still periodic slight bus stalls from overrunning the
scsi command queue (the test right before the "should
never happen" test), but it recovers pretty quickly.)

Throughput's a little over 160 million bytes per
second on both writes and reads.  That's about 20
million per second below the maximums (due to the
stalls), but that's survivable at the moment...

Close enough I can go home and get some sleep, anyway.

Unresolved issues:

That handle thingy should probably dynamically scale
somehow.  (Maybe the "out of handles" behavior could
resize the array to the next 2^x-1 bump?  I can try to
whip up a patch to this effect if nobody thinks this
is too crazy.)

Bus stalls take to long to recover from, slowing
throughput.  (Pure scsi-ness, I may investigate later
but haven't a CLUE on this right now.  I'm guessing.)

Rob

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
