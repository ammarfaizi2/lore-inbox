Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVDAC2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVDAC2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 21:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVDAC2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 21:28:39 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:59055 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262570AbVDAC2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 21:28:37 -0500
Subject: Re: NFS client latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050331145015.GA4830@elte.hu>
References: <1112237239.26732.8.camel@mindpipe>
	 <1112240918.10975.4.camel@lade.trondhjem.org>
	 <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org>
	 <20050331073017.GA16577@elte.hu>
	 <1112270304.10975.41.camel@lade.trondhjem.org>
	 <1112272451.10975.72.camel@lade.trondhjem.org>
	 <20050331135825.GA2214@elte.hu>
	 <1112279522.20211.8.camel@lade.trondhjem.org>
	 <20050331143930.GA4032@elte.hu>  <20050331145015.GA4830@elte.hu>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 21:28:36 -0500
Message-Id: <1112322516.2509.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 16:50 +0200, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > So the overhead you are currently seeing should just be that of 
> > > iterating through the list, locking said requests and adding them to 
> > > our private list.
> > 
> > ah - cool! This was a 100 MB writeout so having 3.7 msecs to process 
> > 20K+ pages is not unreasonable. To break the latency, can i just do a 
> > simple lock-break, via the patch below?
> 
> with this patch the worst-case latency during NFS writeout is down to 40 
> usecs (!).
> 
> Lee: i've uploaded the -42-05 release with this patch included - could 
> you test it on your (no doubt more complex than mine) NFS setup?

This fixes all the NFS related latency problems I was seeing.  Now the
longest latency from an NFS kernel compile with "make -j64" is 391 usecs
in get_swap_page.

Lee

