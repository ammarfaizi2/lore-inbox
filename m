Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266013AbRG1Agy>; Fri, 27 Jul 2001 20:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266129AbRG1Agp>; Fri, 27 Jul 2001 20:36:45 -0400
Received: from mail.mesatop.com ([208.164.122.9]:8964 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S266093AbRG1Agd>;
	Fri, 27 Jul 2001 20:36:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-pre1 and dbench -20% throughput
Date: Fri, 27 Jul 2001 18:35:11 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <200107272112.f6RLC3d28206@maila.telia.com> <0107280034050V.00285@starship>
In-Reply-To: <0107280034050V.00285@starship>
MIME-Version: 1.0
Message-Id: <01072718351100.01369@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 16:34, Daniel Phillips wrote:
> On Friday 27 July 2001 23:08, Roger Larsson wrote:
> > Hi all,
> >
> > I have done some throughput testing again.
> > Streaming write, copy, read, diff are almost identical to earlier 2.4
> > kernels. (Note: 2.4.0 was clearly better when reading from two files
> > - i.e. diff - 15.4 MB/s v. around 11 MB/s with later kenels - can be
> > a result of disk layout too...)
> >
> > But "dbench 32" (on my 256 MB box) results has are the most
> > interesting:
> >
> > 2.4.0 gave 33 MB/s
> > 2.4.8-pre1 gives 26.1 MB/s (-21%)
> >
> > Do we now throw away pages that would be reused?
> >
> > [I have also verified that mmap002 still works as expected]
>
> Could you run that test again with /usr/bin/time (the GNU time
> function) so we can see what kind of swapping it's doing?
>

I also saw a significant drop in dbench 32 results.
Here are a few more data points, this time comparing 2.4.8-pre1 with 2.4.7.

2.4.7   9.3422 MB/sec vs 2.4.8-pre1   6.88884 MB/sec average of 3 runs

The system under test has 384 MB of memory, and did not go
into swap during the test.  I performed a set of three runs immediately after
a boot, and with no pauses in between individual runs.  I used time ./dbench 32
and caputured the output in a file using script `uname -r`.  The tests were done
with X and KDE running, but no other activity.

Here are the results of the six runs:

Steven
-----------------------------------------------------------------------------
2.4.7       average 9.3422 MB/sec

Throughput 9.2929 MB/sec (NB=11.6161 MB/sec  92.929 MBit/sec)
34.11user 238.89system 7:34.59elapsed 60%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1008major+1402minor)pagefaults 0swaps

Throughput 9.56338 MB/sec (NB=11.9542 MB/sec  95.6338 MBit/sec)
34.07user 262.44system 7:22.72elapsed 66%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1008major+1402minor)pagefaults 0swaps

Throughput 9.17032 MB/sec (NB=11.4629 MB/sec  91.7032 MBit/sec)
33.79user 248.46system 7:41.62elapsed 61%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1008major+1402minor)pagefaults 0swaps

-----------------------------------------------------------------------------
2.4.8-pre1  average 6.88884 MB/sec

Throughput 6.8078 MB/sec (NB=8.50975 MB/sec  68.078 MBit/sec)
34.30user 358.35system 10:21.57elapsed 63%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1008major+1402minor)pagefaults 0swaps

Throughput 6.91993 MB/sec (NB=8.64992 MB/sec  69.1993 MBit/sec)
33.62user 369.55system 10:11.43elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1008major+1402minor)pagefaults 0swaps

Throughput 6.93879 MB/sec (NB=8.67349 MB/sec  69.3879 MBit/sec)
33.33user 341.58system 10:09.77elapsed 61%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1008major+1402minor)pagefaults 0swaps


