Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUHAOrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUHAOrw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUHAOrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:47:52 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:44999 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266003AbUHAOrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:47:45 -0400
Date: Sun, 1 Aug 2004 10:51:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
In-Reply-To: <20040801042053.06b33060.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0408011045591.4095@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
 <20040731232126.1901760b.pj@sgi.com> <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
 <20040801042053.06b33060.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Paul Jackson wrote:

> Zwane wrote:
> > NR_CPUS was 3, the test case may as well be passing first_cpu or next_cpu
> > a value of 0 for the map.
>
> So, if NR_CPUS is 3, and you pass an empty map to any_online_cpu()
> on an i386, you get back not 3, as expected, but 32 ??
>
> And this is because find_next_bit(0, 3, 0), for example, returns 32,
> correct ??
>
> Well ... no ... I must not be guessing your example right yet.  Because
> in the above example, first_cpu(0) will (should ?) return with NR_CPUS,
> and the for_each_cpu_mask() inside any_online_cpu() will end there.
>
> Could you give me the rest of the numbers in a specific example?
>
> Please ...

Well you could have just tried it, all you needed to do was paste the code
for find_first_bit into a file and make a simple test case. Then plugging
in a value of 0x0 for the map. so in pseudocode for NR_CPUS = 3;

first_cpu(0) = next_cpu(0) = 32.

> Hmmm ... perhaps you're saying you're passing a non-zero map to
> any_online_cpu(), but that the bits set in what you pass aren't
> online, which would end up calling find_next_bit().  Yeah - that
> must be it.

Yes i did specify that in the original email.

> And indeed the i386 find_next_bit() code can't possibly be honoring a
> size < 32, because it doesn't even consider the size value until it has
> finished the first word without finding a set bit in the last 32-offset
> bits.
>
>
> > The "bug" in the i386 find_next_bit really
> > looks like a feature if you look at the code.
>
> What code, what feature, what bug ...  Please be specific.

The find_next_bit code, the additional find_first_bit on the failure to
find a bit exit path and i'm referring to this bug, the one i'm reporting
now.

> If all this is so, then i386 find_next_bit() is wrong.  Possibly other
> some arch's too -- it's not code that I can read easily.
>
> If not, then in addition to fixing cpumask.h, we'd better also consider
> whether we need to fix:

I was short on time to do a complete audit, the change to cpumask.h is a
necessity anyway.
