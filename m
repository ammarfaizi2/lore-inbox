Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268902AbRG0RCK>; Fri, 27 Jul 2001 13:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbRG0RB7>; Fri, 27 Jul 2001 13:01:59 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:56328 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267943AbRG0RBz>;
	Fri, 27 Jul 2001 13:01:55 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107271701.VAA19367@ms2.inr.ac.ru>
Subject: Re: 2.4.7 softirq incorrectness.
To: davem@redhat.com (David S. Miller)
Date: Fri, 27 Jul 2001 21:01:48 +0400 (MSK DST)
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <15201.13760.734675.989919@pizda.ninka.net> from "David S. Miller" at Jul 27, 1 02:34:56 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Do you mean "user context" when you say normal? 

Why "user" then? :-)

Well, after some digging in brains I find that I use home-made terminology.
non-interrupt/non-bh context is called "process context" here. :-)
"Normal context" is process context with enabled BHs and irqs.


> The reason I pushed to have netif_FOO use __cpu_raise_softirq() was
> that I felt sick to my stomache when I saw a new whole function call
> added to that spot. 

I experience even more unpleasant feelings, when thinking what would happen
if netif_rx() without these __ is called from under irq protected spinlock.

> Let us just fix the odd places that aren't calling things in the
> correct environment.

I caught you! :-) Each "context" is normal, but "environment" still can
be wrong. 

Yes, I agreed. It is the simplest solution. In any case, all the instances
of netif_rx are to be checked for spinlock-safeness.

Alexey
