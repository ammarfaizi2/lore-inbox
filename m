Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSAOQno>; Tue, 15 Jan 2002 11:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288338AbSAOQne>; Tue, 15 Jan 2002 11:43:34 -0500
Received: from moutng0.kundenserver.de ([212.227.126.170]:27079 "EHLO
	moutng0.schlund.de") by vger.kernel.org with ESMTP
	id <S286447AbSAOQn0>; Tue, 15 Jan 2002 11:43:26 -0500
Message-ID: <3C445BFC.E373EA04@m3its.de>
Date: Tue, 15 Jan 2002 17:42:36 +0100
From: Klaus Meyer <k.meyer@m3its.de>
Organization: m3ITS
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: highmem=system killer, 2.2.17=performance killer ?
In-Reply-To: <3C439E6D.B2B8C5B8@m3its.de> <20020115160018.18793569.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> 
> On Tue, 15 Jan 2002 04:13:49 +0100
> Klaus Meyer <k.meyer@m3its.de> wrote:
> 
> > i've got serious problems using 2.4.x kernels using highmem support.
> > It seems to me that i'm not the only one, but the difference to most
> > other ones is,
> > that i can't use highmem because the system performance is terrible
> > slow.
> >
> > the testbed:
> > 1) Asus CUR-DLS (Server Set LE III) with two 1Ghz Pentiums, 2GB of ram
> 
> Interestingly I have about the same setup and use, only I transfer about 25 GB
> a day via nfs to an Asus CUV4XD with 2 GB under 2.4.18-pre3 and do not
> experience any problem so far. I haven't had any with 2.4.17, too. Cache is
> pretty heavy used, but I experience no slowdown or other weird things. Can this
> be somehow chipset related? Maybe something about the DGE cards? I am using TP
> 100MBit tulip-based.
> 

I dont think that the network driver is the one who causes problems,
because the throughput is very nice, if i limit the memory to 1GB by
hand.
if files are in the cache I'm even getting a throughput of nearly 60
MB/S (using udp) !
(but sorry, not with kernel 2.2.17 => network throuput decreases
significantly)
The whole system is running quite stable and pretty fast using only 1GB
of mem.
Probably somebody can explain the difference what will happen if i have
a kernel
with highmem support (4GB or 64GB) compiled in, but using only 1GB  of
physically 2GB?
Is the kernel aware how to use highmem in this case ?
it seems to be that only a small amount of highmem will be used in this
case:

cat /proc/meminfo reads:
HighTotal:      131072 kB
HighFree:       115628
kB                                                                                                           

As I just took a look on the output of cat /proc/meminfo i got the idea
that i'll increase the pysical swap space. (136M before that means >
highmem).
astonishing (using Suse kernel 2.4.16): after an increase to 2GB swap
and
using 1,5GB of mem the system runs quit a longer time with a good
performance,
but starting the copy process leads also to a slow down of the machine.
Finally i could see that kupdated is suffering.

-----------------------------------------------------------------------------
  5:56pm  up 2 min,  1 user,  load average: 2.97, 1.02, 0.36
34 processes: 29 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states:  2.5% user, 96.0% system,  0.0% nice,  1.0% idle
CPU1 states: 11.4% user, 95.0% system,  0.0% nice, -6.-5% idle
Mem:  1545456K av,  452480K used, 1092976K free,       0K shrd,   19708K
buff
Swap: 2097136K av,       0K used, 2097136K free                  400732K
cached
 
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      15   0     0    0     0 RW   81.2  0.0   0:44
kupdated                                                              
------------------------------------------------------------------------------

As kupdated finished his work, the system was quite usefull and came
back to a
much more better performance.

Using the avail. 2 GB of ram led to the same effect.

So whats the relation between physical swap space and highmem and
physical memory 
(and the chipset) ?

testing this configuration with the offical kernel 2.4.17 falls back to 
the known slow down.

It seems to be Suse has applied some patches or back porting ?!?

regards, Klaus
