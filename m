Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVCQUXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVCQUXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVCQUXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:23:33 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:56027 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261324AbVCQUXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:23:30 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       garloff@suse.de, ak@suse.de, Ian.Pratt@cl.cam.ac.uk
Subject: Re: 2.6.11 vs 2.6.10 slowdown on i686
In-Reply-To: Your message of "Thu, 17 Mar 2005 23:37:24 +1100."
             <42397A04.2060703@yahoo.com.au> 
Date: Thu, 17 Mar 2005 20:23:23 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1DC1Wd-00011q-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There are some changes in the current -bk tree (which are a
> bit in-flux at the moment) which introduce some optimisations.
> 
> They should bring 2-level performance close to par with 2.6.10.
> If not, complain again :)

The good news is that with a BK snapshot from today
[md5key=4238cb8e36_Z5Cgys8rTovspboIJpw] performance is rather
improved relative to 2.6.11 :

 fork: 166 -> 187   -13%
 exec: 857 -> 909   -6%

Rather better than -40%, but still not brilliant.

Any more improvements in the pipeline?

Ian



------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
commando-  Linux 2.6.10 2400 0.49 0.57 2.06 3.06 19.6 0.89 2.70 166. 857. 2972
commando-  Linux 2.6.12 2400 0.49 0.60 2.37 3.43 20.9 0.91 2.64 187. 909. 3076

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
commando-  Linux 2.6.10 7.5800 4.3300 8.1900 5.1100   33.1 8.37000    41.9
commando-  Linux 2.6.12 7.7400 7.9200 8.3700 5.1600   27.0 9.32000    36.5

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
commando-  Linux 2.6.10 7.750  19.4 21.3  37.2  45.5  42.5  53.2  76.
commando-  Linux 2.6.12 7.740  18.2 23.1  37.4  45.6  42.6  54.9  80.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
commando-  Linux 2.6.10   39.3   16.2   92.7   35.2   122.0 1.200 2.14310  18.3
commando-  Linux 2.6.12   38.7   16.4   94.1   35.1   148.0 1.029 2.25100  18.0

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
commando-  Linux 2.6.10 313. 440. 222. 1551.7 1528.5  549.1  566.8 1550 784.8
commando-  Linux 2.6.12 556. 477. 224. 1540.3 1551.4  566.5  566.6 1551 786.2


