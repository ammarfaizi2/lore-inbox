Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274100AbRI0XbD>; Thu, 27 Sep 2001 19:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274105AbRI0Xax>; Thu, 27 Sep 2001 19:30:53 -0400
Received: from [195.223.140.107] ([195.223.140.107]:8700 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274100AbRI0Xap>;
	Thu, 27 Sep 2001 19:30:45 -0400
Date: Fri, 28 Sep 2001 01:31:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010928013106.W14277@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 26, 2001 at 06:44:03PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 06:44:03PM +0200, Ingo Molnar wrote:

some comment after reading your softirq-2.4.10-A7.

>  - softirq handling can now be restarted N times within do_softirq(), if a
>    softirq gets reactivated while it's being handled.

is this really necessary after introducing the unwakeup logic? What do
you get if you allow at max 1 softirq pass as before?

>  - '[ksoftirqd_CPU0]' is confusing on UP systems, changed it to
>    '[ksoftirqd]' instead.

"confusing" for you maybe, not for me, but I don't care about this one
anyways :).

>  - simplified ksoftirqd()'s loop, it's both shorter and faster by a few
>    instructions now.

only detail: ksoftirqd can show up as sleeping from /proc while it's
runnable but I don't think it's a problem and saving the state
clobbering is probably more sensible.

no other obvious issue, except I preferred to wait each ksoftirqd to
startup succesfully to be strictier and I'd also put an assert after
the schedule() to verify ksoftirqd is running in the right cpu.

Andrea
