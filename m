Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267220AbRGTSvx>; Fri, 20 Jul 2001 14:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbRGTSvn>; Fri, 20 Jul 2001 14:51:43 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:30675 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S267220AbRGTSv3>; Fri, 20 Jul 2001 14:51:29 -0400
Date: Fri, 20 Jul 2001 14:49:56 -0400 (EDT)
From: Dirk Wetter <dirkw@rentec.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Dave McCracken <dmc@austin.ibm.com>
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <Pine.LNX.4.21.0107182037410.8813-100000@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.30.0107201423450.21688-100000@sciurus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hey Marcelo,

thx for your great work! our 4gb system are working way better
now. i am running ac5 (without your inactive_plenty() patch
on top of that) on allmost all (see below) of our big boxes.

also, it looks like the CPU affinity thing bought us also a little
something as far as i was told, which is surprising to me, since we
run normally 2 jobs on the big 4GB SMP machines.

typically top is now like on an ac5 kernel:

18:55pm  up 1 day, 12:34,  3 users,  load average: 2.08, 2.04, 2.00
64 processes: 60 sleeping, 3 running, 1 zombie, 0 stopped
CPU0 states: 87.0% user, 12.0% system, 87.1% nice,  0.0% idle
CPU1 states: 88.0% user, 11.2% system, 88.0% nice,  0.0% idle
Mem:  4057200K av, 3983816K used,   73384K free,       0K shrd,    2524K buff
Swap: 14337736K av, 1230256K used, 13107480K free                  270296K cached

  PID USER     PRI  NI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMAND
19038 usersid   15   4 2328M 470M 1.8G  214M  0M R N  89.4 46.8 463:07 ceqsim
19048 usersid   15   4 2328M 469M 1.8G  214M  0M R N  88.5 46.9 462:45 ceqsim
17925 usersid    9   0   824   40  784   592  49 S    11.9  0.0  30:31 top
24257 dirkw     14   0  1056    0 1056   828  57 R    11.9  0.0   0:01 top
    1 root       8   0    76   12   64    64   4 S     0.0  0.0   0:22 init
    2 root       8   0     0    0    0     0   0 SW    0.0  0.0   0:00 keventd
    3 root      19  19     0    0    0     0   0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    4 root      19  19     0    0    0     0   0 SWN   0.0  0.0   0:00 ksoftirqd_CPU1
    5 root       9   0     0    0    0     0   0 SW    0.0  0.0  59:12 kswapd
    6 root       9   0     0    0    0     0   0 SW    0.0  0.0  14:10 kreclaimd
    7 root       9   0     0    0    0     0   0 SW    0.0  0.0   0:12 bdflush
    8 root       9   0     0    0    0     0   0 SW    0.0  0.0   1:16 kupdated

sar reports the system time - with some exceptions- to be better than top
does:

08:00:01          CPU     %user     %nice   %system     %idle
[..]
12:40:02          all      0.05     95.56      3.22      1.17
13:00:01          all      0.05     83.96     14.66      1.32
13:20:01          all      0.07     97.22      1.44      1.27
13:40:01          all      0.34     45.45     10.11     44.10
14:01:34          all      0.12      2.07     90.87      6.94
14:21:34          all      0.10      0.00     94.67      5.23
14:41:34          all      0.37     13.97      8.11     77.55
15:00:00          all      0.13     73.42      7.48     18.97
15:20:00          all      0.14     92.57      4.84      2.44
15:40:00          all      0.15     94.93      4.26      0.65
16:00:02          all      0.14     93.31      4.44      2.12
16:20:02          all      0.14     93.74      4.18      1.94
16:40:02          all      0.15     94.26      4.28      1.31
17:00:04          all      0.13     94.68      4.27      0.92
17:20:04          all      0.14     92.51      4.50      2.85
17:40:04          all      0.14     93.75      4.42      1.69
18:00:07          all      0.13     90.18      4.59      5.11
18:20:07          all      0.14     93.77      4.19      1.90
18:40:07          all      0.12     91.83      3.99      4.06

also i added the swap_state/GFP_HIGHUSER fix from Dave McCracken.
according to the poor statistics i have - two overnight jobs
only - my impression is that this helped, too (i think that were
the exactly same jobs as above):

[..]
03:20:01          all      0.05     93.49      2.22      4.23
03:40:01          all      0.06     96.98      1.72      1.24
04:00:01          all      0.06     95.08      1.79      3.07
04:20:01          all      0.05     96.95      1.22      1.78
04:40:01          all      0.06     94.59      1.56      3.79
05:00:01          all      0.06     94.37      1.86      3.71
05:20:01          all      0.06     96.32      1.32      2.30
05:40:01          all      0.06     94.62      1.84      3.48
06:00:02          all      0.07     96.17      1.42      2.34
06:20:02          all      0.06     94.17      1.61      4.15
06:40:02          all      0.06     96.46      1.92      1.56
07:00:01          all      0.05     92.75      1.53      5.67
07:20:01          all      0.05     95.25      1.67      3.03
07:40:01          all      0.05     94.34      1.97      3.65
08:00:00          all      0.05     94.93      1.20      3.81

08:00:00          CPU     %user     %nice   %system     %idle
08:20:00          all      0.06     93.97      1.83      4.14
08:40:00          all      0.16     96.57      1.67      1.60
09:00:01          all      0.06     94.15      1.49      4.30
09:20:01          all      0.06     95.71      1.67      2.56
09:40:01          all      0.07     95.04      1.89      3.00


i haven't got your patched vmstat running yet. i guess i'll do that
later and send in the logs. also the rsync/[di]cache issue i saw
previously needs some attention and log collection on my side.

forget about the pm i sent you yesterday, i found out myself ;) that
2.4.7-pre8 doesn't include any of your recent vm patches :-( (i am not
subscribed to lkml). the zoned patch however applies clean also to
the 2.4.7-pre8-xfs kernel i am using on one particular machine.

i am leaving in a very few hours, catching my plane back home :)
according to the major kernel improvements for us achieved during
the last 1.5 weeks, to extrapolating things, i suspect to read
next week something about Linux' world domination in every
newspaper ;-) ok, i won't be disappointed if that's not going to
happen, i can still solace myself with good german beer. :))


cheers & thx guys!

	~dirkw



On Wed, 18 Jul 2001, Marcelo Tosatti wrote:

>
>
> On Wed, 18 Jul 2001, Rik van Riel wrote:
>
> > Hi Alan, Linus,
> >
> > Dave found a stupid bug in the swapin code, leading to
> > bad balancing problems in the VM.
> >
> > I suspect marcelo's zone VM hack could even go away
> > with this patch applied ;)
>
> Rik,
>
> Still able to trigger the problem with the GFP_HIGHUSER patch applied.
>
>
>

