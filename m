Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVCaIDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVCaIDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVCaIDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:03:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7917 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261155AbVCaIC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:02:26 -0500
Date: Thu, 31 Mar 2005 10:02:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Jack O'Quin" <joq@io.com>
Subject: Re: Latency tests with 2.6.12-rc1
Message-ID: <20050331080217.GA18446@elte.hu>
References: <1111204984.12740.22.camel@mindpipe> <20050319070810.GA20059@elte.hu> <1111218702.13039.5.camel@mindpipe> <1111269392.15042.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111269392.15042.12.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> So there seems to be a bug in the latency tracer where the timer is 
> not being reset on reschedule. [...]

update: i found a bug in the latency tracer that could explain some of 
the artifacts you noticed, IRQs would reset the tracing timer under 
certain circumstances. So sometimes traces would show up, sometimes they 
wouldnt - and even if traces were generated, they often were truncated.  
The bug is fixed in the -41-24 patch. If you were hit by this bug then 
you'll likely see new and larger latencies reported.

	Ingo
