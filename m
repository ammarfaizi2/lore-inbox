Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274580AbRITRmg>; Thu, 20 Sep 2001 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274579AbRITRm0>; Thu, 20 Sep 2001 13:42:26 -0400
Received: from maild.telia.com ([194.22.190.101]:49104 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S274582AbRITRmH>;
	Thu, 20 Sep 2001 13:42:07 -0400
Message-Id: <200109201742.f8KHgJH04518@maild.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Thu, 20 Sep 2001 19:37:30 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1000939458.3853.17.camel@phantasy> <20010920084131.C1629@athlon.random> <200109200757.JAA60995@blipp.internet5.net>
In-Reply-To: <200109200757.JAA60995@blipp.internet5.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday den 20 September 2001 09.57, Dieter Nützel wrote:
> Am Donnerstag, 20. September 2001 08:41 schrieb Andrea Arcangeli:

>
> But this is not enough. Even with reniced artsd (-20).
> Some shorter hiccups (0.5~1 sec).
>
> -Dieter
>
> dbench 16 (without renice)
> Throughput 31.0483 MB/sec (NB=38.8104 MB/sec  310.483 MBit/sec)
> 7.270u 29.290s 1:09.03 52.9%    0+0k 0+0io 511pf+0w
> load: 1034
>
> Worst 20 latency times of 4261 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>   4617   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
    ^^^^

This is fantastic! It REALLY is!
When we started with the low latency work we aimed at 10 ms.
(in all situations, not only when running dbench... but still)

Lets see - no swap used? - not swapped out
But with priority altered - it is unlikely that it would not be scheduled
in for such a long time.

Might it be that the disk is busy to handle dbench requests. 16 threads ->
16 read and several (async) write requests at different disk locations in
queue - make it 20. Seek time 10 ms => queue length 200 ms... probable???
Do you have more than one disk? Try to run dbench on one and the player from
the other.

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
