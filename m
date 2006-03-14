Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWCNJ7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWCNJ7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbWCNJ7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:59:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:653 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751776AbWCNJ7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:59:12 -0500
Date: Tue, 14 Mar 2006 10:56:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
Message-ID: <20060314095654.GA8756@elte.hu>
References: <1142329861.9710.16.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142329861.9710.16.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> Greetings,
> 
> The patchlet below removes the sleep_avg multiplier.  This multiplier
> was necessary back when we had 10 seconds of dynamic range in sleep_avg,
> but now that we only have one second, it causes that one second to be
> compressed down to 100ms in some cases.  This is particularly noticeable
> when compiling a kernel in a slow NFS mount, and I believe it to be a
> very likely candidate for other recently reported network related
> interactivity problems.
> 
> In testing, I can detect no negative impact of this removal.  IMHO, this
> constitutes a bug-fix, and as such is suitable for 2.6.16.
> 
> 	-Mike
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>

looks good to me. The biggest complaint against the current scheduler is 
over-eager interactivity boosting - this patch moderates that in a 
smooth way.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
