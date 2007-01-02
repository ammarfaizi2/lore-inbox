Return-Path: <linux-kernel-owner+w=401wt.eu-S932770AbXABLQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbXABLQT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbXABLQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:16:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35602 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbXABLQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:16:18 -0500
Date: Tue, 2 Jan 2007 12:12:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] KVM: Improve interrupt response
Message-ID: <20070102111256.GA27541@elte.hu>
References: <20061231132232.A98E92500F7@il.qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061231132232.A98E92500F7@il.qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> From: Dor Laor <dor.laor@qumranet.com>
> 
> The current interrupt injection mechanism might delay an interrupt 
> under the following circumstances:
> 
>  - if injection fails because the guest is not interruptible (rflags.IF clear,
>    or after a 'mov ss' or 'sti' instruction).  Userspace can check rflags,
>    but the other cases or not testable under the current API.
>  - if injection fails because of a fault during delivery.  This probably
>    never happens under normal guests.
>  - if injection fails due to a physical interrupt causing a vmexit so that
>    it can be handled by the host.
> 
> in all cases the guest proceeds without processing the interrupt, 
> reducing the interactive feel and interrupt throughput of the guest.
> 
> This patch fixes the situation by allowing userspace to request an 
> exit when the 'interrupt window' opens, so that it can re-inject the 
> interrupt at the right time.  Guest interactivity is very visibly 
> improved.

Andrew, i'd argue for this to be included in v2.6.20, because it's an 
obvious bugfix. I've tested this patch and it's included in current -rt 
and i saw no regressions.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
