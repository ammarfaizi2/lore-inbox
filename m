Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTAIQeZ>; Thu, 9 Jan 2003 11:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbTAIQeZ>; Thu, 9 Jan 2003 11:34:25 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:25343 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S266806AbTAIQeT> convert rfc822-to-8bit; Thu, 9 Jan 2003 11:34:19 -0500
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Brian Tinsley <btinsley@emageon.com>, Russell Coker <russell@coker.com.au>
Subject: Re: kswapd CPU usage and heavy disk IO
Date: Thu, 9 Jan 2003 17:42:51 +0100
User-Agent: KMail/1.5
Cc: ReiserFS <reiserfs-list@namesys.com>, Rik van Riel <riel@nl.linux.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
References: <200301091431.54451.russell@coker.com.au> <3E1D9D10.40700@emageon.com>
In-Reply-To: <3E1D9D10.40700@emageon.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200301091742.51101.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Januar 2003 17:02 schrieb Brian Tinsley:
> I've been seeing the exact same thing on the same type of system in the
> same situations. This has been causing all kinds of problems on our
> clusters: the system live-locks for a minute or two, causes cluster
> heartbeats to not be received, and falsely fails over when the system
> recovers from the live-lock. The only thing I can find after the
> live-lock is that the runtime for kswapd is abnormally high.
>
> We started running sar (60 second collection interval) and were able to
> capture some stats during this live-lock period. I've snipped some I
> believe may be of interest. Note the missing stats between 03:59:43 and
> 04:02:03
>
> Oh BTW, this is on a stock 2.4.20 kernel (dual P3, 4GB), but I have seen
> the same behavior on 2.4.19 and 2.4.17.

I think you should have cc'ed Andrea Arcangeli <andrea@suse.de>, LKM and try 
2.4.20-aa1.

Are you sure it is a ReiserFS and not a kernel thing?

Regards,
	Dieter

