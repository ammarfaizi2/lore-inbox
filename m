Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbRE0RN1>; Sun, 27 May 2001 13:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262825AbRE0RNR>; Sun, 27 May 2001 13:13:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15136 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262823AbRE0RNB>; Sun, 27 May 2001 13:13:01 -0400
Date: Sun, 27 May 2001 19:12:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, arjanv@redhat.com
Subject: Re: [patch] softirq-2.4.5-A1
Message-ID: <20010527191249.I676@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain> <Pine.LNX.4.33.0105262128230.1222-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105262128230.1222-200000@localhost.localdomain>; from mingo@elte.hu on Sat, May 26, 2001 at 09:33:59PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 09:33:59PM +0200, Ingo Molnar wrote:
>    interrupts disabled, otherwise we can end up getting another softirq
>    right after the test. (and this causes a missed softirq.)

an irq that could mark the softirq active under entry.S will also run
do_softirq itself before iret to entry.S. If the softirq remains active
after an irq it it because it was marked active again under do_softirq
and ksoftirq is the way to go for fixing that case I think.

Andrea
