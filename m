Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265119AbRFZVnV>; Tue, 26 Jun 2001 17:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbRFZVnK>; Tue, 26 Jun 2001 17:43:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35087 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265115AbRFZVnA>; Tue, 26 Jun 2001 17:43:00 -0400
Date: Tue, 26 Jun 2001 18:42:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: John Stoffel <stoffel@casc.com>
Cc: Jason McMullan <jmcmullan@linuxcare.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <15160.65442.682067.38776@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.33L.0106261838320.23373-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001, John Stoffel wrote:

> >> * If we're getting low cache hit rates, don't flush
> >> processes to swap.
> >> * If we're getting good cache hit rates, flush old, idle
> >> processes to swap.
>
> Rik> ... but I fail to see this one. If we get a low cache hit rate,
> Rik> couldn't that just mean we allocated too little memory for the
> Rik> cache ?
>
> Or that we're doing big sequential reads of file(s) which are
> larger than memory, in which case expanding the cache size buys
> us nothing, and can actually hurt us alot.

That's a big "OR".  I think we should have an algorithm to
see which of these two is the case, otherwise we're just
making the wrong decision half of the time.

Also, in many systems we'll be doing IO on _multiple_ files
at the same time, so I guess this will have to be a file-by-file
decision.

> I personally don't feel that the cache should be allowed to grow over
> 50% of the system's memory at all, we've got so much in the cache at
> that point, that we're probably not hitting it all that much.

Remember that disk cache includes stuff like mmap()ed
executables and swap-backed user memory. Do you really
want to limit those too ?


regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

