Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUGJAwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUGJAwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUGJAwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:52:33 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:50345 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S265977AbUGJAw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:52:29 -0400
Date: Sat, 10 Jul 2004 02:52:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710005208.GW20947@dualathlon.random>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709235017.GP20947@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 01:50:17AM +0200, Andrea Arcangeli wrote:
> agreed. might_sleep() just like BUG() can be defined to noop.

BTW, this reminded me a related topic that I can't recall being ever
mentioned on l-k: BUG_ON can also be optimized away. So people should be
careful not to do write this:

        BUG_ON(test_and_set_bit(p))

but to write this instead:

        if (unlikely(test_and_set_bit(p))
                BUG()

(in short the check inside a BUG_ON must be strictly read-only since
it's not guaranteed to be computed)
