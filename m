Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSC3Xt1>; Sat, 30 Mar 2002 18:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293495AbSC3XtJ>; Sat, 30 Mar 2002 18:49:09 -0500
Received: from gw.wmich.edu ([141.218.1.100]:23257 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S293458AbSC3Xss>;
	Sat, 30 Mar 2002 18:48:48 -0500
Subject: Re: Linux 2.4.19-pre5
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Randy Hron <rwhron@earthlink.net>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <E16rRCX-00068U-00@avocet.prod.itd.earthlink.net>
Content-Type: multipart/mixed; boundary="=-5UjxPQ7X7KUaeemdfZJB"
X-Mailer: Ximian Evolution 1.0.3 
Date: 30 Mar 2002 18:48:35 -0500
Message-Id: <1017532120.641.75.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5UjxPQ7X7KUaeemdfZJB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Due to evolution's really cool way of wrapping my emails. . i'll attach
the results.   

In this test I wanted to see this lag.  So i switched between virtual
desktops (i have 5) and used irc (eterm + epic).   What i saw was lower
priority (meaning processes with bigger nice values) at one specific
spot in the test would stop responding but all processes at the same
priority level would continue merrily.  I'd say about 5/6 of the way
through the test is where the lower priority processes would stop
responding for a couple seconds.  But they revived pretty quickly, only
paused my typing for a couple moments.  I failed to see any lag at all
during the entire test on like-wise prioritized processes.  I wouldn't
have even known i was running the test if my cpu temp wasn't climbing so
high and the load wasn't 256 on procmeter3.  


As for the throughput debate that always follows the preempt kernel.  I
think it really depends on the kind of io you're doing.  It really
depends on what the program is trying to do with it's io.  
Programs that want to throttle and like to do that sequentially,
probably wont appretiate you stopping it and reading some other part of
the disk for a bit and have it have to go back to where it stopped. 
Almost no userland non-monolithic database apps actually do something
like that.  None that i've come into contact with.  But you choose what
works for your workload.   if i'm running a app that wants control over
the io to itself, i run it with a higher priority than other processes
and you've basically taken away the "preemptiveness" factor and you get
normal kernel performance (theoretically).  seems logical.   

Anyway I digress.   I mean to get into the latency aspect.  Sequential
writes is scary but that's to be expected on ext3.  Random reads is a
concern though.   It shouldn't be that high.  although it was high in
all the tests i ran compared to the other three.    

--=-5UjxPQ7X7KUaeemdfZJB
Content-Disposition: attachment; filename=ed_tiotest.text
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ed_tiotest.text; charset=ANSI_X3.4-1968

Run #2: /usr/bin/tiotest -t 256 -f 8 -r 15 -b 4096 -d . -T   =20

File size in megabytes, Blk Size in bytes.=20
Read, write, and seek rates in MB/sec.=20
Latency in milliseconds.
Percent of requests that took longer than 2 and 10 seconds.

Sequential Reads
                              File  Blk   Num                    Avg       =
Maximum     Lat%     Lat%    CPU
Kernel                        Size  Size  Thr   Rate  (CPU%)   Latency     =
Latency      >2s     >10s    Eff
---------------------------- ------ ----- ---  ----------------------------=
--------------------------------
2.4.19-pre4-ac3-preempt       2048  4096  256    9.46 5.271%   181.668    3=
0992.77   3.60280  0.05836   179

Random Reads
                              File  Blk   Num                    Avg       =
Maximum     Lat%     Lat%    CPU
Kernel                        Size  Size  Thr   Rate  (CPU%)   Latency     =
Latency      >2s     >10s    Eff
---------------------------- ------ ----- ---  ----------------------------=
--------------------------------
2.4.19-pre4-ac3-preempt       2048  4096  256    0.67 0.980%  2446.793    1=
4462.86  39.66145  0.00000    68

Sequential Writes
                              File  Blk   Num                    Avg       =
Maximum     Lat%     Lat%    CPU
Kernel                        Size  Size  Thr   Rate  (CPU%)   Latency     =
Latency      >2s     >10s    Eff
---------------------------- ------ ----- ---  ----------------------------=
--------------------------------
2.4.19-pre4-ac3-preempt       2048  4096  256    5.36 5.029%   160.584   20=
9853.98   0.42915  0.37536   107

Random Writes
                              File  Blk   Num                    Avg       =
Maximum     Lat%     Lat%    CPU
Kernel                        Size  Size  Thr   Rate  (CPU%)   Latency     =
Latency      >2s     >10s    Eff
---------------------------- ------ ----- ---  ----------------------------=
--------------------------------
2.4.19-pre4-ac3-preempt       2048  4096  256    0.67 0.533%     0.047     =
   4.50   0.00000  0.00000   125

--=-5UjxPQ7X7KUaeemdfZJB--

