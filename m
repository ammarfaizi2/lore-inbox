Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUHBKxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUHBKxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUHBKxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:53:30 -0400
Received: from holomorphy.com ([207.189.100.168]:35243 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265181AbUHBKx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:53:29 -0400
Date: Mon, 2 Aug 2004 03:53:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
Message-ID: <20040802105324.GC2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1091234100.1677.41.camel@mindpipe> <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com> <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe> <20040802073938.GA8332@elte.hu> <1091435237.3024.9.camel@mindpipe> <20040802092855.GA15894@elte.hu> <20040802100815.GA18349@elte.hu> <20040802101840.GB2334@holomorphy.com> <20040802103516.GA20584@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802103516.GA20584@elte.hu>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 12:35:16PM +0200, Ingo Molnar wrote:
> i've re-uploaded the -O2 patch with this fixed:
>  http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc2-O2
> but i'm still seeing some latencies:
>  (kjournald/189): 997us non-preemptible critical section violated 100 us
>  preempt threshold starting at journal_commit_transaction+0x642/0x2b10
>  and ending at journal_commit_transaction+0x24ce/0x2b10
>   [<c0105d7e>] dump_stack+0x1e/0x30
>   [<c011ad0f>] dec_preempt_count+0x3f/0x50
>   [<c01dfd3e>] journal_commit_transaction+0x24ce/0x2b10
>   [<c01e3bf4>] kjournald+0x1a4/0x710
>   [<c0102765>] kernel_thread_helper+0x5/0x10
> these should not happen with vp=3 and max_sectors=16. Could you
> double-check the patch above, does it have any other timing thinko?

The false negative I mentioned was the last unresolved issue I knew of.
A brief examination of your updated patch didn't help me to spot any
false positives that haven't been reported yet.

It may help to find the line numbers corresponding to the above
(actually, the way the macros are hooked, the files, functions, line
numbers could be reported directly by the implementation) so we can get
a better idea if this is a false positive or a real 997us long non-
preemptible critical section.


-- wli
