Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTEMUQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTEMUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:16:36 -0400
Received: from mcomail01.maxtor.com ([134.6.76.15]:33037 "EHLO
	mcomail01.maxtor.com") by vger.kernel.org with ESMTP
	id S262459AbTEMUQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:16:31 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D345@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>, Oleg Drokin <green@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: "'Jens Axboe'" <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.69, IDE TCQ can't be enabled
Date: Tue, 13 May 2003 14:28:29 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Bill Davidsen [mailto:davidsen@tmr.com]
Sent: Tuesday, May 13, 2003 2:05 PM
To: Oleg Drokin; Jeff Garzik; Mudama, Eric
Cc: 'Jens Axboe'; Alan Cox; Linux Kernel Mailing List
Subject: Re: 2.5.69, IDE TCQ can't be enabled

>On Mon, 12 May 2003, Mudama, Eric wrote:
>
>> TCQ shouldn't benefit writes significantly from a performance perspective
if
>> the drive is reasonably smart.  TCQ *will* have a huge performance
>> improvement for random reads since the drive can order responses based on
>> minimal rotational latency.
>> 
>> Increasing queue depth reduces the average seek time between commands,
both
>> in distance and rotational latency.  Provided a drive doesn't do dumb
stuff
>> like we discussed earlier, then it should be good.
>
>One problem which seems probable is that the drive knows less about the
>system than the o/s (I hope!) and therefore it can only optimize the order
>of i/o for most i/o in the shortest time. It would seem that the deadline
>scheduler benefits from doing not the quickest thing but the correct thing
>in terms of ordering. I believe that once the i/o is queued (assuming the
>drive works right) the drive makes the decision about i/o order. That may
>be the wrong thing to do under load, and starve some processes.

The general case we use is to optimize for maximum ops-per-second.  The
potential benefit from queueing is indicated by the delta between random
write performance (cached operations we can order for performance) versus
random read performance (cache misses we can't choose the order of).  In a
virtual drive with near-infinite queue depth, rotational latency completely
factors out so the you get equal ops/sec from a 7200 RPM drive as you do
from a 15K RPM drive.  That is what we are shooting for.

>There was discussion recently about limiting the requests with SCSI, for
>just this reason.
>
>Unless there's a *lot* of gain from doing TCQ, perhaps this should either
>wait, be dropped, or only be enabled for a whitelist of known actually
>functional drives. Seems like a poor risk to benefit ratio if it doesn't
>work just right, and perhaps this should go on the "it seemed like a good
>idea at the time" pile. There's nothing the code can do to guard against
>bad drive firmware except not use it.

I am working here to test usability with TCQ on our prototypes so I can
evaluate these sorts of queue depth issues and whether I think we're doing
the right stuff algorithmically in the drive.  Hopefully some of my effort
helps.

--eric
