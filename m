Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136202AbREAUdd>; Tue, 1 May 2001 16:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136712AbREAUdX>; Tue, 1 May 2001 16:33:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43019 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136202AbREAUdR>; Tue, 1 May 2001 16:33:17 -0400
Subject: Re: 2.4.4 sluggish under fork load
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 1 May 2001 21:34:55 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel),
        peter.osterlund@mailbox.swipnet.se (Peter Osterlund),
        torvalds@transmeta.com (Linus Torvalds),
        hahn@coffee.psychology.mcmaster.ca (Mark Hahn),
        adam@yggdrasil.com (Adam J. Richter), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010501185517.A31373@athlon.random> from "Andrea Arcangeli" at May 01, 2001 06:55:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ugrK-0002J9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK I found the explanation now. The reason ksoftirqd was deadlocking on
> me without the explicit clear of SCHED_YIELD in p->policy is because a
> softirq event was pending at the time of the first kernel_thread() and
> then while returning from the syscall it was so taking the ret_from_irq

Oh boy. 

> > +		current->policy |= SCHED_YIELD;
> > +		current->need_resched = 1;
> > +	}
> 
> Alan, the patch you merged in 2.4.4ac2 can fail like mine, but it may fail in
> a much more subtle way, while I notice if ksoftirqd never get scheduled
> because I synchronize on it and I deadlock, your kupdate/bdflush/kswapd
> may be forked off correctly but they can all have SCHED_YIELD set and
> they will *never* get scheduled. You know what can happen if kupdate
> never gets scheduled... I recommend to be careful with 2.4.4ac2.

Change merged for -ac3. Nice debugging

