Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276935AbRJCSMS>; Wed, 3 Oct 2001 14:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276936AbRJCSMI>; Wed, 3 Oct 2001 14:12:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276935AbRJCSL5>; Wed, 3 Oct 2001 14:11:57 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Date: Wed, 3 Oct 2001 18:11:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9pfkd6$9p5$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110030920500.9427-100000@penguin.transmeta.com> <Pine.LNX.4.33.0110031920410.9973-100000@localhost.localdomain>
X-Trace: palladium.transmeta.com 1002132717 19792 127.0.0.1 (3 Oct 2001 18:11:57 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 3 Oct 2001 18:11:57 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110031920410.9973-100000@localhost.localdomain>,
Ingo Molnar  <mingo@elte.hu> wrote:
>
>well, just tested my RAID testsystem as well. I have not tested heavy
>IO-related IRQ load with the patch before (so it was not tuned for that
>test in any way), but did so now: an IO test running on 12 disks, (5 IO
>interfaces: 3 SCSI cards and 2 IDE interfaces) producing 150 MB/sec block
>IO load and a fair number of SCSI and IDE interrupts, did not trigger the
>overload code.

Now test it again with the disk interrupt being shared with the network
card.

Doesn't happen? It sure does. It happens more often especially on
slightly lower-end machines (on laptops it's downright disgusting how
often _every_ single PCI device ends up sharing the same interrupt).

And as the lower-end machines are the ones that probably can be forced
to trigger the whole thing more often, this is a real issue.

And on my "high-end" machine, I actually have USB and ethernet on the
same interrupt.  It would be kind of nasty if heavy network traffic
makes my camera stop working... 

The fact is, there is never any good reason for limiting "trusted"
interrupts, ie anything that is internal to the box.  Things like disks,
graphics controllers etc. 

Which is why I like the NAPI approach.  If somebody overloads my network
card, my USB camera doesn't stop working. 

I don't disagree with your patch as a last resort when all else fails,
but I _do_ disagree with it as a network load limiter.

			Linus
