Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUDHOHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUDHOHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:07:50 -0400
Received: from mail1.slu.se ([130.238.96.11]:223 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S261582AbUDHOHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:07:48 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16501.23715.401825.10935@robur.slu.se>
Date: Thu, 8 Apr 2004 16:07:31 +0200
To: kuznet@ms2.inr.ac.ru
Cc: Robert.Olsson@data.slu.se (Robert Olsson), dipankar@in.ibm.com,
       andrea@suse.de (Andrea Arcangeli), davem@redhat.com (David S. Miller),
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <200404081329.RAA16178@yakov.inr.ac.ru>
References: <16498.43191.733850.18276@robur.slu.se>
	<200404081329.RAA16178@yakov.inr.ac.ru>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kuznet@ms2.inr.ac.ru writes:

 > BTW what's about performance in this extremal situation?

 First I used the patch to defer all softirq's to ksoftirq with call_rcu_bh()
 patch. Sofar this has been the best combination giving both pure sofirq 
 performance and also good response from the userland apps.

 I also tried other TCP apps netperf and could note any performance 
 degradation which I was expecting.
 
 > Also, Robert, let's count the numbers again. With this change you should
 > have latency much less 100msec when priority of ksoftirqd is high.
 > So, rcu problem must be solved at current flow rates.
 > This enforces me to suspect we have another source of overflows.

 Certainly. I said to Dipankar we should not expect all overflows to disappear
 the setup I use now. But the call_rcu_bh() patch improved things so it cured 
 some latency caused by RCU. But I don't think we can do much better now in 
 terms dst overflow. 

 > F.e. one silly place could be that you set gc_min_interval via sysctl,

 I should not...

 > which uses second resolution (yup :-(). With one second you get maximal
 > ip_rt_max_size/1 second flow rate, it is _not_ a lot.

 From /proc
 gc_min_interval = 0
 max_size = 262144

 Cheers.
						--ro
