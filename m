Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSDOA2S>; Sun, 14 Apr 2002 20:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312556AbSDOA2R>; Sun, 14 Apr 2002 20:28:17 -0400
Received: from amethyst.es.usyd.edu.au ([129.78.124.28]:4287 "EHLO
	amethyst.es.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S312529AbSDOA2P>; Sun, 14 Apr 2002 20:28:15 -0400
Date: Mon, 15 Apr 2002 10:28:00 +1000 (EST)
From: ivan <ivan@es.usyd.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Memory Leaking. Help!
In-Reply-To: <E16wu4J-00057Y-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204151017480.20961-100000@dipole.es.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Alan Cox wrote:

> > > totally mislead by it. Named for example will grow and shrink over time 
> > > according to what it has cached and what people asked for.
> > 
> > But it took half of my swap (4GB) as well. A bit too much 
> > for a little bind. How to explain this?
> 
> 2Gb seems a bit odd - are you sure bind is the one that ate it ?

That was 4 GB not 2.

 No, I do not. That is why I asked is there a way to find out what is 
eating ram. I am not sure if this a leakage. I am only a paranoid 
sysadmin. 


 
> What does ps -aux imply has all the memory ?

Top at 9am showed 3.2GB of availabe memory.

Top at 10am showed 2.3Gb of available memory

This top at 11am
10:19am  up 13:23,  6 users,  load average: 0.07, 0.03, 0.01
143 processes: 142 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  5.0% system,  0.0% nice, 94.0% idle
CPU1 states:  0.0% user,  1.0% system,  0.0% nice, 98.0% idle
Mem:  3799080K av, 2215132K used, 1583948K free,    1580K shrd,  377916K 
buff
Swap: 8192992K av,       0K used, 8192992K free                 1515392K 
cached

Mashine is doing NFS and DNS, not much load?

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1388  524 ?        S    Apr14   0:03 init
root         2  0.0  0.0     0    0 ?        SW   Apr14   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Apr14   0:00 
[ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SWN  Apr14   0:00 
[ksoftirqd_CPU1]
root         5  0.0  0.0     0    0 ?        SW   Apr14   0:05 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kreclaimd]
root         7  0.0  0.0     0    0 ?        SW   Apr14   0:01 [bdflush]
root         8  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kupdated]
root         9  0.0  0.0     0    0 ?        SW<  Apr14   0:00 
[mdrecoveryd]
root        16  0.0  0.0     0    0 ?        SW   Apr14   0:00 [aacraid]
root        19  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       102  0.0  0.0     0    0 ?        SW   Apr14   0:00 [khubd]
root       200  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       201  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       202  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       203  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       204  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       205  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       206  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       207  0.0  0.0     0    0 ?        SW   Apr14   0:01 [kjournald]
root       208  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
root       611  0.0  0.0  1452  596 ?        S    Apr14   0:00 syslogd -m 
0
root       616  0.0  0.0  2000 1140 ?        S    Apr14   0:00 klogd -2
rpc        636  0.0  0.0  1544  656 ?        S    Apr14   0:00 portmap
rpcuser    664  0.0  0.0  1596  768 ?        S    Apr14   0:00 rpc.statd
root       760  0.0  0.0     0    0 ?        SW   Apr14   0:00 [kjournald]
ntp        780  0.0  0.0  1900 1892 ?        SL   Apr14   0:00 ntpd -U ntp
root       849  0.0  0.0  1496  636 ?        S    Apr14   0:00 
/usr/sbin/automou
root       865  0.0  0.0  1500  640 ?        S    Apr14   0:00 
/usr/sbin/automou
daemon     890  0.0  0.0  1424  580 ?        S    Apr14   0:00 
/usr/sbin/atd
named      908  0.0  0.1 13956 3988 ?        S    Apr14   0:00 named -u 
named
named      910  0.0  0.1 13956 3988 ?        S    Apr14   0:00 named -u 
named
named      911  0.0  0.1 13956 3988 ?        S    Apr14   0:00 named -u 
named
named      912  0.0  0.1 13956 3988 ?        S    Apr14   0:00 named -u 
named
named      913  0.0  0.1 13956 3988 ?        S    Apr14   0:00 named -u 
named
named      914  0.0  0.1 13956 3988 ?        S    Apr14   0:00 named -u 
named
root       934  0.0  0.0  2652 1248 ?        S    Apr14   0:01 
/usr/sbin/sshd
root       967  0.0  0.0  2296 1040 ?        S    Apr14   0:00 xinetd 
-stayalive
lp         991  0.0  0.0  2560  984 ?        S    Apr14   0:00 lpd Waiting  
root      1021  0.0  0.0  1776  636 ?        S    Apr14   0:00 rpc.rquotad
root      1026  0.0  0.0  2012 1164 ?        S    Apr14   0:00 rpc.mountd
root      1031  0.0  0.0     0    0 ?        SW   Apr14   0:02 [nfsd]
root      1032  0.0  0.0     0    0 ?        SW   Apr14   0:02 [nfsd]
root      1033  0.0  0.0     0    0 ?        SW   Apr14   0:02 [nfsd]
root      1034  0.0  0.0     0    0 ?        SW   Apr14   0:02 [nfsd]
root      1035  0.0  0.0     0    0 ?        SW   Apr14   0:02 [nfsd]
root      1036  0.0  0.0     0    0 ?        SW   Apr14   0:02 [nfsd]
root      1037  0.0  0.0     0    0 ?        SW   Apr14   0:02 [nfsd]
root      1038  0.0  0.0     0    0 ?        SW   Apr14   0:02 [nfsd]
root      1039  0.0  0.0     0    0 ?        SW   Apr14   0:00 [lockd]
root      1040  0.0  0.0     0    0 ?        SW   Apr14   0:00 [rpciod]
root      1046  0.0  0.0  3844 1580 ?        S    Apr14   0:00 amd -F 
/etc/amd.c
root      2202  0.0  0.0  1384  480 ?        S    Apr14   0:00 
/opt/win4lin/bin/
root      2254  0.0  0.0  1416  484 ?        S    Apr14   0:00 gpm -t ps/2 
-m /d
root      2272  0.0  0.0  1572  684 ?        S    Apr14   0:00 crond
xfs       2332  0.0  0.1  5520 4228 ?        S    Apr14   0:00 xfs 
-droppriv -da
root      2358  0.0  0.0  2596  948 ?        S    Apr14   0:00 
/usr/sbin/nsrexec
root      2368  0.0  0.0  2564 1196 ?        S    Apr14   0:00 
/usr/sbin/nsrexec
root      2374  0.0  0.0  8840  852 ?        S    Apr14   0:00 
/usr/bin/sdaemon
root      2375  0.0  0.0  8840  852 ?        S    Apr14   0:00 
/usr/bin/sdaemon
root      2378  0.0  0.0  2320 1132 tty1     S    Apr14   0:00 login -- 
root    
root      2379  0.0  0.0  1360  440 tty2     S    Apr14   0:00 
/sbin/mingetty tt
root      2380  0.0  0.0  1360  440 tty3     S    Apr14   0:00 
/sbin/mingetty tt
root      2381  0.0  0.0  1360  440 tty4     S    Apr14   0:00 
/sbin/mingetty tt
root      2382  0.0  0.0  1360  440 tty5     S    Apr14   0:00 
/sbin/mingetty tt
root      2383  0.0  0.0  1360  440 tty6     S    Apr14   0:00 
/sbin/mingetty tt
root      2754  0.0  0.0  1408  496 ?        SN   Apr14   0:41 free -b -s 
30 -o
root      4357  0.0  0.0  3400 1860 ?        S    07:46   0:02 
/usr/sbin/sshd
root      4359  0.0  0.0  2436 1320 pts/1    S    07:47   0:00 -bash
root      4459  0.1  0.0  3656 2028 ?        S    08:04   0:15 
/usr/sbin/sshd
root      4462  0.0  0.0  2440 1320 pts/2    S    08:04   0:00 -bash
root      5610  0.0  0.0  2440 1308 tty1     S    09:34   0:00 -bash
root      5757  0.0  0.0  2204  972 tty1     S    09:36   0:00 /bin/sh 
/usr/X11R
root      5764  0.0  0.0  2420  672 tty1     S    09:36   0:00 xinit 
/etc/X11/xi
root      5765  0.2  0.2 17664 10584 ?       S<   09:36   0:07 /etc/X11/X 
:0
root      5768  0.0  0.1  7176 4004 tty1     S    09:36   0:00 
/usr/bin/gnome-se
root      5787  0.0  0.0  6268 2084 ?        S    09:36   0:00 
gnome-smproxy --s
root      5791  0.0  0.0  5776 3584 ?        S    09:36   0:01 sawfish 
--sm-clie
root      5816  0.0  0.0  7120 3220 ?        S    09:36   0:00 magicdev 
--sm-cli
root      5818  0.0  0.2 40124 11068 ?       S    09:36   0:01 nautilus 
start-he
root      5820  0.0  0.1  8652 5252 ?        S    09:36   0:00 panel 
--sm-client
root      5826  0.0  0.0  3276 1276 ?        S    09:36   0:00 
gnome-name-servic
root      5829  0.0  0.0  3936 2348 ?        S    09:36   0:00 oafd 
--ac-activat
root      5834  0.0  0.0  3236 1696 ?        S    09:36   0:00 gconfd-1 
--oaf-ac
root      5838  0.0  0.2 40124 11068 ?       S    09:36   0:00 nautilus 
start-he
root      5839  0.0  0.2 40124 11068 ?       S    09:36   0:00 nautilus 
start-he
root      5840  0.0  0.2 40124 11068 ?       S    09:36   0:00 nautilus 
start-he
root      5842  0.0  0.1  7596 3972 ?        S    09:36   0:00 
tasklist_applet -
root      5844  0.0  0.1  7520 3904 ?        S    09:36   0:00 
deskguide_applet 
root      5847  0.0  0.0  7508 3696 ?        S    09:36   0:00 
multiload_applet 
root      5853  0.0  0.1 12088 5740 ?        S    09:36   0:00 
nautilus-throbber
root      5859  0.0  0.1 13444 7160 ?        S    09:37   0:00 hyperbola 
--oaf-a
root      5861  0.0  0.1 12072 5800 ?        S    09:37   0:00 
nautilus-history-
root      5863  0.0  0.1 12352 6336 ?        S    09:37   0:00 
nautilus-news --o
root      5865  0.0  0.1 12036 5620 ?        S    09:37   0:00 
nautilus-notes --
root      5879  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5880  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5881  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5882  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5885  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5889  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5890  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5893  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5895  0.0  0.1  8320 4496 ?        S    09:37   0:00 
gnome-terminal --
root      5896  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5897  0.0  0.2 40124 11068 ?       S    09:37   0:00 nautilus 
start-he
root      5899  0.0  0.0  1424  568 ?        S    09:37   0:00 
gnome-pty-helper
root      5900  0.0  0.0  2516 1380 pts/5    S    09:37   0:00 bash
root      6135  0.0  0.0  2512 1352 pts/6    S    09:38   0:00 bash
root      6158  0.0  0.0  2832 1676 pts/6    S    09:38   0:00 slogin 
eos14 -l r
root      6807  0.1  0.3 20780 14908 pts/5   S    09:39   0:02 
/opt/acrobat/Read
root      6834  0.2  0.3 19932 14248 pts/2   S    09:45   0:07 
/opt/acrobat/Read
root      7048  5.0  0.0  3420 1960 ?        S    10:26   0:00 
/usr/sbin/sshd
scottd    7052  1.2  0.0  2796 1548 ?        S    10:26   0:00 
/usr/bin/perl /us
scottd    7055  6.2  0.0 52052 1768 ?        S    10:26   0:00 
/opt/win4lin/publ
scottd    7310 71.0  0.1 50068 4380 ?        R    10:26   0:01 
/opt/win4lin/publ
scottd    7311  0.0  0.0 25960  392 ?        S    10:26   0:00 auserver 
0x0 0x8 
scottd    7312  4.5  0.0  5464 2544 ?        S    10:26   0:00 
/opt/win4lin/xcrt
root      7313  0.0  0.0  2828  900 pts/2    R    10:26   0:00 ps -aux


-- 

There's an old story about the person who wished his computer were as
 easy to use as his telephone. That wish has come true, since I no
 longer know how to use my telephone.

================================================================================

Ivan Teliatnikov,
F05 David Edgeworth Building,
Department of Geology and Geophysics,
School of Geosciences,
University of Sydney, 2006
Australia

e-mail: ivan@es.usyd.edu.au
ph:  061-2-9351-2031 (w)
fax: 061-2-9351-0184 (w)

===============================================================================

