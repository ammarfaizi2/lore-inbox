Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVCBI6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVCBI6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 03:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVCBI6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 03:58:39 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:4546 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262230AbVCBI6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 03:58:24 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, hadi@cyberus.ca,
       Thomas Graf <tgraf@suug.ch>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "David S. Miller" <davem@redhat.com>, jlan@sgi.com,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Netlink List <netdev@oss.sgi.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <42247051.7070303@ak.jp.nec.com>
References: <4221E548.4000008@ak.jp.nec.com>
	 <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
	 <1109592658.2188.924.camel@jzny.localdomain>
	 <20050228132051.GO31837@postel.suug.ch>
	 <1109598010.2188.994.camel@jzny.localdomain>
	 <20050228135307.GP31837@postel.suug.ch>
	 <1109599803.2188.1014.camel@jzny.localdomain>
	 <20050228142551.GQ31837@postel.suug.ch>
	 <1109604693.1072.8.camel@jzny.localdomain>
	 <20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
	 <1109665299.8594.55.camel@frecb000711.frec.bull.fr>
	 <42247051.7070303@ak.jp.nec.com>
Date: Wed, 02 Mar 2005 09:58:13 +0100
Message-Id: <1109753893.8422.127.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2005 10:07:20,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2005 10:07:25,
	Serialize complete at 02/03/2005 10:07:25
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 22:38 +0900, Kaigai Kohei wrote:
> > I tested without user space listeners and the cost is negligible. I will
> > test with a user space listeners and see the results. I'm going to run
> > the test this week after improving the mechanism that switch on/off the
> > sending of the message.
> 
> I'm also trying to mesure the process-creation/destruction performance on following three environment.
> Archtechture: i686 / Distribution: Fedora Core 3
> * Kernel Preemption is DISABLE
> * SMP kernel but UP-machine / Not Hyper Threading
> [1] 2.6.11-rc4-mm1 normal
> [2] 2.6.11-rc4-mm1 with PAGG based Process Accounting Module
> [3] 2.6.11-rc4-mm1 with fork-connector notification (it's enabled)
> 
> When 367th-fork() was called after fork-connector notification, kernel was locked up.
> (User-Space-Listener has been also run until 366th-fork() notification was received)

 So I ran the lmbench with three different kernels with the fork
connector patch I just sent. Results are attached at the end of the mail
and there are three different lines which are:

	o First line is  a linux-2.6.11-rc4-mm1-cnfork
	o Second line is a linux-2.6.11-rc4-mm1
	o Third line is  a linux-2.6.11-rc4-mm1-cnfork with a user space
          application. The user space application listened during 15h 
          and received 6496 messages.

Each test has been ran only once. 

Best regards,
Guillaume

---

cd results && make summary percent 2>/dev/null | more
make[1]: Entering directory `/home/guill/benchmark/lmbench/lmbench-3.0-a4/results'

                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes  
--------- ------------- ----------------------- ---- ----- ----- ------ ----
account   Linux 2.6.11-       i686-pc-linux-gnu 2765    63   128 2.4900    1
account   Linux 2.6.11-       i686-pc-linux-gnu 2765    67   128 2.4200    1
account   Linux 2.6.11-       i686-pc-linux-gnu 2765    69   128 2.4400    1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
account   Linux 2.6.11- 2765 0.17 0.26 3.57 4.19 16.9 0.51 2.31 162. 629. 2415
account   Linux 2.6.11- 2765 0.16 0.26 3.56 4.17 17.6 0.50 2.30 163. 628. 2417
account   Linux 2.6.11- 2765 0.16 0.27 3.67 4.25 17.6 0.51 2.28 176. 664. 2456

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr  
                          bit   add    mul    div    mod   
--------- ------------- ------ ------ ------ ------ ------ 
account   Linux 2.6.11- 0.1800 0.1700 4.9900   20.8   23.1
account   Linux 2.6.11- 0.1800 0.1700 4.9900   20.8   23.1
account   Linux 2.6.11- 0.1800 0.1700 4.9900   20.8   23.1

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------ 
account   Linux 2.6.11- 1.7300 2.4800   15.5   15.4
account   Linux 2.6.11- 1.7300 2.4800   15.5   15.6
account   Linux 2.6.11- 1.7400 2.5000   15.7   15.6

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------ 
account   Linux 2.6.11- 1.7300 2.4800   15.5   15.4
account   Linux 2.6.11- 1.7300 2.4800   15.5   15.6
account   Linux 2.6.11- 1.7400 2.5000   15.7   15.6

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
account   Linux 2.6.11- 5.1300 5.2900 4.9700 3.1700   10.9 6.30000    32.6
account   Linux 2.6.11- 4.9000 5.2100 5.1600 4.4700   20.3 6.48000    27.7
account   Linux 2.6.11- 4.8600 5.3000 4.9200 3.5600   20.5 6.87000    31.5

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
account   Linux 2.6.11- 5.130  14.3 11.9  17.7  23.2  20.3  28.3  40.
account   Linux 2.6.11- 4.900  14.6 12.0  18.5  23.9  20.8  28.6  40.
account   Linux 2.6.11- 4.860  14.8 12.6  18.1  23.9  20.8  27.8  40.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
account   Linux 2.6.11-   18.9   16.1   65.6   33.5   15.4K 0.771 2.22520  16.4
account   Linux 2.6.11-   18.8   16.3   64.2   33.2   15.7K 0.841 2.20690  16.5
account   Linux 2.6.11-   19.2   16.4   65.4   33.5   15.7K 0.782 2.19950  16.4

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
account   Linux 2.6.11- 664. 497. 369. 1468.8 1836.1  596.6  568.4 1819 779.7
account   Linux 2.6.11- 671. 521. 338. 1481.6 1817.2  593.8  568.8 1838 783.0
account   Linux 2.6.11- 667. 543. 372. 1469.4 1816.8  594.2  568.3 1818 783.0

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
--------- -------------   ---   ----   ----    --------    --------    -------
account   Linux 2.6.11-  2765 0.7030 6.5710  140.6       246.7
account   Linux 2.6.11-  2765 0.7090 6.6350  142.4       249.5
account   Linux 2.6.11-  2765 0.7110 6.6340  142.5       249.5
make[1]: Leaving directory `/home/guill/benchmark/lmbench/lmbench-3.0-a4/results'


