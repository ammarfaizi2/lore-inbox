Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUHBK4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUHBK4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUHBK4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:56:49 -0400
Received: from holomorphy.com ([207.189.100.168]:36523 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266366AbUHBK4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:56:47 -0400
Date: Mon, 2 Aug 2004 03:56:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
Message-ID: <20040802105644.GD2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com> <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe> <20040802073938.GA8332@elte.hu> <1091435237.3024.9.camel@mindpipe> <20040802092855.GA15894@elte.hu> <20040802100815.GA18349@elte.hu> <20040802101840.GB2334@holomorphy.com> <20040802103516.GA20584@elte.hu> <20040802105100.GA22855@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802105100.GA22855@elte.hu>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar <mingo@elte.hu> wrote:
>>  (kjournald/189): 997us non-preemptible critical section violated 100 us
>>  preempt threshold starting at journal_commit_transaction+0x642/0x2b10
>>  and ending at journal_commit_transaction+0x24ce/0x2b10
>>   [<c0105d7e>] dump_stack+0x1e/0x30
>>   [<c011ad0f>] dec_preempt_count+0x3f/0x50
>>   [<c01dfd3e>] journal_commit_transaction+0x24ce/0x2b10
>>   [<c01e3bf4>] kjournald+0x1a4/0x710
>>   [<c0102765>] kernel_thread_helper+0x5/0x10

On Mon, Aug 02, 2004 at 12:51:00PM +0200, Ingo Molnar wrote:
> ok, found it - it's a false positive in commit.c due to need_resched()
> not doing a touch_preempt_timing(). Newest patch at:
>  http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc2-O2

Great, thanks for fixing this up.


On Mon, Aug 02, 2004 at 12:51:00PM +0200, Ingo Molnar wrote:
> i changed need_resched() to do a touch_preempt_timing() - this also got
> rid of some other changes. All code i checked really takes
> need_resched() seriously if it looks at it - any reason why you didnt
> add this to need_resched() before?

I was less sure of this as I hadn't audited need_resched() callers to
be sure they did cond_resched() or similar. As you've carried out the
audit of need_resched() callers, you have the certainty I didn't.


-- wli
