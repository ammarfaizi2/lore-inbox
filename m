Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279649AbRJ3AAa>; Mon, 29 Oct 2001 19:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279652AbRJ3AAU>; Mon, 29 Oct 2001 19:00:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10503 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279649AbRJ3AAI>; Mon, 29 Oct 2001 19:00:08 -0500
Date: Mon, 29 Oct 2001 15:58:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011029.155559.64018347.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0110291556300.16744-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, David S. Miller wrote:
>
> Doing range flushes is not the answer.   It is going to be about
> the same cost as doing per-page flushes.

No, doing a range flush might be fine - we'd just do it _once_ per
invocation of swap_out(), and that would probably be fine.

The problem with the flush at the low level is that it's done once for
every page in the whole VM space, which is easily millions of times.

Cutting it down to once every MM would definitely be worth it.

It won't be "exact" either, but it would mean that at least the lifetime
of an optimistic TLB entry is bounded.

		Linus

