Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVHYTQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVHYTQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVHYTQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:16:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750784AbVHYTQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:16:02 -0400
Date: Thu, 25 Aug 2005 12:15:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@namei.org>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH 0/5] LSM hook updates
Message-ID: <20050825191548.GY7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode> <20050825053208.GS7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825053208.GS7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> I'll have some numbers tomorrow.  If you'd like to run SELinux that'd
> be quite useful.

These are just lmbench and kernel build numbers (certainly not the best
for real benchmark numbers, but easy to get a quick view run).  This is
just baseline (i.e. default, nothing loaded).

This is x86_64 (1 HT core) 2GB.

Kernel build:

old hooks		new hooks
---------		---------
real    7m2.313s	real    7m1.542s
user    6m25.012s	user    6m25.484s
sys     0m56.580s	sys     0m56.008s
	
real    7m3.376s	real    7m0.593s
user    6m25.412s	user    6m24.184s
sys     0m57.140s	sys     0m56.936s
	
real    7m2.643s	real    7m1.280s
user    6m23.840s	user    6m25.408s
sys     0m57.668s	sys     0m55.935s
	
real    7m0.015s	real    7m0.712s
user    6m23.964s	user    6m24.820s
sys     0m57.940s	sys     0m56.520s
	
real    7m3.204s	real    7m0.592s
user    6m23.868s	user    6m24.652s
sys     0m57.712s	sys     0m56.460s
	
real    7m1.961s	real    7m1.328s
user    6m24.416s	user    6m25.284s
sys     0m57.252s	sys     0m56.184s
	

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
vert.sous Linux 2.6.13- x86_64-linux-gnu-oldhoo 2997
vert.sous Linux 2.6.13- x86_64-linux-gnu-oldhoo 2997
vert.sous Linux 2.6.13- x86_64-linux-gnu-oldhoo 2997
vert.sous Linux 2.6.13- x86_64-linux-gnu-oldhoo 2997

vert.sous Linux 2.6.13- x86_64-linux-gnu-newhoo 2997
vert.sous Linux 2.6.13- x86_64-linux-gnu-newhoo 2997
vert.sous Linux 2.6.13- x86_64-linux-gnu-newhoo 2997
vert.sous Linux 2.6.13- x86_64-linux-gnu-newhoo 2997

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
vert.sous Linux 2.6.13- 2997 0.22 0.39 14.1 16.4  14.9 0.36 4.77 199. 684. 2524
vert.sous Linux 2.6.13- 2997 0.22 0.39 14.1 16.4  15.0 0.36 4.68 198. 689. 2530
vert.sous Linux 2.6.13- 2997 0.23 0.39 14.1 16.4  14.2 0.36 4.74 198. 690. 2528
vert.sous Linux 2.6.13- 2997 0.22 0.39 14.1 16.4  14.9 0.37 4.71 199. 684. 2532

vert.sous Linux 2.6.13- 2997 0.22 0.39 14.1 16.3  14.2 0.37 4.66 195. 679. 2497
vert.sous Linux 2.6.13- 2997 0.22 0.39 14.1 16.3  14.8 0.37 4.67 198. 681. 2511
vert.sous Linux 2.6.13- 2997 0.23 0.40 14.1 16.3  15.0 0.37 4.67 197. 678. 2512
vert.sous Linux 2.6.13- 2997 0.23 0.39 14.1 16.3  15.6 0.37 4.70 197. 681. 2508

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
vert.sous Linux 2.6.13- 6.120 7.1500 9.6900 7.1600   11.8 7.78000    18.0
vert.sous Linux 2.6.13- 6.140 7.1000 9.6700 7.1600   11.7 7.93000    18.1
vert.sous Linux 2.6.13- 6.080 7.1100 9.6900 7.2100   11.9 8.14000    18.0
vert.sous Linux 2.6.13- 6.070 7.1000 9.7100 7.3000   12.9 7.85000    18.1

