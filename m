Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293020AbSCEACK>; Mon, 4 Mar 2002 19:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293021AbSCEACA>; Mon, 4 Mar 2002 19:02:00 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:42256 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293020AbSCEABn>;
	Mon, 4 Mar 2002 19:01:43 -0500
Date: Mon, 4 Mar 2002 21:01:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305005215.U20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203042056110.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> On Mon, Mar 04, 2002 at 08:11:21PM -0300, Rik van Riel wrote:
> > You'll have one CPU starting to allocate from zone A, falling
> > back to zone B and then further down.
>
> what is zone A/B, I guess you mean node A/B etc.. Zones are called
> NORMAL/DMA/HIGHMEM so I'm confused.

OK, now think about a NUMA-with-small-n system like AMD Hammer.

One of the CPUs will want to allocate from HIGHMEM zone A while
another CPU will start allocating at HIGHMEM zone B. Of course,
with memory access time between the "nodes" being not too different
you'll want to fall back to the "other" HIGHMEM zone before falling
back to the (single) NORMAL and DMA zones.

This could be expressed as:

"node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
"node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA

How would you express this situation in classzone ?


> > As for kswapd going crazy, that is nicely fixed by having
> > per zone lru lists... ;)
>
> I don't see how per-zone lru lists are related to the kswapd deadlock.
> as soon as the ZONE_DMA will be filled with filedescriptors or with
> pagetables (or whatever non pageable/shrinkable kernel datastructure you
> prefer) kswapd will go mad without classzone, period.

So why would kswapd not go mad _with_ classzone ?

I bet the workaround for that problem has very little
to do with classzones...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

