Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSB0SVF>; Wed, 27 Feb 2002 13:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292866AbSB0STU>; Wed, 27 Feb 2002 13:19:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22477 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292865AbSB0SSz>;
	Wed, 27 Feb 2002 13:18:55 -0500
Date: Wed, 27 Feb 2002 10:19:39 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: lse-tech@lists.sourceforge.net, viro@math.psu.edu
Subject: lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Message-ID: <10460000.1014833979@w-hlinder.des>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Congratulations to everyone working to reduce contention of the
Big Kernel Lock. According to this benchmark your work has paid off!
John Hawkes of SGI asked me to Beta test his 2.5.5 version of lockmeter 
last night (that's what I get for asking when it would be out). The results 
were interesting enough to post. 
	All three runs were on an 8-way SMP system running dbench with 
up to 16 clients 10 times each. The results are at http://lse.sf.net/locking . 
Throughput numbers are not included yet, I need to rerun dbench without 
lockmeter to get accurate throughput results.
	
(Read down the Con(tention) column)
TOTAL is for the whole system
kernel_flag is for every function holding BKL combined.


SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

2.4.17:

       13.7%  2.2us(  43ms)   31us(  43ms)(20.0%) 232292367 86.3% 13.7% 0.00%  *TOTAL*

 33.9% 40.3%   11us(  43ms)   51us(  43ms)( 8.2%)  19725127 59.7% 40.3%    0%  kernel_flag


2.5.3:
       11.1%  1.0us(  21ms)  8.2us(  18ms)( 3.8%) 738953957 88.9% 11.1% 0.00%  *TOTAL*

 10.4% 22.6%  8.3us(  21ms)   23us(  18ms)(0.81%)  27982565 77.4% 22.6%    0%  kernel_flag


2.5.5: 

       8.6%  1.6us( 100ms)   30us(  86ms)( 9.4%) 783373441 91.4%  8.6% 0.00%  *TOTAL*

 1.2% 0.33%  2.5us(  50ms) 1167us(  43ms)(0.23%)  12793605 99.7% 0.33%    0%  kernel_flag



Hanna Linder
IBM Linux Technology Center
hannal@us.ibm.com

