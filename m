Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318124AbSIAVx6>; Sun, 1 Sep 2002 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSIAVx6>; Sun, 1 Sep 2002 17:53:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27919 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318124AbSIAVxx>;
	Sun, 1 Sep 2002 17:53:53 -0400
Message-ID: <3D729020.4DFDAC2B@zip.com.au>
Date: Sun, 01 Sep 2002 15:09:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
References: <3D644C70.6D100EA5@zip.com.au> <E17lEDR-0004Qq-00@starship> <3D712682.66E2D3B2@zip.com.au> <20020901212943Z16578-4014+1360@humbolt.nl.linux.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> I'm looking at your spinlock_irq now and thinking the _irq part could
> possibly be avoided.  Can you please remind me of the motivation for this -
> was it originally intended to address the same race we've been working on
> here?
> 

scalability, mainly.  If the CPU holding the lock takes an interrupt,
all the other CPUs get to spin until the handler completes.  I measured
a 30% reducton in contention from this.

Not a generally justifiable trick, but this is a heavily-used lock.
All the new games in refill_inactive() are there to minimise the
interrupt-off time.
