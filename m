Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266677AbUGVCDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUGVCDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUGVCDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:03:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28593 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266677AbUGVCDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:03:38 -0400
Date: Wed, 21 Jul 2004 17:44:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721154428.GA24374@elte.hu>
References: <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FE545E.3050300@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> What do you think about deferring softirqs just while in critical
> sections?
> 
> I'm not sure how well this works, and it is CONFIG_PREEMPT only but in
> theory it should prevent unbounded softirqs while under locks without
> taking the performance hit of doing the context switch.

i dont think this is sufficient. A high-prio RT task might be performing
something that is important to it but isnt in any critical section. This
includes userspace processing. We dont want to delay it with softirqs.

	Ingo
