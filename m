Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUGSKra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUGSKra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 06:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUGSKr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 06:47:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58583 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264965AbUGSKr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 06:47:26 -0400
Date: Mon, 19 Jul 2004 12:48:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040719104837.GA9459@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <1089687168.10777.126.camel@mindpipe> <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089705440.20381.14.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-0.908, required 5.9,
	autolearn=not spam, BAYES_10 -0.91
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Just as a reference point, what do you think is the longest delay I
> *should* be seeing?  I recall hearing that BEOS guaranteed that
> interrupts are never disabled for more than 50 usecs.  This seems
> achievable, as the average delay I am seeing is 15 usecs.

ATA hardirq latency can be as high as 700 usecs under load even on
modern hw, when big DMA requests are created with long scatter-gather
lists. We also moved some of the page IO completion code into irq
context which further increased hardirq latencies. Since these all touch
cold cachelines it all adds up quite quickly.

	Ingo
