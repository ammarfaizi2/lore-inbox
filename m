Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUC3Vai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUC3Vai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:30:38 -0500
Received: from mail1.slu.se ([130.238.96.11]:63688 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S261317AbUC3Vac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:30:32 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16489.59080.303710.986410@robur.slu.se>
Date: Tue, 30 Mar 2004 23:29:44 +0200
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <20040330204731.GG3808@dualathlon.random>
References: <20040329184550.GA4540@in.ibm.com>
	<20040329222926.GF3808@dualathlon.random>
	<20040330144324.GA3778@in.ibm.com>
	<20040330195315.GB3773@in.ibm.com>
	<20040330204731.GG3808@dualathlon.random>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

 > I see what's going on now, yes my patch cannot help. the workload is
 > simply generating too much hardirq load, and it's like if we don't use
 > softirq at all but that we process the packet inside the hardirq for
 > this matter. As far as RCU is concerned it's like if there a no softirq
 > at all but that we process everything in the hardirq.
 > 
 > so what you're looking after is a new feature then:
 > 
 > 1) rate limit the hardirqs
 > 2) rate limit only part of the irq load (i.e. the softirq, that's handy
 >    since it's already splitted out) to scheduler-aware context (not
 >    inside irq context anymore)
 > 3) stop processing packets in irqs in the first place (NAPI or similar)

 Hello!

 No Andrea it pure softirq workload. Interfaces runs with irq disabled 
 at this load w. NAPI. Softirq's are run from spin_unlock_bh etc when 
 doing route lookup and GC. And the more fine-grained locking we do the 
 the more do_softirq's are run.

 Cheers.
						--ro
