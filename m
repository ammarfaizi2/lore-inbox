Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSJGHWP>; Mon, 7 Oct 2002 03:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSJGHWP>; Mon, 7 Oct 2002 03:22:15 -0400
Received: from franka.aracnet.com ([216.99.193.44]:30900 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261872AbSJGHWN>; Mon, 7 Oct 2002 03:22:13 -0400
Date: Mon, 07 Oct 2002 00:25:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] NUMA schedulers benchmark results
Message-ID: <1338937420.1033950308@[10.10.2.3]>
In-Reply-To: <200210061851.45401.efocht@ess.nec.de>
References: <200210061851.45401.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a data dump for you, I'm sleepy ... will look at it in the
morning. 16-way NUMA-Q running your benchmark:

2.5.40-mm2

time.4:AverageUserTime 40.69 seconds
time.4:ElapsedTime     52.14
time.4:TotalUserTime   162.85
time.4:TotalSysTime    0.71
time.8:AverageUserTime 36.90 seconds
time.8:ElapsedTime     62.12
time.8:TotalUserTime   295.29
time.8:TotalSysTime    1.79
time.16:AverageUserTime 63.91 seconds
time.16:ElapsedTime     88.82
time.16:TotalUserTime   1022.71
time.16:TotalSysTime    4.85
time.32:AverageUserTime 102.11 seconds
time.32:ElapsedTime     224.24
time.32:TotalUserTime   3267.84
time.32:TotalSysTime    11.73
time.64:AverageUserTime 148.33 seconds
time.64:ElapsedTime     611.71
time.64:TotalUserTime   9494.10
time.64:TotalSysTime    25.81

2.5.40-mm2 + michael's stuff (latest on tux1)

time.4:AverageUserTime 31.55 seconds
time.4:ElapsedTime     41.58
time.4:TotalUserTime   126.23
time.4:TotalSysTime    1.11
time.8:AverageUserTime 51.80 seconds
time.8:ElapsedTime     80.38
time.8:TotalUserTime   414.50
time.8:TotalSysTime    2.67
time.16:AverageUserTime 50.75 seconds
time.16:ElapsedTime     72.28
time.16:TotalUserTime   812.08
time.16:TotalSysTime    4.60
time.32:AverageUserTime 55.78 seconds
time.32:ElapsedTime     126.45
time.32:TotalUserTime   1785.21
time.32:TotalSysTime    8.79
time.64:AverageUserTime 57.49 seconds
time.64:ElapsedTime     243.27
time.64:TotalUserTime   3679.94
time.64:TotalSysTime    15.09

Looks pretty sweet to me, apart from 8, which is just wierd.

Profile looks horrible (what the hell is fib_node_get_info?
net/ipv4/fib_semantics.c):

without:

241652 total                                      0.2455
120117 default_idle                            
 19728 fib_node_get_info                       
 17400 swapin_readahead                        
 12805 kmalloc                                 
 11047 kfree                                   
  7918 sock_alloc_send_pskb                    
  5956 alloc_skb                               
  4690 __wake_up                               
  4194 kmem_cache_free                         

with:

213131 total                                      0.2165
138082 default_idle                            
 14620 fib_node_get_info                       
  9631 swapin_readahead                        
  5316 kmalloc                                 
  5279 kfree                                   
  5251 sock_alloc_send_pskb                    
  4154 __wake_up                               
  4116 schedule                                
  3002 alloc_skb                 

