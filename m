Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbWFATbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbWFATbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWFATbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:31:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34987 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965286AbWFATbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:31:15 -0400
Date: Thu, 1 Jun 2006 21:31:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, michal.k.k.piotrowski@gmail.com,
       gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060601193132.GA25877@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com> <20060601102234.4f7a9404.akpm@osdl.org> <1149182861.3115.79.camel@laptopd505.fenrus.org> <20060601104018.b88a3173.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601104018.b88a3173.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > (lockdep tells us that a mutex was taken at "mutex_lock+0x8/0xa", which is
> > > fairly useless.  We need to report who the caller of mutex_lock() was).
> > 
> > yeah this has been bugging me as well; either via a wrapper around
> > mutex_lock or via the gcc option to backwalk the stack (but that only
> > works with frame pointers enabled.. sigh)
> 
> Actually, __builtin_return_address(0) works OK with 
> -fomit-frame-pointer, and that's all we need here.

yes - but that means we'd have to propagate the EIP through all the 
mutex calls (and the assembly functions, etc.). I tried it and it's 
really a nightmare. What we can do is to have better information if 
FRAME_POINTERS is enabled.

	Ingo
