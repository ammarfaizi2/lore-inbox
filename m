Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277231AbRJDVEW>; Thu, 4 Oct 2001 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277229AbRJDVEN>; Thu, 4 Oct 2001 17:04:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15052 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S277224AbRJDVD4>;
	Thu, 4 Oct 2001 17:03:56 -0400
Date: Thu, 4 Oct 2001 14:04:17 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Context switch times
Message-ID: <20011004140417.C1245@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on a rewrite of our Multi-Queue scheduler
and am using the lat_ctx program of LMbench as a benchmark.
I'm lucky enough to have access to an 8-CPU system for use
during development.  One time, I 'accidently' booted the
kernel that came with the distribution installed on this
machine.  That kernel level is '2.2.16-22'.  The results of
running lat-ctx on this kernel when compared to 2.4.10 really
surprised me.  Here is an example:

2.4.10 on 8 CPUs:  lat_ctx -s 0 -r 2 results
"size=0k ovr=2.27
2 3.86

2.2.16-22 on 8 CPUS:  lat_ctx -s 0 -r 2 results
"size=0k ovr=1.99
2 1.44

As you can see, the context switch times for 2.4.10 are more
than double what they were for 2.2.16-22 in this example.  

Comments?

One observation I did make is that this may be related to CPU
affinity/cache warmth.  If you increase the number of 'TRIPS'
to a very large number, you can run 'top' and observe per-CPU
utilization.  On 2.2.16-22, the '2 task' benchmark seemed to
stay on 3 of the 8 CPUs.  On 2.4.10, these 2 tasks were run
on all 8 CPUs and utilization was about the same for each CPU.

-- 
Mike Kravetz                                  kravetz@us.ibm.com
IBM Peace, Love and Linux Technology Center
