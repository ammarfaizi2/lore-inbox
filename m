Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbUDNRL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUDNRL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:11:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50397
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264289AbUDNRLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:11:22 -0400
Date: Wed, 14 Apr 2004 19:11:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-ID: <20040414171126.GT2150@dualathlon.random>
References: <1130000.1081841981@[10.10.2.4]> <20040413005111.71c7716d.akpm@osdl.org> <120240000.1081903082@flay> <20040414162700.GS2150@dualathlon.random> <25670000.1081960943@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25670000.1081960943@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 09:42:24AM -0700, Martin J. Bligh wrote:
> > As expected the 6 second difference was nothing compared the the noise,
> > though I'd be curious to see an average number.
> 
> Yeah, I don't think either is worse or better - I really want a more stable
> test though, if I can find one.

a test involving less tasks and that cannot take any advantage from the
cache and the age information should be more stable, though I don't have
obvious suggestions.

> Yeah, that's odd.

I just wonder the VM needs a bit of fixing besides the rmap removal, or
if it was just a pure concidence. if it happens again in the -aa pass
too then it may not be a conincidence.

> Because it's frigging hard to make a 16GB machine swap ;-) 'twas just my
> desktop.

mem= should fix the problem for the benchmarking ;)

swapping in general is important for 16GB 32-way too (and that's the
thing that 2.4 mainline cannot swap efficiently, and that's why I had to
add objrmap in 2.4-aa too).

> Yeah, it's hard to do mem= on NUMA, but I have a patch from someone 
> somehwere. Those machines don't tend to swap heavily anyway, but I suppose
> page reclaim in general will happen.

I see what you mean with mem= being troublesome, I forgot you're numa=y,
you can either disable numa temporarily, or use the more complex syntax
that you should find in arch/i386/kernel/setup.c, that should work w/o
kernel changes and w/o patches since it simply trimes the e820 map,
everything else numa is built on top of that map, you've just to give
an hundred megs from the start of every node, and hopefully it'll boot ;).
