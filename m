Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUG2VBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUG2VBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUG2U7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:59:40 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:41721 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S265256AbUG2U7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:59:12 -0400
Date: Thu, 29 Jul 2004 16:57:50 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Scott Wood <scott@timesys.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040729205750.GA28735@yoda.timesys>
References: <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040729202629.GC468@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729202629.GC468@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 10:26:30PM +0200, Pavel Machek wrote:
> Well, I do not follow you I guess.
> 
> With large-enough number of hardirqs you do no progress at all.
> 
> Even if only "sane" number of irqs, if they all decide to hit within one
> getpid(), this getpid is going to take quite long....
> 				Pavel

Ordinarily, yes.  However, if it's a high-priority RT task that does
the getpid(), whose priority is higher than that of the RT tasks,
you'll get at most one hardirq stub per active IRQ number; after
that, the IRQs will be masked until their threads get a chance to be
scheduled.

-Scott
