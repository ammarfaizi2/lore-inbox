Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271644AbRIBQ5z>; Sun, 2 Sep 2001 12:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271645AbRIBQ5p>; Sun, 2 Sep 2001 12:57:45 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:49681 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271644AbRIBQ5c>; Sun, 2 Sep 2001 12:57:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: Rik`s ac12-pmap2 vs ac12-vanilla perfcomp
Date: Sun, 2 Sep 2001 19:04:32 +0200
X-Mailer: KMail [version 1.3.1]
Cc: riel@surriel.com
In-Reply-To: <200109021710.f82HAbD00606@vegae.deep.net>
In-Reply-To: <200109021710.f82HAbD00606@vegae.deep.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902165742Z16375-32383+3005@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2001 07:10 pm, Samium Gromoff wrote:
>    No flames please - i know these were low VM loads, i did this just to know 
> how big is test rmaps maitenance overhead. It shows us that even on low VM
> load there is a huge win in using rmap. And the win increases with the VM load.
>    Algo:
>       - booted ac12
>       - performed test A 7 times, then test B 7 times.
>       - booted ac12-pmap2
>       - performed test A 7 times, then test B 7 times.
> 
>       * each test was done 7 times, with the lowest and highest thrown away.
>       * due to high values of data and streaming usage pattern caching was 
>  unable to affect results, so it was ignored.
> 
> test A:
> "time find / -xdev" + (standard junk eating ~6% cpu (top procinfo))
>   descr: extremely low VM load, mostly IO dependent
> 
> test B:
> "time find / -xdev | grep --regexp="\/" | xargs echo" + background mpg123 +
>  + standard junk described above
>   descr: low, although higher than A, vm load (nearly absolutely no swap)

It's nice to see these tests aren't running any slower (and not crashing!)
but as I understand it, reverse mapping is a win only for shared mmaps and
swapping, which you aren't doing.  So it's not clear what effect is being
measured.

One thing that goes away with rmaps is the need to scan process page tables.
It's possible that this takes enough load off L1 cache to produce the effects
you showed, though it would be surprising.

(Note that I'm in the "reverse maps are good" camp, and I think Rik's design 
is fundamentally correct.)

--
Daniel
