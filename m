Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRE0TQR>; Sun, 27 May 2001 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbRE0TQH>; Sun, 27 May 2001 15:16:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43914 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261561AbRE0TPy>;
	Sun, 27 May 2001 15:15:54 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15121.21054.657593.830199@pizda.ninka.net>
Date: Sun, 27 May 2001 12:15:10 -0700 (PDT)
To: <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] softirq-2.4.5-B0
In-Reply-To: <Pine.LNX.4.33.0105271020310.1667-200000@localhost.localdomain>
In-Reply-To: <15120.16986.610478.279574@pizda.ninka.net>
	<Pine.LNX.4.33.0105271020310.1667-200000@localhost.localdomain>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar writes:
 > the bug/misbehavior causing bad latencies turned out to be the following:
 > if a hardirq triggers a softirq, but syscall-level code on the same CPU
 > disabled local bhs via local_bh_disable(), then we 'miss' the execution of
 > the softirq, until the next IRQ. (or next direct call to do_softirq()).

Hooray, some sanity in this thread finally :-)

Yes, this makes perfect sense, this is indeed what can happen.

 > the attached softirq-2.4.5-B0 patch fixes this problem by calling
 > do_softirq()  from local_bh_enable() [if the bh count is 0, to avoid
 > recursion].

Yikes!  I do not like this fix.

I'd rather local_bh_enable() not become a more heavy primitive.

I know, in one respect it makes sense because it parallels how
hardware interrupts work, but not this thing is a function call
instead of a counter bump :-(

Any other ideas how to zap this?

Later,
David S. Miller
davem@redhat.com

