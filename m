Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUIER62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUIER62 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 13:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUIER62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 13:58:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:55787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265477AbUIER60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 13:58:26 -0400
Date: Sun, 5 Sep 2004 10:58:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
In-Reply-To: <1094405830.2809.8.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0409051051120.2331@ppc970.osdl.org>
References: <413AA7B2.4000907@yahoo.com.au>  <20040904230210.03fe3c11.davem@davemloft.net>
  <413AAF49.5070600@yahoo.com.au> <413AE6E7.5070103@yahoo.com.au> 
 <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org> <1094405830.2809.8.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Sep 2004, Arjan van de Ven wrote:
> 
> well... we have a reverse mapping now. What is stopping us from doing
> physical defragmentation ?

Nothing but replacement policy, really, and the fact that not everything
is rmappable.

I think we should _normally_ honor replacement policy, the way we do now.  
Only if we are in the situation "we have enough memory, but not enough
high-order-pages" should we go to a separate physical defrag algorithm.

So either kswapd should have a totally different mode, or there should be
a separate "kdefragd". It would potentially also be good if it is user-
triggerable, so that you could, for example, have a heavier defragd run
from the daily "cron" runs - something that doesn't seem to make much
sense from a traditional kswapd standpoint.

In other words, I don't think the physical thing should be triggered at 
all by normal memory pressure. A large-order allocation failure would 
trigger it "somewhat", and maybe it might run very slowly in the 
background (wake up every five minutes or so to see if it is worth doing 
anything), and then some user-triggerable way to make it more aggressive.

Does that sound sane to people?

		Linus
