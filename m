Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSLYVPi>; Wed, 25 Dec 2002 16:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSLYVPi>; Wed, 25 Dec 2002 16:15:38 -0500
Received: from comtv.ru ([217.10.32.4]:17298 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261322AbSLYVPg>;
	Wed, 25 Dec 2002 16:15:36 -0500
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] fast access to process list
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 26 Dec 2002 00:15:56 +0300
Message-ID: <m3of796bqr.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Look how long is following command on system with 3000 processes.

root@zefir:~# time bash -c 'let i=0; while let "i<10"; do ps axl; let "i=i+1"; done>/dev/null'

real    0m10.380s
user    0m5.511s
sys     0m4.870s

Ie, ten ps'es eat 10 secs and system had no active processes at all.

I really don't like it. Therefore, I started to implement own chardev driver
with own tool (I call it 'fast ps'). Look how long it needs:

root@zefir:~/fastps# time bash -c 'let i=0; while let "i<10"; do ./fps l; let "i=i+1"; done>/dev/null'

real    0m0.992s
user    0m0.620s
sys     0m0.372s


Of course, the tool isn't ready yet, but things change ... Here is output of fast ps:

[root@lexx fastps]# ./fps -l
F   UID   PID   PPID  PRI NI  VSIZE RSS   WCHAN  STAT TTY      TIME  COMMAND  
100     0     1     0  29   0  1372   424 do_sel S    ?         0:08 init [5] 
040     0     2     1  30   0     0     0 contex S    ?         0:07 keventd  
040     0     3     1  30   0     0     0 apm_ma S    ?         0:00 kapmd    
040     0     4     1  40  19     0     0 ksofti SN   ?         0:03 ksoftirqd
840     0     5     1  30   0     0     0 kswapd S    ?         0:05 kswapd   
040     0     6     1  30   0     0     0 bdflus S    ?         0:00 bdflush  
040     0     7     1  30   0     0     0 kupdat S    ?         0:00 kupdated 
040     0    11     1  30   0     0     0 end    S    ?         0:01 kjournald
040     0    90     1  30   0     0     0 end    S    ?         0:00 khubd    
040     0   191     1  30   0     0     0 end    S    ?         0:03 kjournald
040     0   462     1  30   0  1428   492 do_sel S    ?         0:00 syslogd -
140     0   467     1  30   0  1364   428 do_sys S    ?         0:00 klogd -x 
140    32   487     1  30   0  1512   452 do_pol S    ?         0:00 portmap  
140     0   517     1  30   0  1696   524 do_pol S    ?         0:00 rpc.mount
140     0   522     1  30   0     0     0 end    S    ?         0:00 nfsd     
140     0   523     1  30   0     0     0 end    S    ?         0:01 nfsd     
040     0   524     1  30   0     0     0 end    S    ?         0:00 lockd    
040     0   525   524  30   0     0     0 end    S    ?         0:00 rpciod   
140     0   636     1  30   0  1488   440 do_sel S    ?         0:00 /sbin/car
140     0   654     1  29   0  1360   412 do_sel S    ?         0:00 /usr/sbin
140     0   723     1  29   0  2620   652 do_sel S    ?         0:00 /usr/sbin
140     0   743     1  30   0  1536   536 nanosl S    ?         0:00 crond    
040     0   761     1  30   0  1404   464 nanosl S    ?         0:00 /usr/sbin
100     0   778     1  30   0  1344   336 read_c S    tty1      0:00 /sbin/min
100     0   779     1  30   0  3212   644 do_sel S    ?         0:00 /usr/X11R
040     0  5499     1  30   0     0     0 end    S    ?         0:00 kjournald
100     0 20899   779  38   0 25260 10052 -      R    ?         8:57 /usr/X11R

At this moment, I have patches against 2.4.20 and 2.5.53. You may find tarball
at http://tmi.comex.ru/fastps.tgz.

I would love to hear any comments/suggestions!



with best regards, Alex

