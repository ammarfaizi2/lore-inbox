Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbSJNSaR>; Mon, 14 Oct 2002 14:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSJNSaR>; Mon, 14 Oct 2002 14:30:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63931 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262061AbSJNSaC>; Mon, 14 Oct 2002 14:30:02 -0400
Date: Tue, 15 Oct 2002 00:10:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Some dcache_rcu benchmark numbers
Message-ID: <20021015001033.B20643@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some numbers from the venerable "kernbench" (just kernel compilation)
to indicate how dcache_rcu (currently in -mm) helps us in the larger systems -

A 16-CPU NUMA-Q running make -j 24

2.5.40-mm2 [includes dcache_rcu]
--------------------------------
Elapsed: 19.622s User: 193.366s System: 42.498s CPU: 1201.6%  [average of 5]


2.5.40-mm2-no_dcache_rcu
------------------------
Elapsed: 20.47s User: 193.226s System: 47.548s CPU: 1175.8%  [average of 5]

IOW, a 10.6% reduction in system time. 

In general, we see significant gains with multiuser workloads in
larger systems.

I also did some "kernbench" testing on UP, 2-CPU and 4-CPU configurations
on a PIII xeon based system. The results are included below and they
show that there isn't any regression at the lower end of systems.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

----------------------------------------------------------------------------
UP :

2.5.42 vanilla
--------------

real	6m12.917s
user	5m48.164s
sys	0m22.677s

real	6m11.102s
user	5m48.103s
sys	0m22.635s

real	6m11.170s
user	5m48.003s
sys	0m22.753s

real	6m11.556s
user	5m48.018s
sys	0m22.728s

real	6m11.137s
user	5m48.185s
sys	0m22.592s


2.5.42 dc12
-----------

real	6m12.965s
user	5m48.261s
sys	0m22.596s

real	6m10.964s
user	5m48.059s
sys	0m22.539s

real	6m11.513s
user	5m48.295s
sys	0m22.402s

real	6m11.139s
user	5m48.040s
sys	0m22.685s

real	6m11.050s
user	5m47.969s
sys	0m22.720s
----------------------------------------------------------------------

2-CPU :

2.5.42 vanilla
--------------

real	3m28.108s
user	6m17.968s
sys	0m29.230s

real	3m25.086s
user	6m17.686s
sys	0m29.307s

real	3m24.832s
user	6m17.966s
sys	0m28.946s

real	3m24.733s
user	6m17.737s
sys	0m29.302s



2.5.42 dc12
-----------

real	3m26.774s
user	6m18.109s
sys	0m29.218s

real	3m25.381s
user	6m17.892s
sys	0m29.155s

real	3m25.719s
user	6m17.708s
sys	0m29.260s

real	3m25.777s
user	6m18.054s
sys	0m28.967s

----------------------------------------------------------------------------

4-CPU :

2.5.42-vanilla
--------------

real	1m47.632s
user	6m25.166s
sys	0m34.480s

real	1m48.780s
user	6m25.250s
sys	0m34.384s


real	1m47.451s
user	6m24.915s
sys	0m34.644s


real	1m48.709s
user	6m25.256s
sys	0m34.688s


real	1m47.797s
user	6m25.193s
sys	0m34.288s


real	1m47.586s
user	6m24.901s
sys	0m34.587s

real	1m47.452s
user	6m25.178s
sys	0m34.272s

real	1m47.969s
user	6m25.285s
sys	0m34.129s



2.5.42-dc12
-----------

real	1m47.638s
user	6m25.450s
sys	0m33.799s


real	1m47.602s
user	6m24.897s
sys	0m34.379s


real	1m48.559s
user	6m25.188s
sys	0m33.941s

real	1m47.945s
user	6m25.345s
sys	0m33.986s

real	1m47.639s
user	6m25.519s
sys	0m33.855s

real	1m48.976s
user	6m25.051s
sys	0m34.189s

real	1m47.447s
user	6m25.383s
sys	0m34.225s


real	1m47.448s
user	6m25.102s
sys	0m33.980s


