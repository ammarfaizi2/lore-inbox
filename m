Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268681AbUIQLWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268681AbUIQLWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268689AbUIQLWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:22:44 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4620 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268681AbUIQLWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:22:30 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Date: Fri, 17 Sep 2004 14:21:15 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua> <20040916121747.GQ9106@holomorphy.com>
In-Reply-To: <20040916121747.GQ9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_risSBPAGh0Kb27k"
Message-Id: <200409171421.15470.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_risSBPAGh0Kb27k
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> On Thu, Sep 16, 2004 at 02:57:08PM +0300, Denis Vlasenko wrote:
> > I recompiled 2.6 with HZ=100. It's not it.
> > Time is running normally too.
>
> Did the kallsyms patches reduce the cpu overhead from get_wchan()? I take
> this to mean reducing HZ to 100 did not alleviate the syscall problems?
> How do microbenchmarks fare, e.g. lmbench?

2x3 lmbench runs. HZ=100, configs attached.

i586-pc-linux-gnu: no data for Socket bandwidth using localhost
i586-pc-linux-gnu: no data for Socket bandwidth using localhost
i586-pc-linux-gnu: no data for Socket bandwidth using localhost
i586-pc-linux-gnu: no data for Socket bandwidth using localhost
i586-pc-linux-gnu: no data for Socket bandwidth using localhost
i586-pc-linux-gnu: no data for Socket bandwidth using localhost

                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes  
--------- ------------- ----------------------- ---- ----- ----- ------ ----
hunter    Linux 2.6.9-r       i586-pc-linux-gnu   67          32           1
hunter    Linux 2.6.9-r       i586-pc-linux-gnu   67          32           1
hunter    Linux 2.6.9-r       i586-pc-linux-gnu   67          32           1
hunter    Linux 2.4.27-       i586-pc-linux-gnu   67          32           1
hunter    Linux 2.4.27-       i586-pc-linux-gnu   67          32           1
hunter    Linux 2.4.27-       i586-pc-linux-gnu   67          32           1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
hunter    Linux 2.6.9-r   67 2.27 5.25 106. 129.      12.7 64.3 4312 31.K 86.K
hunter    Linux 2.6.9-r   67 2.27 4.77 100. 122.      13.3 62.2 4338 31.K 85.K
hunter    Linux 2.6.9-r   67 2.27 5.48 107. 129.      14.3 62.5 4420 31.K 86.K
hunter    Linux 2.4.27-   67 2.26 4.98 3073 3110      9.98 23.0 4200 77.K 240K
hunter    Linux 2.4.27-   67 2.26 4.88 3034 3028      12.3 23.0 3852 78.K 237K
hunter    Linux 2.4.27-   67 2.32 5.15 3009 3192      10.0 23.7 4047 78.K 238K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
hunter    Linux 2.6.9-r   31.9   64.0  120.8  115.7  322.2   136.0   356.4
hunter    Linux 2.6.9-r   29.1   47.2   76.7  102.3  321.5   136.0   354.2
hunter    Linux 2.6.9-r   29.3   56.0  144.5  101.9  305.5   145.3   351.0
hunter    Linux 2.4.27-   19.8   39.4  190.3   77.8  368.0   104.1   401.5
hunter    Linux 2.4.27-   19.7   30.9  105.0   87.2  316.9   107.2   359.9
hunter    Linux 2.4.27-   19.5   34.6   95.5   74.3  279.1   109.5   325.0

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
hunter    Linux 2.6.9-r  31.9 129.8 230.                             
hunter    Linux 2.6.9-r  29.1 130.1 244.                             
hunter    Linux 2.6.9-r  29.3 136.9 233.                             
hunter    Linux 2.4.27-  19.8  74.0 146.                             
hunter    Linux 2.4.27-  19.7  74.4 134.                             
hunter    Linux 2.4.27-  19.5  77.8 137.                             

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
hunter    Linux 2.6.9-r  837.5 1272.3 2421.3 1751.3  1289.0 1.145    18.9 129.6
hunter    Linux 2.6.9-r  862.8 1234.6 2463.1 1683.5  1270.0 3.732    18.4 128.1
hunter    Linux 2.6.9-r  805.2 1122.3 2283.1 1550.4  1157.0 3.415    18.3 128.0
hunter    Linux 2.4.27- 4219.4 4807.7 5586.6 4444.4   910.0  10.3    14.6 164.1
hunter    Linux 2.4.27- 3759.4 4065.0 5586.6 4444.4   870.0  10.3    15.8 163.6
hunter    Linux 2.4.27- 4048.6 4830.9 5714.3 4761.9   985.0 9.553    16.7 163.1

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
hunter    Linux 2.6.9-r 13.1 11.1        16.8   54.3   18.4   18.5 54.2  26.1
hunter    Linux 2.6.9-r 12.7 12.1        16.4   54.3   18.5   18.5 54.3  26.2
hunter    Linux 2.6.9-r 13.0 11.2        18.3   54.3   18.5   18.5 54.3  26.1
hunter    Linux 2.4.27- 15.7 11.9        17.6   54.2   18.6   18.6 54.4  26.0
hunter    Linux 2.4.27- 15.7 10.7        18.3   54.2   18.4   18.5 54.4  26.1
hunter    Linux 2.4.27- 15.5 10.9        17.8   54.3   18.6   18.5 54.4  26.1
--
vda

--Boundary-00=_risSBPAGh0Kb27k
Content-Type: application/x-tbz;
  name="c.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="c.tar.bz2"

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

--Boundary-00=_risSBPAGh0Kb27k--