> 1. sar -f sa09 -r
>
> 03:53:43 AM kbmemfree kbmemused  %memused kbmemshrd kbbuffers  kbcached
> kbswpfree kbswpused  %swpused
> 03:54:43 AM    411888   3888264     90.42         0    629520
> 2666968   209713
> 6         0      0.00
> 03:55:43 AM    396684   3903468     90.78         0    658656
> 2667160   209713
> 6         0      0.00
> 03:56:43 AM    331360   3968792     92.29         0    675008
> 2733476   209713
> 6         0      0.00
> 03:57:43 AM    231588   4068564     94.61         0    683680
> 2832816   209713
> 6         0      0.00
> 03:58:43 AM    209740   4090412     95.12         0    702148
> 2854332   209713
> 6         0      0.00
> 03:59:43 AM    211016   4089136     95.09         0    712580
> 2854508   209713
> 6         0      0.00
> 04:02:03 AM    207828   4092324     95.17         0    715180
> 2854596   209713
> 6         0      0.00
> 04:04:30 AM   2581956   1718196     39.96         0    662320
> 874536   209713
> 6         0      0.00
> 04:05:30 AM   4013000    287152      6.68         0     27012
> 84084   209713
> 6         0      0.00
>
> 2. sar -f sa09 -R
>
> 03:53:43 AM   frmpg/s   shmpg/s   bufpg/s   campg/s
> 03:54:43 AM   -263.02      0.00     91.67    299.50
> 03:55:43 AM    -63.35      0.00    121.40      0.80
> 03:56:43 AM   -272.18      0.00     68.13    276.32
> 03:57:43 AM   -415.72      0.00     36.13    413.92
> 03:58:43 AM    -91.03      0.00     76.95     89.65
> 03:59:43 AM      5.32      0.00     43.47      0.73
> 04:02:03 AM     -4.74      0.00      3.86      0.13
> 04:04:30 AM   5013.36      0.00   -111.62  -4181.22
> 04:05:30 AM   5962.68      0.00  -2647.12  -3293.55
> 04:06:30 AM     -8.10      0.00      0.02      6.50
>
> 3. sar -f sa09 -b
>
> 03:53:43 AM       tps      rtps      wtps   bread/s   bwrtn/s
> 03:54:43 AM    161.52    156.32      5.20   3156.67    119.60
> 03:55:43 AM    148.37    129.35     19.02   1034.80    377.33
> 03:56:43 AM    146.32    128.48     17.83   2732.80    360.40
> 03:57:43 AM    107.32     84.62     22.70   3743.60    447.07
> 03:58:43 AM     91.73     82.03      9.70   1312.40    194.80
> 03:59:43 AM     75.62     54.22     21.40    433.73    350.00
> 04:02:03 AM      4.97      4.83      0.14     38.65      1.24
> 04:04:30 AM     82.68      9.44     73.24     78.45    958.39
> 04:05:30 AM      2.93      0.00      2.93      0.00     29.33
> 04:06:30 AM      0.22      0.00      0.22      0.00      1.73
>
> 4. sar -f sa09 -i
>
> 03:53:43 AM dentunusd   file-sz  %file-sz  inode-sz  super-sz %super-sz
> dquot-sz %dquot-sz  rtsig-sz %rtsig-sz
> 03:54:43 AM     57361       134      0.01     61318         0      0.00
> 0      0.00         0      0.00
> 03:55:43 AM     58318       124      0.01     62006         0      0.00
> 0      0.00         0      0.00
> 03:56:43 AM     44384       135      0.01     47145         0      0.00
> 0      0.00         0      0.00
> 03:57:43 AM     42565       135      0.01     45983         0      0.00
> 0      0.00         0      0.00
> 03:58:43 AM     18901       134      0.01     22408         0      0.00
> 0      0.00         0      0.00
> 03:59:43 AM       607       135      0.01      1173         0      0.00
> 0      0.00         0      0.00
> 04:02:03 AM 4294967295       113      0.01       417         0
> 0.00  0      0.00         4      0.39
> 04:04:30 AM        49       247      0.02      6316         0      0.00
> 0      0.00         0      0.00
> 04:05:30 AM       121       311      0.03       365         0      0.00
> 0      0.00         0      0.00
>
> 5. sar -f sa09 -u
>
> 03:53:43 AM       CPU     %user     %nice   %system     %idle
> 03:54:43 AM       all      7.52      0.00     25.15     67.33
> 03:55:43 AM       all      8.97      0.00     25.28     65.75
> 03:56:43 AM       all      6.07      0.00     23.82     70.11
> 03:57:43 AM       all      5.08      0.00     23.54     71.38
> 03:58:43 AM       all      6.77      0.00     22.88     70.36
> 03:59:43 AM       all      7.18      0.00     25.82     67.00
> 04:02:03 AM       all      0.77      0.00     96.32      2.91
> 04:04:30 AM       all      4.20      0.00     95.11      0.69
> 04:05:30 AM       all      1.88      0.00      5.29     92.83
> 04:06:30 AM       all      2.01      0.00      2.81     95.18
>
> Russell Coker wrote:
> >I have a server with 4G of RAM running ReiserFS for everything that
> > matters.
> >
> >It has 2G of swap space free, but so far I have not seen swap usage go
> > above 1.6M (so in normal use I could turn off swap entirely and expect
> > not to see much difference).
> >
> >When it's under really heavy load (when I have a maintenance task
> > involving a "find /" and there are lots of POP/IMAP clients hitting the
> > server as well as mail delivery) and the load average gets to about 40,
> > the "kswapd" kernel thread starts using excessive CPU time.  It will stay
> > on ~4% but have spikes of up to 45%!!!  This is a two-processor machine
> > so 45% CPU reported by top means 90% of a single CPU I guess.  90% of a
> > 1.8GHz P4 CPU is a lot of CPU and I think that something is wrong.
> >
> >In the meager documentation in the kernel source kswapd is described as
> > being involved in paging to disk.  I don't think that this is what it is
> > doing as there is no noticable paging activity (it generally has at least
> > 600M of "buffers" so there is no real shortage of memory).
> >
> >Would the activity of kswapd be involved with ReiserFS in any way?  What
> > can I do to improve this situation?

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

