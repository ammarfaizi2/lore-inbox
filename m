Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136092AbREHCes>; Mon, 7 May 2001 22:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136123AbREHCe2>; Mon, 7 May 2001 22:34:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40204 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136092AbREHCeY>; Mon, 7 May 2001 22:34:24 -0400
Date: Mon, 7 May 2001 19:34:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <15095.15091.45238.172746@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105071929190.8237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, David S. Miller wrote:
> 
> Here, let's talk code a little bit so there are no misunderstandings,
> I really want to put this to rest:
> 
> Calculate dead_swap_page outside of lock.

NO. That's not what you're doing at all. You're calculating something
completely different that "dead swap page". You're calculating "do we have
a swap cache entry that is not mapped into any virtual memory"?

> If dead_swap_page, ignore referenced bit heuristics.

Which is complete crap. Those reference bits are valid and important
data. You have not computed anything that says otherwise. You have
computed a random number that doesn't tell you anything about whether the
page is dead or not. 

> Really, what does this have to do with swap counts and page counts?
> 
> It's a heuristic. In fact it even seems stupid to me to recalculate
> dead_swap_page after we get the lock just for the sake of these
> heuristics.

YOUR HEURISTIC IS WRONG!

> Maybe I should have diguised this bit as:
> 
> if (dead_swap_page)
> 	do_writepage_first_pass = 1;

So tell me: what does the above help?

I repeat: your "dead_swap_page" variable is a random number with
absolutely no meaning. ANYTHING that uses it is buggy. It doesn't help in
the least if you use the first random state to set another random
state: the amount of randomness does not increase or decrease.

See?

> To divert people's brains to what the intent was :-)

I can see the intent.

I can also see that the code doesn't match up to the intent.

I call that a bug. You don't. Fine.

But that code isn't coming anywhere _close_ to my tree until the two
match. And I stand by my assertion that it should be reverted from Alans
tree too.

		Linus

