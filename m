Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267885AbSIRQuU>; Wed, 18 Sep 2002 12:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbSIRQtf>; Wed, 18 Sep 2002 12:49:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34576 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267605AbSIRQss>; Wed, 18 Sep 2002 12:48:48 -0400
Date: Wed, 18 Sep 2002 09:53:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44L.0209181345320.1519-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209180950010.1913-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Rik van Riel wrote:
>
> On second thought ... yes there's a reason.  Suppose you have
> 100000 threads on your box already, how long is it going to
> take to walk them all to figure out the pid distribution ?
> 
> And are you willing to walk 100000 threads for every 16 pids allocated ?

Give me a real-life case where that happens, and I might care. I dare you.

The pid space is not a uniform distribution, which your made-up-example
depends on. So you usually walk the 100000 threads _once_, and then you
don't have to walk them again for quite a long time.

And guys, if this is a performance problem for some extreme site, the fix
is truly trivial:

	echo $((0x7fffffff)) > /proc/sys/max_pid

and you're done.

You're completely making up a problem that is not a problem in real life.  
Come back to me when the above doesn't work _in_practice_ and somebody is
actually bitten, and maybe I'll care.

Until then, all you're doing is mental masturbation. 

		Linus

