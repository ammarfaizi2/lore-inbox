Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267564AbUGWHUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267564AbUGWHUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 03:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUGWHUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 03:20:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36806 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267564AbUGWHUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 03:20:14 -0400
Date: Fri, 23 Jul 2004 09:21:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040723072127.GA15565@elte.hu>
References: <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu> <40FF9CD1.7050705@yahoo.com.au> <20040722162357.GB23972@elte.hu> <41003BA3.70806@yahoo.com.au> <20040723054735.GA14108@elte.hu> <4100B403.6080402@yahoo.com.au> <20040723065504.GA15118@elte.hu> <4100BA0E.3080204@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4100BA0E.3080204@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> You wouldn't need to do this to break out of interrupt context
> softirqs because you wouldn't bother returning to it. Just hand the
> work off to ksoftirqd.

this is plainly not the case. Look at eg. the net_tx_action() lock-break
i did in the -I1 patch. There we first create a private queue which we
work down. With my approach we can freely reschedule _within the loop_.
With your suggestion this is not possible.

i.e. executing a softirq in a process context gives us all the
advantages of a process context: all the local state is saved and
preserved until the preemption is done. These advantages are not there
for either immediate or idle-task-only-immediate type of softirq
processing.

	Ingo
