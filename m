Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVC3OVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVC3OVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVC3OVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:21:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44428 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261910AbVC3OVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:21:39 -0500
Date: Wed, 30 Mar 2005 16:20:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS client latencies
Message-ID: <20050330142056.GA3043@elte.hu>
References: <1112137487.5386.33.camel@mindpipe> <1112138283.11346.2.camel@lade.trondhjem.org> <1112139155.5386.35.camel@mindpipe> <1112139263.11892.0.camel@lade.trondhjem.org> <20050330080224.GB19683@elte.hu> <1112191860.10634.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112191860.10634.29.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > the comment suggests that this is optimized for append writes (which is 
> > quite common, but by far not the only write workload) - but the 
> > worst-case behavior of this code is very bad. How about disabling this 
> > sorting altogether and benchmarking the result? Maybe it would get 
> > comparable coalescing (higher levels do coalesce after all), but wastly 
> > improved CPU utilization on the client side. (Note that the server 
> > itself will do sorting of any write IO anyway, if this is to hit any 
> > persistent storage - and if not then sorting so agressively on the 
> > client side makes little sense.)
> 
> No. Coalescing on the client makes tons of sense. The overhead of
> sending 8 RPC requests for 4k writes instead of sending 1 RPC request
> for a single 32k write is huge: among other things, you end up tying up
> 8 RPC slots on the client + 8 nfsd threads on the server instead of just
> one of each.

yes - coalescing a few pages makes sense, but linearly scanning 
thousands of entries is entirely pointless.

	Ingo
