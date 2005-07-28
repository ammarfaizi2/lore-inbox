Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVG1IT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVG1IT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVG1ISC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:18:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15555 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261346AbVG1IRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:17:06 -0400
Date: Thu, 28 Jul 2005 10:16:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@ocs.com.au>
Cc: David.Mosberger@acm.org, Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050728081622.GA22025@elte.hu>
References: <20050728074118.GA20581@elte.hu> <10613.1122538148@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10613.1122538148@kao2.melbourne.sgi.com>
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


* Keith Owens <kaos@ocs.com.au> wrote:

> >yeah. I'd too suggest to call it prefetch_stack(), and not make it a
> >macro & hook but something defined on all arches, with for now only ia64
> >having any real code in the inline function.
> >
> >i'm wondering, is the switch_stack at the same/similar place as
> >next->thread_info? If yes then we could simply do a
> >prefetch(next->thread_info).
> 
> No, they can be up to 30K apart.  See include/asm-ia64/ptrace.h. 
> thread_info is at ~0xda0, depending on the config.  The switch_stack 
> can be as high as 0x7bd0 in the kernel stack, depending on why the 
> task is sleeping.

is the switch_stack the same thing as the kernel stack? If yes then we 
want to have something like:

	prefetch(kernel_stack(next));

to make it more generic. By default kernel_stack(next) could be
next->thread_info (to make sure we prefetch something real). On e.g.
x86/x64, kernel_stack(next) should be something like next->thread.esp.

	Ingo
