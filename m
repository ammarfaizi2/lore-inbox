Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131836AbRCXV6r>; Sat, 24 Mar 2001 16:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131837AbRCXV6j>; Sat, 24 Mar 2001 16:58:39 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:51209 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131836AbRCXV60> convert rfc822-to-8bit; Sat, 24 Mar 2001 16:58:26 -0500
To: Jakob Østergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
	<vba1yrr7w9v.fsf@mozart.stat.wisc.edu>
	<15032.1585.623431.370770@pizda.ninka.net>
	<vbay9ty50zi.fsf@mozart.stat.wisc.edu>
	<vbaelvp3bos.fsf@mozart.stat.wisc.edu>
	<20010322193549.D6690@unthought.net>
	<vbawv9hyuj0.fsf@mozart.stat.wisc.edu>
	<20010324104849.B9686@unthought.net>
From: buhr@stat.wisc.edu (Kevin Buhr)
Date: 24 Mar 2001 13:54:39 -0600
In-Reply-To: Jakob Østergaard's message of "Sat, 24 Mar 2001 10:48:49 +0100"
Message-ID: <vbabsqrvt6o.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard <jakob@unthought.net> writes:
> 
> It's important that you use at least -O3 to get inlining too.
[ . . . ]
> 25 MB doesn't count  ;)

Aggh!  I feel like I'm in a comedy sketch.  You tell me "do that".  
I do that.  You tell me, "you should try this instead", so I do this.
Then, you tell me, "but you should really do the other."

You're the one who suggested "gtk--" as a test case.  Built out of the
box, it uses "-O2".  If there were magical settings or sekret
incantations, I wish you'd mentioned them when you suggested it.

> No, map merging is obviously a good idea if it can be done at little cost.
> There has to be other cases out there than GCC 2.96 (which is still the
> best damn C++ compiler to ship on any GNU/Linux distribution in history)

If something has a cost, even a little cost, and no one can find a
benefit, then implementing it is not "obviously" a good idea.  That's
why Linus asked for a real-world example before he spent time
complicating the algorithms and adding checks that incur a cost for
every process, even those that won't get any benefit.

> As someone else already pointed out GCC-3.0 will improve it's allocation,
> but it *still* allocates many maps - less than before, but still potentially
> lots...

Yes.  Zach's explanation is the first thing I've seen that makes a
case for some benefit (besides babysitting GCC 2.96) without
conflicting with the data I'm getting.

As I've noted elsewhere, I see no change at all in system time for GCC
3.0 between 2.4.2 and 2.4.3-pre7.  Given Zach's explanation, I'm
prepared to believe there might be a difference with, say, a 500meg
arena (or perhaps something as small as a 100meg arena).

> It will still have the 70x performance increase on kernel memory map
> handling as demonstrated in my benchmark just posted.  However, it will
> be 70x of much less than with 2.96.

For my test cases under 3.0, it looks like 70 times zero.  However,
I'm now prepared to believe that it could be 70 times something
non-zero for certain very hairy source files.

Kevin <buhr@stat.wisc.edu>
