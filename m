Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTEURw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 13:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTEURw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 13:52:27 -0400
Received: from [208.186.192.194] ([208.186.192.194]:3292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262231AbTEURwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 13:52:24 -0400
Subject: [DB WORKLOAD]Hyperthreaded runs with DBT2
From: Mary Edie Meredith <maryedie@osdl.org>
To: lse-tech <lse-tech@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Open Source Development Lab
Message-Id: <1053540326.16526.4598.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 May 2003 11:05:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Members of the LTC and OSDL(TM) have been working on a project
to study Linux (R) 2.5 performance on Hyperthreaded platforms.

We have results from running the OSDL-DBT2 OLTP workloads where
we compare 2.4.21rc1* to 2.5.68* and 2.5.68* with Ingo's
sched-2.5.68-B2 patch.  We also investigated HT scaling by
comparing the metrics with 2.5.68* having hyperthreading turned
off.

We see exceptional improvement(64%)comparing 2.5.68 with HT on
versus HT off with the Cached CPU intensive workload. Surprisingly,
we also see very good improvement (22-23%) with the non-cached I/O
intensive workload.

This could be because we use the SAPDB parameter MAXCPU set to 8 
matching the number of user task threads to the number of logical 
CPUs in the HT case. Although there are many more threads created, 
these 8 threads are very active.  This scenario may represent the 
case where CPU affinity and load balancing are at their optimal 
situation.

We see very little difference between the 2.4 kernel and the 2.5
kernels having hyperthreading turned on for either workload.  As we
understand, stock 2.4.21 doesn't have O(1) scheduler, stock 2.5.68
has O(1) scheduler, and stock 2.5.68+Ingo has hyperthreading patch ...
when the workload is subjected to those 2 schedulers, neither helps.

Any explanation?  



Here are the details:
System:
Intel(R) Xeon(TM) 4 Physical CPUs CPUs @ 1.50GHz MHz System 4GB memory
Database: SAP DB 7.0.3.25


Cached DBT2 workload, (DATA_CACHE 300,000 8k pages)
Kernel__________2.4.21rc1  2.5.68  2.5.68Ingo 2.5.68(no HT)
Phys/Log Procs  8L/4P      8L/4P   8L/4P      4L/4P
Average         4184       4226    4226       2572.2
StdDev          46.98      26.95    17.45     146.09

Compare to
2.4.21rc1 (%)    base(100) 101      101       60.87
Scaling rel to
2.5.68 no HT     n/a       1.64     1.64      base(1.0)

Non Cached DBT2 workload, DATA_CACHE 300,000
Kernel__________2.4.21rc1   2.5.68   2.5.68Ingo 2.5.68(no HT)
Phys/Log Procs 8L/4P        8L/4P    8L/4P      4L/4P
Average        2256.25      2297.75  2274.25    1868.33
StdDev         2.22         10.05     22.74      19.01

Compare to
2.4.21rc1 (%)   base(100)   101.84    100.8     81.31

Scaling rel to
2.5.68 no HT     n/a        1.23      1.22       base(1.0)



Raw Data and vmstat plots, configs, readprofiles :
http://www.osdl.org/projects/dbt2dev/results/HT/68I/results.html

DBT2 workload information:
http://www.osdl.org/projects/performance/dbt2-page.html

*All kernels tested include a patch to eliminate bounce buffers
for the DAC960.


Regards,

Mary Edie Meredith (maryedie@osdl.org)
Mark Wong (mwong@osdl.org)
Open Source Development Lab

Duc Vianney (dvianney@us.ibm.com)
Linux Technology Center, IBM(R)


