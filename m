Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276975AbRJCUlr>; Wed, 3 Oct 2001 16:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276977AbRJCUli>; Wed, 3 Oct 2001 16:41:38 -0400
Received: from 208.185.65.51.tvworldwide.com ([208.185.65.51]:10645 "EHLO
	srv1.ecropolis.com") by vger.kernel.org with ESMTP
	id <S276975AbRJCUl2>; Wed, 3 Oct 2001 16:41:28 -0400
Date: Wed, 3 Oct 2001 16:41:56 -0400 (EDT)
From: Jeremy Hansen <jeremy@iamdrugfree.org>
X-X-Sender: <jeremy@srv1.ecropolis.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <9pfkd6$9p5$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110031641190.28381-100000@srv1.ecropolis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I better go check my pants...

Thanks
-jeremy

On Wed, 3 Oct 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.33.0110031920410.9973-100000@localhost.localdomain>,
> Ingo Molnar  <mingo@elte.hu> wrote:
> >
> >well, just tested my RAID testsystem as well. I have not tested heavy
> >IO-related IRQ load with the patch before (so it was not tuned for that
> >test in any way), but did so now: an IO test running on 12 disks, (5 IO
> >interfaces: 3 SCSI cards and 2 IDE interfaces) producing 150 MB/sec block
> >IO load and a fair number of SCSI and IDE interrupts, did not trigger the
> >overload code.
> 
> Now test it again with the disk interrupt being shared with the network
> card.
> 
> Doesn't happen? It sure does. It happens more often especially on
> slightly lower-end machines (on laptops it's downright disgusting how
> often _every_ single PCI device ends up sharing the same interrupt).
> 
> And as the lower-end machines are the ones that probably can be forced
> to trigger the whole thing more often, this is a real issue.
> 
> And on my "high-end" machine, I actually have USB and ethernet on the
> same interrupt.  It would be kind of nasty if heavy network traffic
> makes my camera stop working... 
> 
> The fact is, there is never any good reason for limiting "trusted"
> interrupts, ie anything that is internal to the box.  Things like disks,
> graphics controllers etc. 
> 
> Which is why I like the NAPI approach.  If somebody overloads my network
> card, my USB camera doesn't stop working. 
> 
> I don't disagree with your patch as a last resort when all else fails,
> but I _do_ disagree with it as a network load limiter.
> 
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
The trouble with being poor is that it takes up all your time.

