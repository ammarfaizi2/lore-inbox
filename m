Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290521AbSAYDUa>; Thu, 24 Jan 2002 22:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290523AbSAYDUS>; Thu, 24 Jan 2002 22:20:18 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:19107 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S290521AbSAYDUF>; Thu, 24 Jan 2002 22:20:05 -0500
Date: Thu, 24 Jan 2002 22:23:57 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020124222357.C901@earthlink.net>
In-Reply-To: <20020124191927.A809@earthlink.net> <Pine.LNX.4.33L.0201242226360.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0201242226360.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Jan 24, 2002 at 10:29:53PM -0200
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   [snip results:  -aa twice as fast as -rmap for dbench,
>                   -rmap twice as fast as -aa for tiobench]

Look closely at all the numbers:

dbench 64 128 192 on ext completed in 4500 seconds on 2.4.18pre4aa1
dbench 64 128 192 on ext completed in 12471 seconds on 2.4.17rmap12a

2.4.18pre4aa1 completed the three dbenches 277% faster.

For tiobench:

Tiobench is interesting because it has the CPU% column.  I mentioned 
sequential reads because it's a bench where 2.4.17rmap12a was faster.  
Someone else might say 2.4.18pre4aa1 was 271% faster at random reads.  
Let's analyze CPU efficiency where threads = 1:

               Num     Seq Read     Rand Read      Seq Write   Rand Write
               Thr    Rate (CPU%)  Rate (CPU%)    Rate (CPU%)  Rate (CPU%)
               ---  -------------  -----------  -------------  -----------
2.4.17rmap12a    1   22.85  32.2%   1.15  2.2%   13.10  83.5%   0.71  1.6%
2.4.18pre4aa1    1   11.23  21.3%   3.12  4.8%   11.92  66.1%   0.66  1.3%


Sequential Read CPU Efficiency
2.4.18pre4aa1   11.23 / .213 = 52.723
2.4.17rmap12a   22.85 / .322 = 70.962
2.4.17rmap12a was 35% more CPU efficent.

Random Read CPU Efficiency
2.4.18pre4aa1   3.12 / .048 = 65.000
2.4.17rmap12a   1.15 / .022 = 52.272
2.4.18pre4aa1 was 24% more CPU efficient.

Sequential Write CPU Efficiency
2.4.18pre4aa1   11.92 / .661 = 18.033
2.4.17rmap12a   13.10 / .835 = 15.688
2.4.18pre4aa1 was 15% more CPU efficient.

Random Write CPU Efficiency
2.4.18pre4aa1   .066 / .013 = 50.767
2.4.17rmap12a   .071 / .016 = 44.375
2.4.18pre4aa1 was 14% more CPU efficient.

> It would be interesting to see the dbench dots from both
> -aa and -rmap ;)

All the dots are at:
http://home.earthlink.net/~rwhron/kernel/dots/

-- 
Randy Hron

