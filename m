Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264513AbRFTRsV>; Wed, 20 Jun 2001 13:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264515AbRFTRsL>; Wed, 20 Jun 2001 13:48:11 -0400
Received: from gateway.sequent.com ([192.148.1.10]:54937 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S264513AbRFTRsH>; Wed, 20 Jun 2001 13:48:07 -0400
Date: Wed, 20 Jun 2001 10:48:00 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Threads FAQ entry incomplete
Message-ID: <20010620104800.D1174@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would take exception with the following statements in the FAQ:

"However, the Linux scheduler is designed to work well with a small
number of running threads. Best results are obtained when the number
of running theads equals the number of processors."

I agree that the Linux scheduler is designed to work well with
a small number of threads.  However, when the number of processors
is no longer small, the Linux scheduler starts to suffer if the
number of threads equals the number of processors.  For example
consider the following data from TPC-H benchmark runs (2.4.3 kernel).

                      2-CPU          4-CPU          8-CPU
-------------------------------------------------------------
Mean runqueue         4.93 (18)      7.25 (23)      8.21 (35)
length (max)

runqueue lock         2.4%           9.6%           47.2%
contention

Mean lock hold        1.5us          2.2us          3.9us
time

Mean lock wait        2.8us          3.9us          10us
time

Note that in the 2 and 4 CPU cases, the run queue length is
aprox 2x the number of CPUs and the scheduler seems to perform
reasonably well with respect to locking.  In the 8 CPU case,
the number of tasks is aprox equal to the number of CPUs yet
scheduler performance has gone downhill.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
