Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318811AbSHRC6n>; Sat, 17 Aug 2002 22:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318812AbSHRC6n>; Sat, 17 Aug 2002 22:58:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5132 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318811AbSHRC6m>; Sat, 17 Aug 2002 22:58:42 -0400
Date: Sat, 17 Aug 2002 20:05:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020818021522.GA21643@waste.org>
Message-ID: <Pine.LNX.4.44.0208172001530.1491-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Oliver Xymoron wrote:

>  To protect against back to back measurements and userspace
>  observation, we insist that at least one context switch has occurred
>  since we last sampled before we trust a sample.

This sounds particularly obnoxious, since it is entirely possible to have 
an idle machine that is just waiting for more entropy, and this will mean 
(for example) that such an idle machine will effectively never get any 
more entropy simply because your context switch counting will not work.

This is particularly true on things like embedded routers, where the 
machine usually doesn't actually _run_ much user-level software, but is 
just shuffling packets back and forth. Your logic seems to make it not add 
any entropy from those packets, which can be _deadly_ if then the router 
is also used for occasionally generating some random numbers for other 
things.

Explain to me why I should consider these kinds of draconian measures 
acceptable? It seems to be just fascist and outright stupid: avoiding 
randomness just because you think you can't prove that it is random is not 
very productive.

We might as well get rid of /dev/random altogether if it is not useful. 

		Linus

