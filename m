Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUHRMZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUHRMZC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUHRMZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:25:01 -0400
Received: from pD951734E.dip.t-dialin.net ([217.81.115.78]:49030 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S266129AbUHRMX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:23:26 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816120933.GA4211@elte.hu>
References: <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu>  <20040816120933.GA4211@elte.hu>
Content-Type: text/plain
Message-Id: <1092831726.5777.160.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 14:22:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> here's -P2:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P2
> 
> Changes since -P1:
> 
>  - trace interrupted kernel code (via hardirqs, NMIs and pagefaults)
> 
>  - yet another shot at trying to fix the IO-APIC/USB issues.
> 
>  - mcount speedups - tracing should be faster
> 
> 	Ingo
> -

The next problem I have relates to irq sharing. 
On my laptop I can't avoid it :
 10:    1070631          XT-PIC  yenta, yenta, uhci_hcd, Intel
82801CA-ICH3, hdsp, eth0
If I set the sound card's interrupt to be non threaded, then I get a
rather long non preemptible section :
http://www.undata.org/~thomas/irq_sharing.trace

As a side note, and this has already been reported here several times,
the SA_INTERRUPT flag set notably by the sound card drivers handlers is
not honored on current kernels if the device is not the first one to be
registered. A simple fix would be to add SA_INTERRUPT handlers at the
beginning instead of the end of the irq queue in setup_irq.

Similarly, when using SA_SAMPLE_RANDOM, all devices on the given irq
contribute to the entropy, even those that have a predictable interrupt
rate (e.g. sound cards), and/or for which the number of interrupts could
outweight the number of interrupts of the original SA_SAMPLE_RANDOM
driver. 

Thomas


