Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281200AbRKLBM1>; Sun, 11 Nov 2001 20:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281201AbRKLBMR>; Sun, 11 Nov 2001 20:12:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:42303 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281200AbRKLBL7>; Sun, 11 Nov 2001 20:11:59 -0500
Date: Mon, 12 Nov 2001 02:11:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mathijs Mohlmann <mathijs@knoware.nl>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011112021142.O1381@athlon.random>
In-Reply-To: <20011110122141.B2C68231A4@brand.mmohlmann.demon.nl> <20011110.053720.55510115.davem@redhat.com> <20011110160301.B1381@athlon.random> <20011110152845.8328F231A4@brand.mmohlmann.demon.nl> <20011110173751.C1381@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011110173751.C1381@athlon.random>; from andrea@suse.de on Sat, Nov 10, 2001 at 05:37:51PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just guessing: the scheduler isn't yet functional when
spawn_ksoftirqd is called. This is clearly a sparc32 bug, because
swapn_ksoftirqd is called via the __initcall section and the scheduler
must be fully functional by that time.  Unrelated to the fact ksoftirqd
can loop on disabled tasklets, the ksoftirqd startup is only an innocent
trigger for the deadlock.

Mathijs, can you verify that? If my theory is right need_resched isn't
set even if ksoftirqd loops forever. It could be one of those two
possibilities:

1) the timer irq isn't running yet
2) "current" isn't functional

The softirq code shouldn't really be the culprit of the sparc32
deadlock (as Alexey pointed out).

Andrea
