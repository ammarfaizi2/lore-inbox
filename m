Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSCOOGl>; Fri, 15 Mar 2002 09:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292458AbSCOOGV>; Fri, 15 Mar 2002 09:06:21 -0500
Received: from mail-out2.cytanet.com.cy ([195.14.133.169]:17795 "EHLO
	mail-out2.cytanet.com.cy") by vger.kernel.org with ESMTP
	id <S292395AbSCOOGN>; Fri, 15 Mar 2002 09:06:13 -0500
From: Sinisa Milivojevic <sinisa@mysql.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15505.65197.493625.894647@sinisa.nasamreza.org>
Date: Fri, 15 Mar 2002 16:01:17 +0200
To: pz@spylog.ru
Cc: mysql@lists.mysql.com, linux-kernel@vger.kernel.org
Subject: Re: MYSQL,Linux & large threads number
In-Reply-To: <551905871007.20020315163038@spylog.ru>
In-Reply-To: <551905871007.20020315163038@spylog.ru>
X-Mailer: VM 7.01 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: sinisa@mysql.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev writes:
> Hello mysql,
> 
>   Some time ago I wrote about slow down of mysql with large number of
>   threads, which is quite common in Linux-Apache-Mysql-PHP enviroment.
> 
>   The test was simulating the worst case of concurrency - all the
>   threads are modified global variable in a loop 5000000 times in
>   total, using standard mutex for synchronization. The yeild is used
>   in a loop to force even more fair distribution of lock usage by
>   threads and increase context switches, therefore it did not change
>   much with large number of threads. I.e with 64 threads time without
>   yeild is 1:33.5
> 
>   Test was run on PIII-500 1G RAM Kernel 2.4.18. 3 runs were made for
>   each number of threads and best results were taken:
> 
>  Num threads.       Time      Peak cs rate.
>     2               53.4          179518
>     4               53.8          144828
>     16              1:06.3         85172
>     64              1:48.1         48394
>     256             8:10.6         10235
>     1000           36:46.2          2602
> 

I hope you are using latest glibc 2.2 with our patches applied.

Also please try adaptive mutex. How to set it, take a look at
mysys/my_thr_init.c.

-- 
Regards,
   __  ___     ___ ____  __
  /  |/  /_ __/ __/ __ \/ /    Mr. Sinisa Milivojevic <sinisa@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__   MySQL AB, Fulltime Developer
/_/  /_/\_, /___/\___\_\___/   Larnaca, Cyprus
       <___/   www.mysql.com

