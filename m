Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVCPKv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVCPKv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVCPKv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:51:28 -0500
Received: from mx1.elte.hu ([157.181.1.137]:42419 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262347AbVCPKvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:51:23 -0500
Date: Wed, 16 Mar 2005 11:51:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
Message-ID: <20050316105108.GA19570@elte.hu>
References: <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org> <20050316101906.GA17328@elte.hu> <20050316024022.6d5c4706.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316024022.6d5c4706.akpm@osdl.org>
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

> > How much would the +4/+8 bytes size increase in
> > buffer_head [on SMP] be frowned upon? 
> 
> It wouldn't be the end of the world.  I'm not clear on what bits of
> the rt-super-low-latency stuff is intended for mainline though?

in the long run, most of it. There are no conceptual barriers so far,
the -RT tree consists of lots of small details and the PREEMPT_RT
framework itself. We are trying to solve (and merge) the small details
first (in upstream), so that PREEMPT_RT itself becomes uncontroversial.

(and it's not really the low latency that matters mainly - more valuable
is the fact that under PREEMPT_RT high latencies are statistically much
more unlikely [you need to do some really intentional and easy to see
things to introduce high latencies], while in the current upstream
kernel, high latencies are often side-effects of pretty normal kernel
coding activities, so low latencies are always a catch-up game that can
never be truly won for sure. So yes, while a 10 usec worst-case latency
under arbitrary Linux workloads [on the right hardware] is indeed sexy,
more important is that things are much more deterministic and hence much
more trustable from a hard-RT POV.)

	Ingo
