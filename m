Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUHBKjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUHBKjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUHBKjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:39:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37072 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266449AbUHBKeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:34:14 -0400
Date: Mon, 2 Aug 2004 12:35:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
Message-ID: <20040802103516.GA20584@elte.hu>
References: <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe> <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com> <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe> <20040802073938.GA8332@elte.hu> <1091435237.3024.9.camel@mindpipe> <20040802092855.GA15894@elte.hu> <20040802100815.GA18349@elte.hu> <20040802101840.GB2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802101840.GB2334@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> On Mon, Aug 02, 2004 at 12:08:15PM +0200, Ingo Molnar wrote:
> > i've uploaded a new version of the patch, this solves a problem when
> > using a smaller than 1000 usecs threshold: idle time got accounted as
> > delay too which flooded the log. The new patch makes idle=poll the
> > default and that function calls touch_preempt_timing().
> 
> Sorry about not updating things, but there's also another bug, which
> is that touch_preempt_timing() forgets to check if the threshold has
> been violated in the interim.

i've re-uploaded the -O2 patch with this fixed:

 http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc2-O2

but i'm still seeing some latencies:

 (kjournald/189): 997us non-preemptible critical section violated 100 us
 preempt threshold starting at journal_commit_transaction+0x642/0x2b10
 and ending at journal_commit_transaction+0x24ce/0x2b10

  [<c0105d7e>] dump_stack+0x1e/0x30
  [<c011ad0f>] dec_preempt_count+0x3f/0x50
  [<c01dfd3e>] journal_commit_transaction+0x24ce/0x2b10
  [<c01e3bf4>] kjournald+0x1a4/0x710
  [<c0102765>] kernel_thread_helper+0x5/0x10

these should not happen with vp=3 and max_sectors=16. Could you
double-check the patch above, does it have any other timing thinko?

	Ingo