vert.sous Linux 2.6.13- 5.820 6.8900 9.4200 7.0600   12.2 7.77000    18.0
vert.sous Linux 2.6.13- 5.830 6.9700 9.5400 7.0000   13.6 7.99000    17.9
vert.sous Linux 2.6.13- 5.870 6.8200 9.5000 7.3000   12.1 8.15000    17.8
vert.sous Linux 2.6.13- 5.870 6.9200 9.5400 7.1200   11.4 7.91000    18.3

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
vert.sous Linux 2.6.13- 6.180  15.2 33.9  29.9  42.3  55.9  72.2 106.
vert.sous Linux 2.6.13- 6.140  15.2 33.8  30.1  42.5  55.8  72.5 107.
vert.sous Linux 2.6.13- 6.080  15.1 34.0  30.0  42.5  55.9  72.6 107.
vert.sous Linux 2.6.13- 6.070  14.7 34.1  30.2  42.4  55.7  72.5 107.

vert.sous Linux 2.6.13- 5.820  14.1 33.8  30.0  42.0  54.9  71.0 106.
vert.sous Linux 2.6.13- 5.830  14.4 33.9  30.2  42.1  54.9  71.0 106.
vert.sous Linux 2.6.13- 5.870  14.6 34.1  29.9  42.0  54.9  71.2 106.
vert.sous Linux 2.6.13- 5.870  14.6 34.3  29.8  42.2  54.8  71.0 106.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
vert.sous Linux 2.6.13-   32.6   25.9   80.1   46.8   8368.0 1.014 2.00000
vert.sous Linux 2.6.13-   32.4   26.0   84.2   46.8   8413.0 1.092 2.00000
vert.sous Linux 2.6.13-   32.4   25.9   87.6   46.8   8434.0 1.111 2.00000
vert.sous Linux 2.6.13-   32.5   25.9   82.7   46.8   8448.0 1.110 2.00000

vert.sous Linux 2.6.13-   32.5   27.0   86.5   48.9   8266.0 1.027 2.00000
vert.sous Linux 2.6.13-   32.5   27.0   85.8   49.0   8382.0 1.012 2.00000
vert.sous Linux 2.6.13-   32.5   27.1   81.4   49.3   8403.0 1.004 2.00000
vert.sous Linux 2.6.13-   32.4   27.0   86.1   48.8   8386.0 1.127 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
vert.sous Linux 2.6.13- 1101 279. 458. 2281.4 4304.0 1291.3 1316.6 4291 1973.
vert.sous Linux 2.6.13- 1115 280. 467. 2280.7 4295.0 1313.8 1322.3 4304 1978.
vert.sous Linux 2.6.13- 1133 280. 467. 2273.9 4297.8 1304.9 1319.7 4297 2008.
vert.sous Linux 2.6.13- 1132 279. 458. 2276.6 4298.3 1290.7 1308.4 4296 1982.

vert.sous Linux 2.6.13- 1103 279. 456. 2283.0 4303.6  969.8  997.1 4289 1519.
vert.sous Linux 2.6.13- 1098 279. 454. 2283.2 4290.6 1036.3 1054.3 4286 1572.
vert.sous Linux 2.6.13- 1128 279. 455. 2273.9 4296.1 1122.6 1069.6 4302 1629.
vert.sous Linux 2.6.13- 1103 279. 467. 2276.3 4299.1 1054.4 1076.5 4302 1633.

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
vert.sous Linux 2.6.13-  2997 1.337 9.4000   44.6
vert.sous Linux 2.6.13-  2997 1.336 9.5200   44.3
vert.sous Linux 2.6.13-  2997 1.336 9.3990   44.5
vert.sous Linux 2.6.13-  2997 1.336 9.3600   44.5

vert.sous Linux 2.6.13-  2997 1.338 9.5130   44.5
vert.sous Linux 2.6.13-  2997 1.336 9.5170   44.5
vert.sous Linux 2.6.13-  2997 1.336 9.4670   44.6
vert.sous Linux 2.6.13-  2997 1.336 9.4620   44.5

