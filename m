Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSGWToc>; Tue, 23 Jul 2002 15:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSGWToc>; Tue, 23 Jul 2002 15:44:32 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29738 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318190AbSGWTob>; Tue, 23 Jul 2002 15:44:31 -0400
Date: Tue, 23 Jul 2002 21:48:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
Message-ID: <20020723194826.GH1117@dualathlon.random>
References: <20020719170359.E28941@sventech.com> <Pine.LNX.4.33.0207191722260.6698-100000@coffee.psychology.mcmaster.ca> <20020719174521.F28941@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719174521.F28941@sventech.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 05:45:21PM -0400, Johannes Erdfelt wrote:
> On Fri, Jul 19, 2002, Mark Hahn <hahn@physics.mcmaster.ca> wrote:
> > > > >    procs                      memory    swap          io     system  cpu
> > > > >  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> > > > >  3  0  0 106036 502288  10812  67236   0   0     0     0  802   494  46  37  17
> > > > >  5  0  2 106032 476188  10844  91496   0   0     4   316  905   573  54  37   8
> > > > > 16  0  2 106032 355400  10844 203880   0   0     4     0  909   540  51  49   0
> > > > > 10  0  2 106024 340108  10852 221548   0   0    28     0  975   659  36  64   0
> > > > >  0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
> > > > >  0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14  77
> > ..
> > > What's really odd in the vmstat output is the fact that there is no disk
> > > I/O that follows these wild swings. Where is this cache memory coming
> > > from? Or is the accounting just wrong?
> > 
> > you're right, the jump up makes no sense.  if fork was increasing cached-page
> > counters even for cloned pages, that might explain it (and be a bug).
> 
>    procs                      memory    swap          io     system  cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> 12  0  1 151664 365212  11216 201528  12   0    96     0  747   557  37  62   1
>  7  0  1 151540 425468  11216 146308   0   0     0     0  904   620  45  55   0
>  0  0  0 151540 540884  11216  37828   0   0     8     0  593   376  12  32  57
>  2  0  0 151528 533160  11240  44264   0   0     0   284  511   379  14  20  66
>  0  0  0 151496 540380  11240  37860   8   0    36     0  555   406  16  11  73
>  0  0  0 151496 540296  11240  37928   0   0    60     0  438   341  19  45  36
>  0  0  0 151464 540124  11244  37996   0   0    64     0  408   296   9  2  89
>  3  0  0 151456 503868  11252  71840   0   0    52     0  630   434  29  32  39
> 15  0  1 151344 416060  11284 151764   8   0    32   296  854   568  50  47   2
> 19  0  1 151296 335576  11284 226012   0   0     0     0  830   584  49  51   0
> 20  0  1 151208 286524  11284 268620   0   0     0     0  980   593  60  40   0
> 10  0  1 150652 451832  11324 119612  16   0   268   272 4815  3162  39  61   0
> 13  0  4 149660 475196  11348  93836  28   0    68   292 1178   889  51  39  10
> 15  0  1 149252 105568  11412 447892 116   0   648   284 5491  3849  40  60   0
>  6  0  0 149252 536052  11424  39132   0   0    56     0  700   527  15  80   5
>  5  0  1 149072 487304  11436  84188   8   0   108     0  966   648  47  52   1
>  3  0  0 148984 485116  11440  87760  32   0   100     0  749   512  39  61   0
>  0  0  0 148932 536436  11468  39324   0   0    24   304  593   385  19  13  68
> 
> It's constantly happening too. Like every couple of minutes.
> 
> Andrea, any idea what the cause of these fluctuations are?

shared memory? it looks all right. Please try to monitor the shm usage
as root with ipcs and ls -l /dev/shm.

Andrea
