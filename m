Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRKHQkd>; Thu, 8 Nov 2001 11:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKHQkN>; Thu, 8 Nov 2001 11:40:13 -0500
Received: from posta2.elte.hu ([157.181.151.9]:32744 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S274862AbRKHQkE>;
	Thu, 8 Nov 2001 11:40:04 -0500
Date: Thu, 8 Nov 2001 18:37:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0111081836080.15975-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Ingo Molnar wrote:

> > Are there any speed difference between hard-linked device drivers and
> > their modular counterparts?
>
> minimal. a few instructions per IO.

Arjan pointed out that there is also the cost of TLB misses due to
vmalloc()-ing module libraries, which can be as high as a 5% slowdown.

we should fix this by trying to allocate continuous physical memory if
possible, and fall back to vmalloc() only if this allocation fails.

	Ingo

