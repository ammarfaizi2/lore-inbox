Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275399AbRJATYM>; Mon, 1 Oct 2001 15:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275421AbRJATYC>; Mon, 1 Oct 2001 15:24:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49936 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275399AbRJATXq>;
	Mon, 1 Oct 2001 15:23:46 -0400
Date: Mon, 1 Oct 2001 16:23:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
In-Reply-To: <3.0.6.32.20011001203320.02381600@pop.tiscalinet.it>
Message-ID: <Pine.LNX.4.33L.0110011604310.4835-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Lorenzo Allegrucci wrote:

> Disclaimer:
> I don't know if this "benchmark" is meaningful or not, but anyhow..

I'm not sure either, since qsort doesn't really have much
locality of reference but just walks all over the place.

This is direct contrast with the basic assumption on which
VM and CPU caches are built ;)

I wonder how eg. merge sort would perform ...

> Below are linux-2.4.10 results
> real    4m54.728s
>
> kswapd CPU time: 3 seconds
> qs RSS always on 238-240M, very stable never below 235M.

> .. and 2.4.10-ac2 results
> real    6m2.139s
>
> kswapd CPU time: 20 seconds
> qs RSS never above 204M, average value 150M.

The RSS thing is just a side effect of how swap is allocated
and should have little or no influence on which pages are
kept in memory.

One thing which could make 2.4.10 faster for this single case
is the fact that it doesn't keep any page aging info, so IO
clustering won't be confused by the process accessing its
pages ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

