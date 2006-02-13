Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWBMK4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWBMK4Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWBMK4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:56:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60891 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932367AbWBMK4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:56:15 -0500
Date: Mon, 13 Feb 2006 11:54:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@davemloft.net>
Cc: heiko.carstens@de.ibm.com, hare@suse.de, linux-kernel@vger.kernel.org
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060213105421.GB17173@elte.hu>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com> <20060213.023430.126649129.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213.023430.126649129.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David S. Miller <davem@davemloft.net> wrote:

> Things are not as slow, but definitely slow on sparc64 too, and it's 
> also due to the migration cost calculations.
> 
> It's also really bad that it's using vmalloc(), for one thing, because 
> this thrashes the TLB (some of us have 64-entry software replaced 
> TLBs) and also because you can make no guarentees about how well the 
> backing physical pages will distribute into the L2 cache.

the TLB trashing is intended, to calculate the worst-case migration 
cost. If userspace is TLB-intensive, it will trash TLBs just as much.

> As a result, wildly different run-to-run results can be expected 
> particularly for systems with 1-way or 2-way set assosciative L2 
> caches, which are common on sparc64.  I don't know about s390.

s390 is clearly a special-base, being a virtual platform. But the 
calibration should be improved to work better on sparc64.

Do things get better if you fill out include/asm-sparc64/system.h's 
sched_cacheflush() function, to flush the L2 cache? That should at least 
make the cache state more or less reproducable across runs.

	Ingo
