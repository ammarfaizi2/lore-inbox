Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264935AbSJ3UIp>; Wed, 30 Oct 2002 15:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJ3UIp>; Wed, 30 Oct 2002 15:08:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:26250 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264935AbSJ3UIo>;
	Wed, 30 Oct 2002 15:08:44 -0500
From: Janet Morgan <janetmor@us.ibm.com>
Message-Id: <200210302014.g9UKEr204332@eng4.beaverton.ibm.com>
Subject: Re: [patch] sys_epoll 0.14 ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Wed, 30 Oct 2002 12:14:52 -0800 (PST)
Cc: torvalds@transmeta.com (Linus Torvalds), akpm@digeo.com (Andrew Morton),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.44.0210291643520.1457-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Oct 29, 2002 03:49:11 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks to Andrew and John suggestions I coded another version of the
> sys_epoll patch ( 0.13 skipped ... superstition :) ). I won't send the
> patch to not waste bandwidth, the patch is available here :
> 
> http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-last.diff
> 
> Comments are welcome ...


The previous and current versions of the sys_epoll patch are performing 
comparably and continue to far exceed the results from standard poll.
Hopefully this is another endorsement for it's inclusion in the 2.5 kernel.

We re-ran the SMP tests that were used to collect the sys_epoll performance 
data recently posted at http://lse.sourceforge.net/epoll/.  Detailed data
follows for those who want a closer look, or check out the website for
more information.


Here are my results from pipetest:

                       Token Passes-Per-Second 
 Number        sys_epoll-        sys_epoll-    Standard
 of Pipes       0.9 (Old)        0.14 (New)     poll() 
----------    ----------------------------------------------
   10              289160        285510         98469   
  100              283463        283948         16514 
  500              278084        281745          3346 
 1000              277441        279754          1667    
 2000              274988        278708           841 
 3000              273139        275484           545 
 4000              274039        273873           397 
 5000              274687        273741           295 
 6000              272489        271055           217 
 7000              271543        269841           168 
 8000              270669        270178           132 
 9000              268353        269213           105 
10000              268974        272780            86 
11000              269641        273580            74 
12000              267961        273834            63 
13000              267249        272904            55 
14000              266456        272307            48 
15000              265396        270909            43 
16000              270268        272928            38 



Here are Shailabh's results from dphtpdd: 

                         Reply-rate 
Number of       sys_epoll    sys_epoll      Standard
Connections      0.9 (Old)   0.14 (New)      poll()
----------    -------------------------------------------
    0         13459.7       13438.8         13331.1    
   50         13218.3       13477.2         14098.9
  100         13417.3       13598.6         14150.3
  200         12781.0       13502.7         13792.2
  400         13507.5       13507.5         14250.2
  800         13428.3       13450.8         13184.6
 1000         13358.6       13479.6         12900.2
 5000         13715.7       13569.2          5039.6
10000         13106.6       13557.3          2359.2
15000         13181.7       13615.6          1669.4
20000         13203.4       13691.0          1270.0
25000         13441.9       13536.3          1008.7
30000         13101.0       13487.8           744.2
35000         13207.0       13648.5           705.0
40000         13213.4       13567.1           631.3
45000         12644.8       13638.5           559.5
50000         13466.3       13689.4           502.0
55000         13458.3       13647.5           452.5
60000         13459.4       13781.0           414.5
