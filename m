Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293453AbSBYTga>; Mon, 25 Feb 2002 14:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293461AbSBYTgU>; Mon, 25 Feb 2002 14:36:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25604 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293458AbSBYTgQ>; Mon, 25 Feb 2002 14:36:16 -0500
Date: Mon, 25 Feb 2002 11:35:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Gerd Knorr <kraxel@bytesex.org>,
        Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, Dave Jones <davej@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <20020225133226.B11675@redhat.com>
Message-ID: <Pine.LNX.4.33.0202251133580.8991-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Feb 2002, Benjamin LaHaise wrote:
> 
> I disagree: requiring aio to execute completion in user context means 
> that we can no longer have quick completion directly from an interrupt 
> handler to a busy server executing in userland.

Note that teh IO _completion_ can happen in user land. That does not mean 
that the IO page tear-down can (or should) happen at the same time.

There are two issues here:
 - the data structures supporting the IO, built up and torn down from 
   process space.
 - the IO itself.

One is synchronous, the other is not.

		Linus

