Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272354AbRHYAEg>; Fri, 24 Aug 2001 20:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272351AbRHYAE1>; Fri, 24 Aug 2001 20:04:27 -0400
Received: from blackhole.compendium-tech.com ([64.156.208.74]:50318 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S272349AbRHYAEO>; Fri, 24 Aug 2001 20:04:14 -0400
Date: Fri, 24 Aug 2001 17:04:28 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: Otto Wyss <otto.wyss@bluewin.ch>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why don't have bits the same rights as humans! (flushing to disk
 waiting  time)
In-Reply-To: <3B802B68.ADA545DB@bluewin.ch>
Message-ID: <Pine.LNX.4.33.0108241703190.19222-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It sounds like your files are getting cached to memory before the pages
are flushed to disk. If you want them flushed instantly after you do a
write, simply do a 'sync' after the write or mount the filesystem
synchronous (ie nothing is cached, ever).


On Sun, 19 Aug 2001, Otto Wyss wrote:

> I recently wrote some small files to the floppy disk and noticed almost nothing
> happened immediately but after a certain time the floppy actually started
> writing. So this action took more than 30 seconds instead just a few. This
> remembered me of the elevator problem in the kernel. To transfer this example
> into real live: A person who wants to take the elevator has to wait 8 hours
> before the elevator even starts. While probably everyone agrees this is
> ridiculous in real live astonishingly nobody complains about it in case of a disk.
>
> Why don't have bits the same rights as humans! ;-)
>
> I know this waiting period should help the elevator algorithm to choose a better
> service. But is this really true? Lets assume the following situations:
>
> 1. Just a few persons/time period wants to use the elevator. The elevator just
> service each person since no other is waiting for its service.
>
> 2. A rather lot of persons/time period wants to use the elevator, of course the
> elevator can't now service all immediately. But now since accumulation starts
> the elevator can improve its service which of course reduces the accumulation
> which decreases its service and so on.
>
> 3. More persons/time period than the elevator can service wants to use it, the
> accumulation always gets higher. Now the elevator works as if it has been given
> a large accumulation time. Hopefully this situations doesn't persist or the
> system itself gets broke.
>
> Now of course a waiting time helps to push the elevator service into situation 3
> even if service request are still in situation 2 or 1. Also real elevators have
> this waiting time, it's starts when the first person enters and choose his
> destination until it has missed the next person (either direction or already
> passed). A rough estimate gives a waiting time in the range of about an average
> service time.
>
> If I assume an average service time for bits (disk access) of about 10ms around
> 3000 service requests could be accumulated before any service starts. Now I dare
> to question that even the best elevator algorithm is able to optimize more than
> 20 service requests on a usefull base, so any waiting time above 200ms is simply useless.
>
> Lets go back to situation 2. As we see accumulation happens on a "natural" way
> which imposes a certain waiting time. I guess this alone gives a service which
> is at least as good as halve of the best service.
>
> Could anybody produce any real figures to prove/disprove my theory? Could
> anybody benchmark the disk access for the 3 waiting times (0, 200ms 30sec) with
> different loads?
>
> O. Wyss
>
> Please CC, thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

