Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWCNWjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWCNWjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCNWjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:39:04 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:27851 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751944AbWCNWjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:39:02 -0500
Subject: Re: 2.6.16-rc1: 28ms latency when process with lots of swapped
	memory exits
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060314210142.GA23458@elte.hu>
References: <1142352926.13256.117.camel@mindpipe>
	 <Pine.LNX.4.61.0603141812400.5882@goblin.wat.veritas.com>
	 <20060314210142.GA23458@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 17:38:58 -0500
Message-Id: <1142375939.24603.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 22:01 +0100, Ingo Molnar wrote:
> hm, where does the latency come from? We do have a lockbreaker in 
> unmap_vmas():
> 
>                         if (need_resched() ||
>                                 (i_mmap_lock &&
> need_lockbreak(i_mmap_lock))) {
>                                 if (i_mmap_lock) {
>                                         *tlbp = NULL;
>                                         goto out;
>                                 }
>                                 cond_resched();
>                         }
> 
> 
> why doesnt this break up the 28ms latency?
> 

But the preempt count is >= 2, doesn't that mean some other lock must be
held also, or someone called preempt_disable?

Lee

