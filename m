Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318071AbSHCWgQ>; Sat, 3 Aug 2002 18:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318072AbSHCWgQ>; Sat, 3 Aug 2002 18:36:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17171 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318071AbSHCWgP>; Sat, 3 Aug 2002 18:36:15 -0400
Date: Sat, 3 Aug 2002 15:40:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <davidm@napali.hpl.hp.com>
Subject: Re: adjust prefetch in free_one_pgd() 
In-Reply-To: <24964.1028412229@redhat.com>
Message-ID: <Pine.LNX.4.44.0208031526190.10028-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Aug 2002, David Woodhouse wrote:
>
> That's for a prefetch operation which doesn't mark the cache line
> dirty/owned. If you have random addresses used with 'write prefetch'
> operations, that's still going to be a problem.

Does anybody do that? That's a horribly stupid prefetch, and nobody sane
should ever do anything like that, _especially_ if they don't have
cache-coherency at all layers.

Sure, "prefetch for writing" makes sense, but that shouldn't mark them
cacheline dirty, it should just try to get it exclusively. Does anybody
really mark it dirty?

			Linus

