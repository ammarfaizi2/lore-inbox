Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUEXI3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUEXI3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUEXI3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:29:35 -0400
Received: from corpmail.outblaze.com ([203.86.166.82]:59358 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S264117AbUEXI3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:29:30 -0400
Date: Mon, 24 May 2004 16:29:26 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: AF_UNIX/tcp bw regression in  2.6.6/2.6.7-rc1 compared to 2.4.22-2188.nptl
Message-ID: <20040524082925.GA23012@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.2-5; VAE: 6.25.0.3; VDF: 6.25.0.74; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I ran lmbench 2.0.4 on a P3-500 with 384 MB ram box with the latest
Fedora Core 1 kernel (2.4.22-2188.nptl, 2.6.6 and 2.6.7-rc1 (CONFIG_REGPARM=y)

There seems to be  regression in AF_UNIX/tcp bandwidth in 2.6.7-rc1
I did two runs per kernel

output from lmbench follows

cc: netdev in case this is of interest to networking hackers

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
214.2.168 Linux 2.4.22-       i686-pc-linux-gnu  407
214.2.168 Linux 2.4.22-       i686-pc-linux-gnu  407
214.2.168 Linux 2.6.7-r       i686-pc-linux-gnu  407
214.2.168 Linux 2.6.7-r       i686-pc-linux-gnu  407
214.2.168   Linux 2.6.6       i686-pc-linux-gnu  407
214.2.168   Linux 2.6.6       i686-pc-linux-gnu  407

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
214.2.168 Linux 2.4.22-  407 0.77 1.16 6.59 8.03  35.6 2.14 6.80 340. 1387 5802
214.2.168 Linux 2.4.22-  407 0.77 1.14 6.58 7.93  37.8 2.14 6.80 341. 1492 5980
214.2.168 Linux 2.6.7-r  407 0.42 0.72 7.01 8.14  28.2 1.99 7.67 383. 1381 5920
214.2.168 Linux 2.6.7-r  407 0.42 0.71 6.97 8.04  30.4 1.99 7.62 390. 1386 5949
214.2.168   Linux 2.6.6  407 0.42 0.74 6.93 8.19  28.0 1.99 7.03 425. 1412 6018
214.2.168   Linux 2.6.6  407 0.42 0.73 7.01 8.26  28.3 1.99 7.04 425. 1430 6083

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
214.2.168 Linux 2.4.22- 1.870   18.3   82.7   19.6  178.4    29.0   258.9
214.2.168 Linux 2.4.22- 1.970   18.2   52.4   23.6  182.3    36.9   260.4
214.2.168 Linux 2.6.7-r 2.840   20.7   88.7   22.1  185.0    30.7   271.7
214.2.168 Linux 2.6.7-r 2.900   20.7   57.3   35.7  192.2    44.7   265.8
214.2.168   Linux 2.6.6 2.280   19.3   54.5   20.6  190.8    34.7   268.6
214.2.168   Linux 2.6.6 2.490   19.2   54.3   28.1  164.6    32.5   266.3

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
214.2.168 Linux 2.4.22- 1.870  10.7 20.3  47.7 108.3  62.4 144.5 248.
214.2.168 Linux 2.4.22- 1.970  10.8 20.3  48.4 108.2  71.1 144.3 242.
214.2.168 Linux 2.6.7-r 2.840  12.4 31.6  52.6 113.4  71.9 141.2 249.
214.2.168 Linux 2.6.7-r 2.900  12.8 31.9  56.4 113.1  70.8 141.3 254.
214.2.168   Linux 2.6.6 2.280  11.0 21.5  51.1 112.0  75.0 149.2 252.
214.2.168   Linux 2.6.6 2.490  11.1 21.8  53.0 111.7  78.7 146.3 255.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
214.2.168 Linux 2.4.22-  156.9   39.1  418.8  105.8   1946.0 0.427 3.00000
214.2.168 Linux 2.4.22-  156.8   39.1  434.8   98.9   1961.0 0.464 3.00000
214.2.168 Linux 2.6.7-r  150.2   31.8  406.5  105.1   2394.0 0.869 4.00000
214.2.168 Linux 2.6.7-r  150.2   31.5  406.5  105.0   2468.0 0.828 4.00000
214.2.168   Linux 2.6.6  147.1   30.4  406.2  103.8   2449.0 1.078 4.00000
214.2.168   Linux 2.6.6  147.6   30.3  401.8  105.1   2584.0 1.172 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
214.2.168 Linux 2.4.22- 186. 118. 85.9  148.8  229.9   75.5   56.2 230.  74.6
214.2.168 Linux 2.4.22- 194. 118. 71.8  146.8  230.7   75.5   56.1 230.  74.6
214.2.168 Linux 2.6.7-r 144. 99.1 58.8  144.4  228.4   73.0   55.6 228.  73.0
214.2.168 Linux 2.6.7-r 162. 99.0 62.7  143.6  228.2   72.7   55.5 228.  73.0
214.2.168   Linux 2.6.6 183. 108. 56.6  142.7  228.3   73.0   55.5 228.  72.9
214.2.168   Linux 2.6.6 174. 119. 64.5  144.3  228.1   73.2   55.5 228.  72.9

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
214.2.168 Linux 2.4.22-   407 7.361   54.1  254.6
214.2.168 Linux 2.4.22-   407 7.362   54.1  254.6
214.2.168 Linux 2.6.7-r   407 7.468   55.0  257.7
214.2.168 Linux 2.6.7-r   407 7.468   86.5  257.5
214.2.168   Linux 2.6.6   407 7.469   55.2  257.8
214.2.168   Linux 2.6.6   407 7.468   55.2  257.8
