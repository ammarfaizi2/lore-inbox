Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVBQHw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVBQHw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 02:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVBQHw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 02:52:29 -0500
Received: from mx1.elte.hu ([157.181.1.137]:14056 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262184AbVBQHwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 02:52:25 -0500
Date: Thu, 17 Feb 2005 08:52:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@davemloft.net>
Cc: mgross@linux.intel.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Message-ID: <20050217075212.GA21621@elte.hu>
References: <200502141240.14355.mgross@linux.intel.com> <200502141429.11587.mgross@linux.intel.com> <20050215104153.GB19866@elte.hu> <200502151006.44809.mgross@linux.intel.com> <20050216051645.GB15197@elte.hu> <20050216081143.50d0a9d6.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216081143.50d0a9d6.davem@davemloft.net>
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


* David S. Miller <davem@davemloft.net> wrote:

> > Maybe the networking
> > stack would break if we allowed the TIMER softirq (thread) to preempt
> > the NET softirq (threads) (and vice versa)?
> 
> The major assumption is that softirq's run indivisibly per-cpu.
> Otherwise the per-cpu queues of RX and TX packet work would get
> corrupted.

as long as it stays on a single CPU, could we allow softirq contexts to
preempt each other? I.e. we'd keep the per-CPU assumption (that is fair
and needed for performance anyway), but we'd allow NET_TX to preempt
NET_RX and vice versa. Would this corrupt the rx/tx queues? (i suspect
it would.)

(anyway, by adding an explicit no-preempt section around the 'take
current rx queue private, then process it' on PREEMPT_RT it could be
made safe. I'm wondering whether there are any other deeper assumptions
about atomic separation of softirq contexts.)

	Ingo
