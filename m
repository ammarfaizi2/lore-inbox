Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRJBNW5>; Tue, 2 Oct 2001 09:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273794AbRJBNWh>; Tue, 2 Oct 2001 09:22:37 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:11506 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273783AbRJBNWR>; Tue, 2 Oct 2001 09:22:17 -0400
Date: Tue, 2 Oct 2001 18:58:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cacheline align rt_cache_stat struct
Message-ID: <20011002185816.A8643@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The per-cpu rt_cache_stat structure should be padded to cacheline
to avoid sharing of cachelines between different CPUs. Here is a patch
to do that for SMP kernels.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


diff -urN linux-2.4.10/include/net/route.h linux-2.4.10+rt/include/net/route.h
--- linux-2.4.10/include/net/route.h	Thu Sep 27 11:59:45 2001
+++ linux-2.4.10+rt/include/net/route.h	Tue Oct  2 18:34:45 2001
@@ -105,7 +105,7 @@
         unsigned int out_hit;
         unsigned int out_slow_tot;
         unsigned int out_slow_mc;
-};
+} ____cacheline_aligned_in_smp;
 
 extern struct ip_rt_acct *ip_rt_acct;
 

