Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSE1Lho>; Tue, 28 May 2002 07:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSE1Lhn>; Tue, 28 May 2002 07:37:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38052 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313898AbSE1Lhn>;
	Tue, 28 May 2002 07:37:43 -0400
Date: Tue, 28 May 2002 17:11:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Dave Miller <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 8-CPU (SMP) #s for lockfree rtcache
Message-ID: <20020528171104.D19734@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here are the SMP numbers that you had asked for. They were measured
on an 8-CPU SMP box (PIII Xeon 700 MHz processors, 1MB L2 cache
and 6GB RAM).

The test was as per your suggestion. rt_rcu is a patch that
uses RCU to do lockfree lookup of ipv4 route cache.

The basic test sends a fixed number of packets to random
destination addresses repeating every dest for 5 packets.
We tried two configurations of this test - 8-1-32 where
32 test processes simultaneosly uses 32 different
random seeds to generate different dest addreses and 8-4-8
where 8 sets, each consisting 4 processes all of whom use the same
random seed generating the same dst addresses, send packets
to the dest addresses repeating dest for every 5 packets.

With these basic tests, we measured under several other
conditions - avoid forced neighbor table garbage collection
by increasing the threshold and interval (to 31048576 and
60) and slowing the packet rate by introducing a delay of 2ms
between bursts of 5 packets.

Here are the results in terms of profile counts in
ip_route_output_key() - gc stands for neighbor table garbage
collection adjustment and u2000 stands for 2ms packet
rate delay. All measurements where done based on  2.5.3 kernel.


Test                            base    rtrcu    speedup
----                            ----    -----    -------
8-1-32                          2358    1655     29.8%
8-1-32-gc                       4486    2176     51.4%
8-1-32-u2000                    2990    1942     35.0%
8-1-32-u2000-gc                 4047    2029     49.8%

8-4-8                           2870    1965     31.5%
8-4-8-gc                        3389    2083     38.5%
8-4-8-u2000                     3459    2373     31.3%
8-4-8-u2000-gc                  4686    2603     44.4%

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
