Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbRG1SCd>; Sat, 28 Jul 2001 14:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbRG1SCY>; Sat, 28 Jul 2001 14:02:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28508 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266982AbRG1SCP>; Sat, 28 Jul 2001 14:02:15 -0400
Date: Sat, 28 Jul 2001 20:02:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Maksim Krasnyanskiy <maxk@qualcomm.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, mingo@redhat.com,
        Dave Miller <davem@redhat.com>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
Message-ID: <20010728200257.E12090@athlon.random>
In-Reply-To: <4.3.1.0.20010727141716.05651ac0@mail1> <200107281741.VAA12995@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107281741.VAA12995@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Jul 28, 2001 at 09:41:41PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 09:41:41PM +0400, kuznet@ms2.inr.ac.ru wrote:
> > -               cpu_raise_softirq(cpu, TASKLET_SOFTIRQ); <<<<
> > -               tasklet_unlock(t);
> > -       }
> > -       local_irq_restore(flags);			   <<<<
> 
> But Andrea has just tought me that this is invalid to call cpu_raise_softirq
> in such context. No differences of netif_rx() here, all the issues are
> the same.

cpu_raise_softirq is valid in any context. calling cpu_raise_softirq
there was correct (__cpu_raise_softirq would been too weak).

For performance reasons we should instead __cpu_raise_sofirq (instead of
cpu_raise_softirq) in tasklet_action that runs within do_softirq but
that is a minor optimization.

> I am afraid, when do not feel ground. After your analysis even direction to
> ground is lost. :-)

:) As far I can see returning to the correct 2.4.5 tasklet logic will
fix the tasklet problem (only tasklets had a problem in 2.4.7).

Andrea
