Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266583AbUGUScn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266583AbUGUScn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUGUScm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:32:42 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:3032 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266583AbUGUScl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:32:41 -0400
Date: Wed, 21 Jul 2004 14:32:13 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721183213.GB2206@yoda.timesys>
References: <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721085246.GA19393@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 10:52:46AM +0200, Ingo Molnar wrote:
> this, if enabled, causes all softirqs to be processed within ksoftirqd,
> and it also breaks out of the softirq loop if preemption of ksoftirqd
> has been triggered by a higher-prio task.

You'll still have the latency of finishing the currently executing
softirq, which often includes a loop itself (whose break condition is
based on not hogging the CPU, rather than letting higher priority
tasks in as soon as possible).

-Scott
