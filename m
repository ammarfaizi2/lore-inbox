Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268061AbTBYRBk>; Tue, 25 Feb 2003 12:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268050AbTBYRBk>; Tue, 25 Feb 2003 12:01:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16566 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268091AbTBYRBh>;
	Tue, 25 Feb 2003 12:01:37 -0500
Message-Id: <200302251711.h1PHBct16624@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cliffw@osdl.org
Subject: Re: Minutes from Feb 21 LSE Call 
In-Reply-To: Message from "Martin J. Bligh" <mbligh@aracnet.com> 
   of "Mon, 24 Feb 2003 22:17:05 PST." <13760000.1046153824@[10.10.2.4]> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Feb 2003 09:11:38 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> _If_ it harms performance on small boxes.
> > 
> > You mean like the general slowdown from 2.4 - >2.5?
> > 
> > It seems to me for small boxes, 2.5.x is margianlly slower at most
> > things than 2.4.x.
> 
> Can you name a benchmark, or at least do something reproducible between
> versions, and produce a 2.4 vs 2.5 profile? Let's at least try to fix it ...
> 
> M.

Well, here's one bit of data. Easy enough to do if you have a web browser.
LMBench 2.0 on 1-way and 2-way, kernels 2.4.18 and 2.5.60 
1-way (stp1-003 stp1-002) 
2.4.18 http://khack.osdl.org/stp/7443/
2.5.60 http://khack.osdl.org/stp/265622/ 

2-way (stp2-003 stp2-000)
2.4.18 http://khack.osdl.org/stp/3165/
2.5.60 http://khack.osdl.org/stp/265643/

Interesting items for me are the fork/exec/sh times and some of the file + VM 
numbers
LMBench 2.0 Data ( items selected from total of five runs )

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
stp2-003.  Linux 2.4.18 1000 0.39 0.67 3.89 4.99  30.4 0.93 3.06 344. 1403 4465
stp2-000.  Linux 2.5.60 1000 0.41 0.77 4.34 5.57  32.6 1.15 3.59 245. 1406 5795

stp1-003.  Linux 2.4.18 1000 0.32 0.46 2.60 3.21  16.6 0.79 2.52 104. 918. 4460
stp1-002.  Linux 2.5.60 1000 0.33 0.47 2.83 3.47  16.0 0.94 2.70 143. 1212 5292

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
stp2-003.  Linux 2.4.18 2.680 6.2100   15.8 7.9400  110.7    26.4   111.1
stp2-000.  Linux 2.5.60 1.590 5.0700   17.6 7.5800   79.8    11.0   113.6

stp1-003.  Linux 2.4.18 0.590 3.4700   11.1 4.8200  134.3    30.8   131.7
stp1-002.  Linux 2.5.60 1.000 3.5400   11.2 4.1400  129.6    30.4   127.8

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
stp2-003.  Linux 2.4.18 2.680 9.071 17.5  26.9  46.2  34.4  60.0 62.9
stp2-000.  Linux 2.5.60 1.590 8.414 13.2  21.2  43.2  28.3  54.1 97.1

stp1-003.  Linux 2.4.18 0.590 3.623 6.98  11.7  28.2  17.8  38.4 300K
stp1-002.  Linux 2.5.60 1.050 4.591 8.54  14.8  31.8  20.0  41.0 67.1

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
stp2-003.  Linux 2.4.18   34.6 7.2490  110.9   17.9   2642.0 0.771 3.00000
stp2-000.  Linux 2.5.60   40.0 9.2780  113.3   23.3   4592.0 0.543 3.00000

stp1-003.  Linux 2.4.18   28.8 4.8890  107.5   11.3    686.0 0.621 2.00000
stp1-002.  Linux 2.5.60   32.4 6.4290  112.9   16.2   1455.0 0.465 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
stp2-003.  Linux 2.4.18 563. 277. 263.  437.0  552.8  249.1  180.7 553. 215.2
stp2-000.  Linux 2.5.60 603. 516. 151.  436.3  549.0  238.0  171.9 548. 233.7

stp1-003.  Linux 2.4.18 1009 820. 404.  414.3  467.0  167.2  154.1 466. 236.2
stp1-002.  Linux 2.5.60 806. 584. 69.1  408.0  461.7  161.1  149.1 461. 233.5


Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
stp2-003.  Linux 2.4.18  1000 3.464 8.0820  110.9
stp2-000.  Linux 2.5.60  1000 3.545 8.2790  110.6

stp1-003.  Linux 2.4.18  1000 2.994 6.9850  121.4
stp1-002.  Linux 2.5.60  1000 3.023 7.0530  122.5

------------------
cliffw

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


