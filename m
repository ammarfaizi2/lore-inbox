Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRFEXRv>; Tue, 5 Jun 2001 19:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263418AbRFEXRl>; Tue, 5 Jun 2001 19:17:41 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:25610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263416AbRFEXRb>; Tue, 5 Jun 2001 19:17:31 -0400
Date: Tue, 5 Jun 2001 16:16:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd and MM overload fix
In-Reply-To: <20010606004450.C27651@athlon.random>
Message-ID: <Pine.LNX.4.31.0106051612500.9908-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jun 2001, Andrea Arcangeli wrote:
>
> Anybody running on a machine with some zone empty (<16Mbyte boxes (PDAs),
> <1G x86 with highmem enabled kernel or an arch with an iommu like alpha)
> probably noticed that the MM was unusable on those hardware
> configurations (as I also incidentally mentioned a few times on l-k in
> the last months).
>
> Yesterday I checked and here it is the fix (included in 2.4.5aa3).

I think the real problem is that zone->pages_{min,low,high} aren't
initialized at all for empty zones. If they were initialized (to zero, of
course), the shortage calculations would have worked automatically.

Using uninitialized variables is always bad. Your patch is certainly fine,
but I think we should also make the init code clear the zone data for
empty zones so that these kinds of "use uninitialized stuff" things cannot
happen. No?

		Linus

