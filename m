Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318825AbSHRDBM>; Sat, 17 Aug 2002 23:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318835AbSHRDBM>; Sat, 17 Aug 2002 23:01:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13324 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318825AbSHRDBM>; Sat, 17 Aug 2002 23:01:12 -0400
Date: Sat, 17 Aug 2002 20:08:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020818025913.GF21643@waste.org>
Message-ID: <Pine.LNX.4.44.0208172006050.1491-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> 
> Let me clarify that 2-5 orders thing. The kernel trusts about 10 times
> as many samples as it should, and overestimates each samples' entropy
> by about a factor of 10 (on x86 with TSC) or 1.3 (using 1kHz jiffies).

Lookin gat the code, your _new_ code just throws samples away _entirely_ 
just because some random event hasn't happened (the first thing I noticed 
was the context switch testing, there may be others there that I just 
didn't react to).

In short, you seem to cut those random events to _zero_. And this happens 
under what seems to be perfectly realistic loads. That's not trying to fix 
things, that's just breaking them.

> The patches will be a nuisance for anyone who's currently using
> /dev/random to generate session keys on busy SSL servers.

No, it appears to be a nuisanse even for people who have real issues, ie 
just generating _occasional_ numbers on machines that just don't happen to 
run much user space programs.

		Linus

