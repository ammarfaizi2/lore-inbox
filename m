Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUHSK1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUHSK1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUHSK1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:27:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27011 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264915AbUHSK1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:27:47 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040819085643.GA4751@elte.hu>
References: <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <1092902417.8432.108.camel@krustophenia.net>
	 <20040819084001.GA4098@elte.hu>
	 <1092905104.8432.116.camel@krustophenia.net>
	 <20040819085643.GA4751@elte.hu>
Content-Type: text/plain
Message-Id: <1092911341.1739.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 06:29:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 04:56, Ingo Molnar wrote:
> > > > Any comments on the unmap_vmas issue?
> > > 
> > > wli indicated he's working on the pagetable zapping critical section
> > > issue - wli?
> 
> actually - the unmap_vmas() issue might be different. Could you change
> the '32' in this part of mm/memory.c:
> 
> # define ZAP_BLOCK_SIZE \
>                 (voluntary_preemption ? (32 * PAGE_SIZE) : __ZAP_BLOCK_SIZE)
> 
> to 16? Does that roughly halve the ~180 usec latency?
> 

Yes, this takes care of it.  Now the dominant latency is the 142us
latency from the via-rhine driver, which is fixed by using the driver
from -mm (specifically it's fixed in bk-netdev.patch).

Lee

