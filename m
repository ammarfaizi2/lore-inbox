Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287634AbRLaUOT>; Mon, 31 Dec 2001 15:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287633AbRLaUOK>; Mon, 31 Dec 2001 15:14:10 -0500
Received: from mail2.mx.voyager.net ([216.93.66.201]:54546 "EHLO
	mail2.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S287641AbRLaUNz>; Mon, 31 Dec 2001 15:13:55 -0500
Message-ID: <3C30C6DC.E7F8A2AB@megsinet.net>
Date: Mon, 31 Dec 2001 14:13:16 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: andihartmann@freenet.de, riel@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com>
		<3C2F04F6.7030700@athlon.maya.org>
		<3C309CDC.DEA9960A@megsinet.net> <20011231185350.1ca25281.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> 
> On Mon, 31 Dec 2001 11:14:04 -0600
> "M.H.VanLeeuwen" <vanl@megsinet.net> wrote:
> 
> > [...]
> > vmscan patch:
> >
> > a. instead of calling swap_out as soon as max_mapped is reached, continue to
> try>    to free pages.  this reduces the number of times we hit
> try_to_free_pages() and>    swap_out().
> 
> I experimented with this some time ago, but found out it hit performance and
> (to my own surprise) did not do any good at all. Have you tried this
> stand-alone/on top of the rest to view its results?


No benchmarks specifically to show changes yet.  Hmmm, I found quite the opposite from
an interactive feeling on SMP and I was happy not to have a kernel killing processes
out of the blue when it started hitting the upper limits of VM.  Especially when there
was still plenty of cache to be evicted (the original reason for the OOM tamer).

Yes, your performance loss may be from having less cache overall since the kernel is
swapping out less. OTOH we tend to not hit shrink_[di]cache_memory much less with this
change.

I'll try to time some kernel compiles with the vmscan patch...
compile times and amount of swap used afterwards, from a cold start and subsequent
compile, etc.

Andreas Hartmann generated a comparison of many kernel VM's including Andrea's and Rick's
and the last AC patch.  I'll send it to you separately since it is rather large and
everyone Cc'd has already seen it.

As was pointed out earlier it sure will be nice once we have some cache stats...

Willing to give this one a try to see if it is still a performance hit for you? 
VM has probably change since "some time ago". ;)


Martin
