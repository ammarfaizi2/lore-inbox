Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVDAVVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVDAVVO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVDAVUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:20:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:55529 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262912AbVDAVSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 16:18:36 -0500
Subject: Re: NFS client latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050401043022.GA22753@elte.hu>
References: <20050331065942.GA14952@elte.hu>
	 <20050330231801.129b0715.akpm@osdl.org> <20050331073017.GA16577@elte.hu>
	 <1112270304.10975.41.camel@lade.trondhjem.org>
	 <1112272451.10975.72.camel@lade.trondhjem.org>
	 <20050331135825.GA2214@elte.hu>
	 <1112279522.20211.8.camel@lade.trondhjem.org>
	 <20050331143930.GA4032@elte.hu> <20050331145015.GA4830@elte.hu>
	 <1112322516.2509.28.camel@mindpipe>  <20050401043022.GA22753@elte.hu>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 16:18:34 -0500
Message-Id: <1112390315.7062.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 06:30 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > > ah - cool! This was a 100 MB writeout so having 3.7 msecs to process 
> > > > 20K+ pages is not unreasonable. To break the latency, can i just do a 
> > > > simple lock-break, via the patch below?
> > > 
> > > with this patch the worst-case latency during NFS writeout is down to 40 
> > > usecs (!).
> > > 
> > > Lee: i've uploaded the -42-05 release with this patch included - could 
> > > you test it on your (no doubt more complex than mine) NFS setup?
> > 
> > This fixes all the NFS related latency problems I was seeing.  Now the 
> > longest latency from an NFS kernel compile with "make -j64" is 391 
> > usecs in get_swap_page.
> 
> great! The latest patches (-42-08 and later) have the reworked 
> nfs_scan_list() lock-breaker, which should perform similarly.
> 
> i bet these NFS patches also improve generic NFS performance on fast 
> networks. I've attached the full patchset with all fixes and 
> improvements included - might be worth a try in -mm?

With tracing disabled on the C3 (which is the NFS server, don't ask),
the maximum latency during the same kernel compile is about 2ms.  So
tracing overhead probably doubled or tripled the latencies.

I'll try again with tracing enabled to determine whether these code
paths are related to the NFS server or not.  It's either going to be
that or the get_swap_page stuff.  But the client side is OK now.

Lee

