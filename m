Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVCPKaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVCPKaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVCPKaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:30:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:58287 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262324AbVCPKaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:30:06 -0500
Date: Wed, 16 Mar 2005 11:29:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
Message-ID: <20050316102951.GA18247@elte.hu>
References: <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org> <20050316101209.GA16893@elte.hu> <20050316022638.237f72cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316022638.237f72cd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> I forget how much of the 1000% came from that, but it was quite a lot.
> 
> Removing the BKL was the first step.  That took the context switch
> rate under high load from ~10,000/sec up to ~300,000/sec.  Because the
> first thing a CPU hit on entry to the fs was then a semaphore. 
> Performance rather took a dive.
> 
> Of course the locks also became much finer-grained, so the contention
> opportunities lessened.  But j_list_lock and j_state_lock have fs-wide
> scope, so I'd expect the context switch rate to go up quite a lot
> again.
> 
> The hold times are short, and a context switch hurts rather ore than a
> quick spin.

which particular workload was this - dbench? (I can try PREEMPT_RT on an
8-way, such effects will show up tenfold.)

	Ingo
