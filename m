Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264117AbTCXF55>; Mon, 24 Mar 2003 00:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264118AbTCXF55>; Mon, 24 Mar 2003 00:57:57 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:54506 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S264117AbTCXF5z>; Mon, 24 Mar 2003 00:57:55 -0500
Message-ID: <3E7EA0F6.8000308@nortelnetworks.com>
Date: Mon, 24 Mar 2003 01:08:54 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
References: <3E7C8B22.7020505@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay, I'm somewhat chagrined but a bit relieved at the same time.  Linus' 
comment about being sure that I'm testing the same setup promped me to go 
through and doublecheck my config. Turns out that I had some debug stuff turned 
on.  Duh.

Here are the results of 2.4.20 and 2.5.65 with as close to matching configs as I 
could make them.

The ones that stand out are:
--fork/exec (due to rmap I assume?)
--mmap (also due to rmap?)
--select latency (any ideas?)
--udp latency (related to select latency?)
--page fault (is this significant?)
--tcp bandwidth (explained as debugging code)

Sorry about the bogus numbers last time around.

Chris


                  L M B E N C H  2 . 0   S U M M A R Y
                  ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host            OS  Mhz null null      open selct sig  sig  fork exec sh
                         call  I/O stat clos TCP   inst hndl proc proc proc
---- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
doug  Linux 2.5.65  750 0.38 0.73 5.46 7.13  64.2 1.03 3.25 231. 1729 17.K
doug  Linux 2.4.20  750 0.37 0.50 3.84 5.48  17.5 0.96 3.36 185. 1373 15.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host            OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                    ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
---- ------------- ----- ------ ------ ------ ------ ------- -------
doug  Linux 2.5.65 1.420 2.9700  108.7   46.6  157.6    46.7   157.5
doug  Linux 2.4.20 1.120 2.3400   91.5   43.5  155.5    45.2   156.0

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host            OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                    ctxsw       UNIX         UDP         TCP conn
---- ------------- ----- ----- ---- ----- ----- ----- ----- ----
doug  Linux 2.5.65 1.420 7.642 11.4  21.9  45.0  27.2  60.5 104.
doug  Linux 2.4.20 1.120 6.606 10.3  15.8  40.9  26.2  56.5 82.9

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host            OS   0K File      10K File      Mmap    Prot    Page
                    Create Delete Create Delete  Latency Fault   Fault
---- ------------- ------ ------ ------ ------  ------- -----   -----
doug  Linux 2.5.65   64.8   21.0  165.6   42.0   2550.0 0.946 4.00000
doug  Linux 2.4.20   66.1   20.5  192.8   51.6   1612.0 0.764 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host           OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                         UNIX      reread reread (libc) (hand) read write
---- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
doug  Linux 2.5.65 196. 107. 51.1  222.5  363.4  217.9  217.6 489. 326.0
doug  Linux 2.4.20 233. 111. 90.0  253.6  370.0  223.8  226.1 498. 328.9



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


