Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUIXHiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUIXHiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 03:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUIXHiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 03:38:46 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:55787 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268534AbUIXHio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 03:38:44 -0400
Date: Fri, 24 Sep 2004 09:40:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm3-S5
Message-ID: <20040924074026.GB17368@elte.hu>
References: <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <415384E1.2080907@cybsft.com> <415394EE.50106@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415394EE.50106@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> The following, on top of Ingo's patch above, fixes the problem with
> dropping new connections and doesn't have any adverse affects that
> I've seen:
> 
> --- linux-2.6.9-rc2-pre-mm3/net/ipv4/tcp_output.c.orig  2004-09-23 
> 22:16:42.249435870 -0500
> +++ linux-2.6.9-rc2-pre-mm3/net/ipv4/tcp_output.c       2004-09-23 
> 22:12:03.911811945 -0500
> @@ -699,11 +699,6 @@
> 
>                         tcp_minshall_update(tp, mss_now, skb);
>                         sent_pkts = 1;
> -                       /*
> -                        * Break out early - we'll continue later:
> -                        */
> -                       if (softirq_need_resched())
> -                               break;

hm, ok, i'll revert this in my tree. I suspect we'll see some latencies
resurfacing under high network load again, but correctness goes first
obviously. If then we'll have to find some other method to break that
critical path.

	Ingo
