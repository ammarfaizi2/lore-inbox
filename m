Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263702AbTCVQAW>; Sat, 22 Mar 2003 11:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263704AbTCVQAV>; Sat, 22 Mar 2003 11:00:21 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:40874 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S263702AbTCVQAS>; Sat, 22 Mar 2003 11:00:18 -0500
Message-ID: <3E7C8B22.7020505@nortelnetworks.com>
Date: Sat, 22 Mar 2003 11:11:14 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lmbench results for 2.4 and 2.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My previous testing with unix sockets prompted me to do a few lmbench runs with 
2.4.19 and 2.5.65.  The results have me a bit concerned, as there is no area 
where 2.5 is faster and several where it is significantly slower.

In particular:

stat is 8 times worse
open/close are 7 times worse
fork is twice as expensive
tcp latency is 5 times worse
file deletion and mmap are both twice as expensive
tcp bandwidth is 5 times worse

Optimizing for muliple processors and heavy loads is nice, but this looks like 
its happening at the cost of basic performance.  Is this really the route we 
should be taking?



                  L M B E N C H  2 . 0   S U M M A R Y
                  ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host              OS  Mhz null null      open selct sig  sig  fork exec sh
                           call  I/O stat clos TCP   inst hndl proc proc proc
------ ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
doug    Linux 2.5.65  750 0.38 0.61 39.8 42.1       1.07 5.29 424. 2378 20.K
doug    Linux 2.5.65  750 0.38 0.54 40.2 44.2       1.07 5.31 439. 2386 20.K
doug    Linux 2.4.19  750 0.37 0.52 5.21 6.78  36.7 0.93 3.59 197. 1472 15.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
doug       Linux 2.5.65 1.790 3.0300  118.7   46.1  158.3    46.5   158.2
doug       Linux 2.5.65 1.950 2.9800  122.6   46.3  159.5    47.1   158.7
doug       Linux 2.4.19 1.690 2.6700   92.9   44.4  155.2    45.0   155.8

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                         ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
doug       Linux 2.5.65 1.790 8.926 16.3  29.7  60.6 171.5 204.6 216.
doug       Linux 2.5.65 1.950 9.695 18.1  28.6  59.8 173.4 207.0 212.
doug       Linux 2.4.19 1.690 6.146 12.4  17.8  44.2  26.2  66.6 101.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                         Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
doug       Linux 2.5.65  110.2   65.0  242.5  100.7   3130.0 0.621 4.00000
doug       Linux 2.5.65  110.1   63.5  237.2   96.6   3284.0 0.741 4.00000
doug       Linux 2.4.19   82.5   32.4  187.5   47.9   1660.0 1.177 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                              UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
doug       Linux 2.5.65 167. 94.7 14.3  212.5  354.8  214.5  215.9 474. 328.4
doug       Linux 2.5.65 175. 86.3 14.2  216.3  354.1  211.4  210.9 474. 328.8
doug       Linux 2.4.19 220. 108. 86.4  238.2  369.1  215.5  215.0 496. 328.0





-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

