Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271326AbRHZOzd>; Sun, 26 Aug 2001 10:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271321AbRHZOzY>; Sun, 26 Aug 2001 10:55:24 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:11956 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S271289AbRHZOzK>;
	Sun, 26 Aug 2001 10:55:10 -0400
Date: Sun, 26 Aug 2001 16:55:17 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826165517.D22677@cerebro.laendle>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010826152204.B22677@cerebro.laendle> <Pine.LNX.4.33L.0108261036160.5646-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108261036160.5646-100000@imladris.rielhome.conectiva>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 10:48:05AM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> Margo Selzer wrote a nice paper on letting an elevator
> algorithm take care of request sorting. Only at the point
> where several thousand requests were queued and latency
> to get something from disk grew to about 30 seconds did
> a disk system relying on just an elevator get anything
> close to decent throughput.

But this is totally irrelevant. The elevator is the only thing left to do.
(and, as I said, rhe latency until data transfer starts is already about
16 seconds ;).

I believe I can get 5-6MB/s in the best case out of the system, and if the
elevator optimization coming from, say, 64 threads gives me 5.5 instead
of 5MB/s I would be very happy. Conversely, I could reduce the initial
latency by using smaller buffers if this optimization worked.

> This paper convinced me that doing just elevator sorting
> is never enough ;)

It must be enough, unfortunately ;) Ok, I could add user-limits or
somesuch, but I never believed in such a thing myself.

> One thing you could do, in recent -ac kernels, is make the
> maximum readahead size smaller by lowering the value in
> /proc/sys/vm/max-readahead

Yes, this indeed helps slightly (with the ac9 kernel I don't see the
massive thrashing going on with the linus' ones anyway). Now the only
thing left would be to be able to to that per access (even per disk would
help), as I, of course, rely on read-ahead for all other things going on
on that server ;)

It seems that I can in excess of 4MB/s (sometimes 5MB/s) when using large
bounce-buffers and disabling read-ahead completely under ac9. So something
with the kernel read-ahead *is* going wrong, as the default read-ahead
of 31 (pages? 124k) is very similar to my current read-buffer size of
128k. And enabling read-ahead and decreasing the user-space buffers gives
abysmal performance again.

> 
> regards,
> 
> Rik
> -- 
> IA64: a worthy successor to i860.
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
> 

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
