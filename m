Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSENPZR>; Tue, 14 May 2002 11:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315780AbSENPZQ>; Tue, 14 May 2002 11:25:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17158 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313537AbSENPZQ>; Tue, 14 May 2002 11:25:16 -0400
Subject: Re: [PATCH] 2.5.15 IDE 61
To: nconway.list@ukaea.org.uk (Neil Conway)
Date: Tue, 14 May 2002 15:45:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rmk@arm.linux.org.uk (Russell King),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CE10B2B.822CA194@ukaea.org.uk> from "Neil Conway" at May 14, 2002 02:03:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177dYp-00083c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you're wrong Alan.  Take a good IDE chipset as an example: both
> channels can be active at the same time, but you still can't talk to one
> drive while the other drive on the same channel is DMAing.

Sure.

> I'm not a block layer expert, but it appears to me that the block layer
> only synchronises requests by use of the spinlock.  If I'm right, then
> the block layer has no way of knowing that hda is DMAing when a request
> is initiated for hdb.  This was the whole reason (as I see it) that
> hwgroup->busy existed: to prevent attempts to use the same IDE cable for
> two things at the same time.

The newer block code has queues. Its up to the block layer to deal with
the queue locking.

> It doesn't matter how you perform the queue abstraction in this case:
> the fact that the device+channel+cable is busy in an asynchronous manner
> makes it impossible for the block layer to deal with this.  [[Or am I
> way off base?!]]

I think you are way off base. If you have a single queue for both hda and
hdb then requests will get dumped into that in a way that processing that
queue implicitly does the ordering you require.

>From an abstract hardware point of view each ide controller is a queue not
each device. Not following that is I think the cause of much of the existing
pain and suffering.

Alan
