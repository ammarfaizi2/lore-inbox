Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVCaOPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVCaOPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVCaOPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:15:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:22733 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261456AbVCaOPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:15:33 -0500
Date: Thu, 31 Mar 2005 16:14:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-ID: <20050331141441.GA2384@elte.hu>
References: <424A0172.2010609@yahoo.com.au> <200503300138.j2U1cJg03717@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503300138.j2U1cJg03717@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> > If it is doing a lot of mapping/unmapping (or fork/exit), then that
> > might explain why 2.6.11 is worse.
> >
> > Fortunately there are more patches to improve this on the way.
> 
> Once benchmark reaches steady state, there is no mapping/unmapping 
> going on.  Actually, the virtual address space for all the processes 
> are so stable at steady state that we don't even see it grow or 
> shrink.

is there any idle time on the system, in steady state (it's a sign of 
under-balancing)? Idle balancing (and wakeup balancing) is one of the 
things that got tuned back and forth alot. Also, do you know what the 
total number of context-switches is during the full test on each kernel?  
Too many context-switches can be an indicator of over-balancing. Another 
sign of migration gone bad can be relative increase of userspace time 
vs. system time. (due to cache trashing, on DB workloads, where most of 
the cache contents are userspace's.)

	Ingo
