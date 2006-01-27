Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWA0Sz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWA0Sz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWA0Sz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:55:29 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56243 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751534AbWA0Sz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:55:29 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060126191809.GC6182@us.ibm.com>
References: <20060124080157.GA25855@elte.hu>
	 <1138090078.2771.88.camel@mindpipe> <20060124081301.GC25855@elte.hu>
	 <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com>
	 <20060124092330.GA7060@elte.hu> <1138095856.2771.103.camel@mindpipe>
	 <20060124162846.GA7139@in.ibm.com> <20060124213802.GC7139@in.ibm.com>
	 <1138224506.3087.22.camel@mindpipe>  <20060126191809.GC6182@us.ibm.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 13:55:22 -0500
Message-Id: <1138388123.3131.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 11:18 -0800, Paul E. McKenney wrote:
> >     Xorg-2154  0d.s.  213us : call_rcu_bh (rt_run_flush)
> >     Xorg-2154  0d.s.  215us : local_bh_enable (rt_run_flush)
> >     Xorg-2154  0d.s.  216us : local_bh_enable (rt_run_flush)
> >     Xorg-2154  0d.s.  217us : local_bh_enable (rt_run_flush)
> >     Xorg-2154  0d.s.  218us : local_bh_enable (rt_run_flush)
> >     Xorg-2154  0d.s.  219us : local_bh_enable (rt_run_flush)
> >     Xorg-2154  0d.s.  220us : local_bh_enable (rt_run_flush)
> >     Xorg-2154  0d.s.  222us : local_bh_enable (rt_run_flush)
> >     Xorg-2154  0d.s.  223us : call_rcu_bh (rt_run_flush)
> > 
> > [ zillions of these deleted ]
> > 
> >     Xorg-2154  0d.s. 7335us : local_bh_enable (rt_run_flush)
> 
> Dipankar's latest patch should hopefully address this problem.
> 
> Could you please give it a spin when you get a chance? 

Nope, no improvement at all, furthermore, the machine locked up once
under heavy disk activity.

I just got an 8ms+ latency from rt_run_flush that looks basically
identical to the above.  It's still flushing routes in huge batches:

$ grep 'call_rcu_bh (rt_run_flush)' /proc/latency_trace | wc -l
2738

Lee

