Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262822AbRE0RS7>; Sun, 27 May 2001 13:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262825AbRE0RSt>; Sun, 27 May 2001 13:18:49 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25376 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262822AbRE0RSe>; Sun, 27 May 2001 13:18:34 -0400
Date: Sun, 27 May 2001 19:18:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
Message-ID: <20010527191822.J676@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain> <15120.16986.610478.279574@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15120.16986.610478.279574@pizda.ninka.net>; from davem@redhat.com on Sat, May 26, 2001 at 04:55:06PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 04:55:06PM -0700, David S. Miller wrote:
> And looking at the x86 code, I don't even understand how your fixes
> can make a difference, what about the do_softirq() call in
> arch/i386/kernel/irq.c:do_IRQ()???  That should be taking care of all
> these "error cases" right?

Yes, except when a softirq is marked running again under do_sofitrq (it
is mostly an issue when the machine is otherwise idle that means we
will waste cpu if we don't run the sofitrq immediatly, this problem was
noticed by Manfred last month, but that is just a special case of the
generic case of a softirq marked running again under do_softirq), and
all those cases are supposed to be taken care by ksoftirqd.

Andrea
