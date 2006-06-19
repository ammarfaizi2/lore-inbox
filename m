Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWFSX75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWFSX75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFSX75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:59:57 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:46541 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932242AbWFSX74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:59:56 -0400
Message-ID: <44973A79.6070307@bigpond.net.au>
Date: Tue, 20 Jun 2006 09:59:53 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kernel@kolivas.org, sam@vilain.net, bsingharora@gmail.com,
       vatsa@in.ibm.com, dev@openvz.org, linux-kernel@vger.kernel.org,
       efault@gmx.de, kingsley@aurema.com, ckrm-tech@lists.sourceforge.net,
       mingo@elte.hu, rene.herman@keyaccess.nl
Subject: Re: [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618025046.77b0cecf.akpm@osdl.org>
In-Reply-To: <20060618025046.77b0cecf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 19 Jun 2006 23:59:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> If the task can exceed its cap without impacting any other tasks (ie: there
> is spare idle capacity), what happens?  I trust that spare capacity gets
> used?

As I said in another reply, the answer to this is yes for soft caps and 
how good a job was demonstrated by the kernbench results that I 
included.  Repeated here:

Average Optimal -j 8 Load Run:

                   Vanilla          Patch Applied    Soft Cap 0%

Elapsed Time      1056.1   (1.92)  1048.2   (0.62)  1064.1   (1.59)
User Time         1908.1   (1.09)  1895.2   (1.30)  1926.6   (1.39)
System Time        181.7   (0.60)   177.5   (0.74)   173.8   (1.07)
    Total          2089.8           2072.7           2100.4
Percent CPU        197.6   (0.55)   197.0   (0)      197.0   (0)
Context Switches 49253.6 (136.31) 48881.4  (92.03) 92490.8 (163.71)
Sleeps           28038.8 (228.11) 28136.0 (250.65) 25769.4 (280.40)

Note that the (slight) increase in the elapsed time when using a soft 
cap of zero can be directly attributed to the increase in CPU usage due 
to the cap overhead (an approximate increase of 16 seconds for elapsed 
time with an approximate increase of 28 seconds (for two CPUs) in CPU 
time consumed when comparing the "patch applied" and "soft cap 0%" numbers).

I think this illustrates that (for soft caps) spare capacity is not wasted?

 >  (Is this termed "work conserving"?)

I don't know but it sounds apt.

Peter
PS For ordinary users, I think that the ability to run jobs in the 
background by using a soft cap of zero is the most useful thing that 
this patch provides.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
