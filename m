Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318931AbSIIWRt>; Mon, 9 Sep 2002 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318932AbSIIWRt>; Mon, 9 Sep 2002 18:17:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41477 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318931AbSIIWRq>;
	Mon, 9 Sep 2002 18:17:46 -0400
Message-Id: <200209092222.g89MMJp17292@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: James Morris <jmorris@intercode.com.au>
cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org
Subject: Re: LMbench2.0 results 
In-Reply-To: Message from James Morris <jmorris@intercode.com.au> 
   of "Sun, 08 Sep 2002 00:33:46 +1000." <Mutt.LNX.4.44.0209080030370.14798-100000@blackbird.intercode.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Sep 2002 15:22:19 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 7 Sep 2002, Paolo Ciarrocchi wrote:
> 
> > Let me know if you need further information (.config, info about my
> > hardware) or if you want I run other tests.
> 
> Would you be able to run the tests for 2.5.31?  I'm looking into a
> slowdown in 2.5.32/33 which may be related.  Some hardware info might be
> useful too.
> 
> 
Certainly, we have those in the STP data base, and here's a quick summary:
(Of course you can search these yourself ) The full reports have the hardware 
summary also. see web links at the end. Full reports have each test run 5x.


Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
stp1-000.  Linux 2.5.33 1000 0.33 0.49 2.84 3.52       0.79 2.62 168. 1279 4475
stp1-002.  Linux 2.5.32 1000 0.32 0.47 2.94 4.41  15.7 0.80 2.63 202. 1292 4603
stp1-003.  Linux 2.5.31 1000 0.32 0.46 2.85 6.92  14.4 0.80 2.60 856. 2596 8122

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
stp1-000.  Linux 2.5.33 1.530 4.1100   12.2 6.4700  136.4    32.7   136.2
stp1-002.  Linux 2.5.32 1.590 4.2200   12.4 5.4000  139.1    26.6   136.7
stp1-003.  Linux 2.5.31 1.830   46.4  142.6   47.5  141.7    47.6   141.2

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
stp1-000.  Linux 2.5.33 1.530 5.320 10.7  13.8  30.5  19.3  42.1 65.3
stp1-002.  Linux 2.5.32 1.570 5.456 11.3  14.2  31.3  21.1  42.6 67.4
stp1-003.  Linux 2.5.31 1.810 7.377 14.9  50.5 173.7 117.1 263.8 414.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
stp1-000.  Linux 2.5.33   32.9 5.4600  117.0   13.3   1261.0 0.575 3.00000
stp1-002.  Linux 2.5.32   34.0 5.9460  118.6   14.0   1265.0 0.619 3.00000
stp1-003.  Linux 2.5.31   72.5   15.3  225.5   38.2   2062.0 0.657 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
stp1-000.  Linux 2.5.33 699. 855. 68.0  407.9  460.1  168.5  157.8 460. 233.8
stp1-002.  Linux 2.5.32 690. 297. 93.7  397.5  459.2  162.1  150.0 458. 233.1
stp1-003.  Linux 2.5.31 145. 74.8 58.5  118.6  456.9  169.7  156.8 456. 269.0

Full list:
2.5.33 http://khack.osdl.org/stp/4925 -1cpu
	http://khack.osdl.org/stp/4915 -1cpu
	http://khack.osdl.org/stp/4932 -2cpu
	http://khack.osdl.org/stp/4926 -2cpu
2.5.32 
	http://khack.osdl.org/stp/4758  -2cpu
	http://khack.osdl.org/stp/4752 -2cpu
	http://khack.osdl.org/stp/4751 -1cpu
	http://khack.osdl.org/stp/4741 -1cpu
2.5.31 	
	http://khack.osdl.org/stp/4302 -1cpu
	http://khack.osdl.org/stp/4312 -1cpu
	http://khack.osdl.org/stp/4313 -2cpu
	http://khack.osdl.org/stp/4319 -2cpu	
cliffw
OSDL	

> - James
> -- 
> James Morris
> <jmorris@intercode.com.au>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


