Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUGVCrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUGVCrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUGVCrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:47:40 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:49347 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266796AbUGVCrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:47:37 -0400
Date: Wed, 21 Jul 2004 22:47:15 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722024715.GC3298@yoda.timesys>
References: <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721210832.GA30871@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721210832.GA30871@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 11:08:32PM +0200, Ingo Molnar wrote:
> did you get my other mail in which i explained how e.g. the networking
> code _relies_ on the softirq semantics?

Yes, but not until after I sent that e-mail.

> > Do you also add preemption checks in all of the various loops that can
> > be run from within a single softirq instance?
> 
> no, that's the next step, if those loops turn out to be problematic. 
> E.g. network device backlogs default to a value of 100 or so which
> shouldnt generate too bad latencies. If it does it's easy to break out
> of those loops, they are already breakout-aware.

I suppose it depends on what sort of latencies you're trying to
achieve, and how fast the hardware you're running on is.  In our 2.4
kernel we typically achieved worst case latencies of 50us or so on PC
hardware, and a few hundred us on slower embedded hardware.  Packet
processing would have to be awfully fast to cram 100 packets in that
time...

-Scott
