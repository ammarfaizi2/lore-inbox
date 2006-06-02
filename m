Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWFBKTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWFBKTt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 06:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWFBKTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 06:19:49 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:46263 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751303AbWFBKTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 06:19:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 20:19:28 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com> <200606021817.46745.kernel@kolivas.org> <447FF6B8.1000700@yahoo.com.au>
In-Reply-To: <447FF6B8.1000700@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606022019.29023.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 18:28, Nick Piggin wrote:
> Con Kolivas wrote:
> > On Friday 02 June 2006 17:53, Nick Piggin wrote:
> >>This is a small micro-optimisation / cleanup we can do after
> >>smtnice gets converted to use trylocks. Might result in a little
> >>less cacheline footprint in some cases.
> >
> > It's only dependent_sleeper that is being converted in these patches. The
> > wake_sleeping_dependent component still locks all runqueues and needs to
>
> Oh I missed that.
>
> > succeed in order to ensure a task doesn't keep sleeping indefinitely.
> > That
>
> Let's make it use trylocks as well. wake_priority_sleeper should ensure
> things don't sleep forever I think? We should be optimising for the most
> common case, and in many workloads, the runqueue does go idle frequently.

wake_priority_sleeper is only called per tick which can be 10ms at 100HZ. I 
don't think that's fast enough. It could even be possible for a lower 
priority task to always just miss the wakeup if it's (very) unlucky.

-- 
-ck
