Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267568AbUHaUsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUHaUsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUHaUqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:46:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41436 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268800AbUHaUhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:37:19 -0400
Date: Tue, 31 Aug 2004 22:37:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831203739.GA2356@elte.hu>
References: <OFD2470C56.2DA0AD38-ON86256F01.006DC3B0@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD2470C56.2DA0AD38-ON86256F01.006DC3B0@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >since the latency tracer does not trigger, we need a modified tracer to
> >find out what's happening during such long delays. I've attached the
> >'user-latency-tracer' patch ontop of -Q5, which is a modification of the
> >latency tracer.
> Grr. I should have checked before I built with this patch. With this in
> I now get the
>   kernel: Could not allocate 4 bytes percpu data
> messages again. Need to increase that data area so
>   #define PERCPU_ENOUGH_ROOM 196608
> or something similar (should leave about 50K free for modules).

ok, i've upped that value in my tree too.

> I will rebuild with this change plus the latest of the others.

since your traces do show those 'mystic' latency incidents causing
200-500 usec overhead in few-instructions code paths, perhaps the 1 msec
jitter you are seeing could a consequence of this too. So perhaps it
would make sense to first try disabling IDE DMA, to see whether this has
any effect on the magic latencies.

	Ingo
