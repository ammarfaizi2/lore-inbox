Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUHYWhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUHYWhw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUHYWcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:32:50 -0400
Received: from jade.spiritone.com ([216.99.193.136]:23466 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266200AbUHYW3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:29:53 -0400
Date: Wed, 25 Aug 2004 15:29:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Nick Piggin <piggin@cyberone.com.au>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance of -mm2 and -mm4
Message-ID: <7230000.1093472977@[10.10.2.4]>
In-Reply-To: <cone.1093310997.326407.10766.502@pc.kolivas.org>
References: <336080000.1093280286@[10.10.2.4]> <200408231431.25986.jbarnes@engr.sgi.com> <412A8EAD.3060907@cyberone.com.au> <cone.1093310997.326407.10766.502@pc.kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> The -mm4 looks more like sched stuff to me (copy_to/from_user, etc),
>>>> but the -mm2 stuff looks like something else. Buggered if I know what.
>>>> -mm3 didn't compile cleanly, so I didn't bother, but I prob can if you
>>>> like.
>>>> 
>>> 
>>> If you suspect the scheduler, you could try bumping SD_NODES_PER_DOMAIN in 
>>> kernel/sched.c to a larger value (e.g. the number of nodes in your system).  
>>> That'll make the scheduler balance more aggressively across the whole system.
>>> 
>>> 
>> 
>> Try increasing /proc/sys/kernel/base_timeslice as well.
> 
> Or back out nicksched.patch

Yeah, that mostly fixed it.

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                  2.6.8.1       44.82       97.19      574.55     1497.33
              2.6.8.1-mm4       46.82      107.47      594.15     1497.33
           2.6.8.1-mm4-nn       44.93       96.33      576.44     1496.33

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                  2.6.8.1       43.90       87.76      572.94     1505.67
              2.6.8.1-mm4       45.87       97.60      595.23     1510.00
           2.6.8.1-mm4-nn       44.53       90.71      575.68     1495.67

