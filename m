Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUGSLiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUGSLiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 07:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUGSLiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 07:38:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51390 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265002AbUGSLiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 07:38:12 -0400
Date: Mon, 19 Jul 2004 13:34:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040719113431.GA11155@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <1089687168.10777.126.camel@mindpipe> <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719104837.GA9459@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> ATA hardirq latency can be as high as 700 usecs under load even on
> modern hw, when big DMA requests are created with long scatter-gather
> lists. We also moved some of the page IO completion code into irq
> context which further increased hardirq latencies. Since these all
> touch cold cachelines it all adds up quite quickly.

typically all of this happens with irqs enabled (unmask=1), but it still
increases scheduling latencies.

with the default DMA setup of today's ATA hw there can be a maximum of
256 entries in the sg-table all zapped in ide_end_request() ->
__end_that_request_first().

Plus the IDE driver also builds the sg-table of the next request in
hardirq context. (ide_build_dmatable() and ide_build_sglist()).

	Ingo
