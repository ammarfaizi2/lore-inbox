Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVAIUTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVAIUTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVAIUTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:19:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:16261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261735AbVAIUTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:19:17 -0500
Date: Sun, 9 Jan 2005 12:19:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
Subject: Re: removing bcopy... because it's half broken
In-Reply-To: <20050109192305.GA7476@infradead.org>
Message-ID: <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
References: <20050109192305.GA7476@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jan 2005, Arjan van de Ven wrote:
>
> Instead of fixing this inconsistency, I decided to remove it entirely,
> explicit memcpy() and memmove() are prefered anyway (welcome to the 1990's)
> and nothing in the kernel is using these functions, so this saves code size
> as well for everyone.

The problem is that at least some gcc versions would historically generate
calls to "bcopy" on alpha for structure assignments. Maybe it doesn't any
more, and no such old gcc versions exist any more, but who knows?

That's also why "bcopy" just acts like a memcpy() in many cases: it's 
simply not worth it to do the complex case, because the only valid use was 
a compiler that would never validly do overlapping ranges anyway.

Gcc _used_ to have a target-specific "do I use bcopy or memcpy" setting,
and I just don't know if that is still true. I also don't know if it
affected any other platforms than alpha (I would assume that it matched
"target has BSD heritage", and that would likely mean HP-UX too)

Richard? You know both gcc and alpha, what's the word?

		Linus
