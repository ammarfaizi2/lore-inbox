Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269392AbRHLRrW>; Sun, 12 Aug 2001 13:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269393AbRHLRrM>; Sun, 12 Aug 2001 13:47:12 -0400
Received: from lilly.ping.de ([62.72.90.2]:49169 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S269392AbRHLRrF>;
	Sun, 12 Aug 2001 13:47:05 -0400
Date: 12 Aug 2001 19:46:18 +0200
Message-ID: <20010812194618.A880@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Mike Galbraith" <mikeg@wen-online.de>,
        "Steve Kieu" <haiquy@yahoo.com>,
        "kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Performance 2.4.8 is worse than 2.4.x<8
In-Reply-To: <E15VtnT-0005bM-00@the-village.bc.nu> <Pine.LNX.4.33L.0108121053430.6118-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33L.0108121053430.6118-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sun, Aug 12, 2001 at 11:00:31AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 11:00:31AM -0300, Rik van Riel wrote:
> On Sun, 12 Aug 2001, Alan Cox wrote:
> 
> > > Here, disk write throughput seems to want some tweaking, and Bonnie
> > > doing it's rewrite test triggers a very large and persistant inactive
> > > shortage which shouldn't be there (imho).
> >
> > This is one of the reasons I kept the 2.4.7 vm. The 2.4.8 vm is better
> > than 2.4.8pre but not actually better than the older VM by feel or
> > measurement on my test boxes
> 
> There are some open-ended questions wrt. the use-once idea,
> its implementation and the way the thing has been integrated
> with the rest of the kernel.
> 
> Some suspect interactions and some things which just aren't
> clear yet don't make it seem the best idea to start integrating
> the use-once idea in mainli^W-ac yet...

Is it possible that this causes the slowdown I see when I benchmark
kernel compilations? Doing make -j2 bzImage modules on 2.4.7 gives:

        User time (seconds): 279.62
        System time (seconds): 22.19
        Percent of CPU this job got: 77%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 6:29.95
        ...
        Major (requiring I/O) page faults: 1085696
        Minor (reclaiming a frame) page faults: 1263226

With 2.4.8 (default bdflush settings):

        User time (seconds): 280.75
        System time (seconds): 21.46
        Percent of CPU this job got: 71%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 7:04.14
        ...
        Major (requiring I/O) page faults: 1085927
        Minor (reclaiming a frame) page faults: 1263289

With 2.4.8 (and 50/75 bdflush settings):

        User time (seconds): 282.20
        System time (seconds): 20.82
        Percent of CPU this job got: 71%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 7:03.27
        ...
        Major (requiring I/O) page faults: 1094004
        Minor (reclaiming a frame) page faults: 1265526

Since 2.4.8 should be better when running short of memory I tried
make -j bzImage modules also, with 2.4.7:

        User time (seconds): 294.16
        System time (seconds): 32.70
        Percent of CPU this job got: 32%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 16:40.38
        ...
        Major (requiring I/O) page faults: 1560301
        Minor (reclaiming a frame) page faults: 1601194

and with 2.4.8 (default bdflush)

        User time (seconds): 293.57
        System time (seconds): 50.55
        Percent of CPU this job got: 24%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 23:35.30
        ...
        Major (requiring I/O) page faults: 1592833
        Minor (reclaiming a frame) page faults: 1556612

System is an Athlon-1.2GHz with 256MB DDR-Ram.


If you want further compilation benchmarks just let me know.


Regards,

   Jogi


-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
