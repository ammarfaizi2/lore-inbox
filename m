Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUCKNPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUCKNPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:15:46 -0500
Received: from zero.aec.at ([193.170.194.10]:32006 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261253AbUCKNPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:15:03 -0500
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
References: <1ysXv-wm-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 18 Mar 2004 00:21:25 +0100
In-Reply-To: <1ysXv-wm-11@gated-at.bofh.it> (Andrew Morton's message of
 "Thu, 11 Mar 2004 08:40:09 +0100")
Message-ID: <m3lllzawlm.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> - The CPU scheduler changes in -mm (sched-domains) have been hanging about
>   for too long.  I had been hoping that the people who care about SMT and
>   NUMA performance would have some results by now but all seems to be silent.
>
>   I do not wish to merge these up until the big-iron guys can say that they
>   suit their requirements, with a reasonable expectation that we will not
>   need to churn this code later in the 2.6 series.
>
>   So.  If you have been testing, please speak up.  If you have not been
>   testing, please do so.

I tested them on Opteron NUMA systems and they are worse on simple
tests than the stock scheduler (e.g. the parallelized STREAM test,
which is a bit silly, but still fairly important)

For SMT there is a patch from Intel pending that teaches x86-64
to set up the SMT scheduler. They said they got slightly better
benchmark results. The SMT setup seems to be racy though.

Some kind of SMT scheduler is definitely needed, we have a serious
regression compared to 2.4 here right now. I'm not sure this 
is the right approach though, it seems to be far too complex.

-Andi

