Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280932AbRKDRVi>; Sun, 4 Nov 2001 12:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280042AbRKDRVS>; Sun, 4 Nov 2001 12:21:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30724 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280037AbRKDRVI>; Sun, 4 Nov 2001 12:21:08 -0500
Date: Sun, 4 Nov 2001 09:18:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM: qsbench numbers
In-Reply-To: <3.0.6.32.20011104151152.01fdaea0@pop.tiscalinet.it>
Message-ID: <Pine.LNX.4.33.0111040913370.6919-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 Nov 2001, Lorenzo Allegrucci wrote:
>
> I begin with the last Linus' kernel, three runs and kswapd CPU
> time appended.

It's interesting how your numbers decrease with more swap-space. That,
together with the fact that the "more swap space" case also degrades the
second time around seems to imply that we leave swap-cache pages around
after they aren't used.

Does "free" after a run has completed imply that there's still lots of
swap used? We _should_ have gotten rid of it at "free_swap_and_cache()"
time, but if we missed it..

What happens if you make the "vm_swap_full()" define in <linux/swap.h> be
unconditionally defined to "1"? That should make us be more aggressive
about freeing those swap-cache pages, and it would be interesting to see
if it also stabilizes your numbers.

		Linus

