Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136641AbREGWo6>; Mon, 7 May 2001 18:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136697AbREGWos>; Mon, 7 May 2001 18:44:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32938 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136641AbREGWon>;
	Mon, 7 May 2001 18:44:43 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.9557.998522.571971@pizda.ninka.net>
Date: Mon, 7 May 2001 15:44:37 -0700 (PDT)
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <9d6npn$dhp$1@penguin.transmeta.com>
In-Reply-To: <Pine.A41.4.31.0105062307290.59664-100000@pandora.inf.elte.hu>
	<9d6npn$dhp$1@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
 > The whole "dead_swap_page" optimization in the -ac tree is apparentrly
 > completely bogus.  It caches a value that is not valid: you cannot
 > reliably look at whether the page has buffers etc without holding the
 > page locked. 

It caches a value controlling heuristics, not "state".  Specifically
it controls whether we:

1) Ignore the referenced bit, this is fine.

2) Allow writepage() operations in the first pass.  This is fine too.

All normal checks are redone, only heuristics are changed.

Please show me how this is illegal.  Everyone comes to this conclusion
when the first read the code, that I am doing something illegal, then
when I explain what that dead_swap_page thing is doing and they read
it a second time (how shocking! :-) they go "oh, I see".

If the patch is causing problems, it is due to some other bug not my
patch itself.

I do not argue that my patch is "the" way to solve the dead swap page
problem, to the contrary.  Stephen has something which seems to try to
attack this issue in a much nicer way.

Later,
David S. Miller
davem@redhat.com
