Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUHTK1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUHTK1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUHTK1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:27:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3997 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266219AbUHTK1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:27:35 -0400
Date: Fri, 20 Aug 2004 12:27:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
Message-ID: <20040820102732.GA14622@elte.hu>
References: <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <1092972918.10063.11.camel@krustophenia.net> <20040820081319.GA4321@elte.hu> <1092993242.10063.66.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092993242.10063.66.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> This is an extreme load situation, so I don't think it will be a
> real-world problem.  I have not seen it under any normal workload.

well, 9 msecs is still not nice. I've been able to trigger larger than
10msec latencies too on a 2 GHz box.

> What about this one:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8.1-P4#/var/www/2.6.8.1-P4/netif_receive_skb_latency_trace.txt
> 
> This appears during normal use.

hm, tcp_collapse() in net/ipv4/tcp_input.c. Could you try to just return
from that function?  Collapsing skbs of a given socket is not a
necessary functionality (it is only a 'nice' thing to have in OOM
situations) and it indeed can introduce quite high latencies.

	Ingo
