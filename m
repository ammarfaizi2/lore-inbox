Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266207AbUFPHcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUFPHcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUFPHcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:32:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1959 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266207AbUFPHcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:32:12 -0400
Date: Wed, 16 Jun 2004 09:02:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au, akpm@osdl.org,
       wli@holomorphy.com, markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
Message-ID: <20040616070240.GA25910@elte.hu>
References: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au> <40CFB8FD.2010601@yahoo.com.au> <Pine.LNX.4.58.0406152009220.4142@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406152009220.4142@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> I agree. However, I still think we should do my suggested
> "wake_up_new(p,clone_flags)" thing, and then have the logic on whether
> to try to care about threading or not be in schedule.c, not in
> kernel/fork.c.
> 
> The fact is, fork.c shouldn't try to make scheduling decisions. But it
> could inform the scheduler about the new process, and THAT can then
> make the decisions.

agreed, and i did it in a similar way initially (by adding the clone
flags to wake_up_process()) but went for the smaller patch. The only
reason i pushed it into fork.c initially was to avoid having to change
dozens of other files (most of them in various architectures) that use
wake_up_process(). It wasnt (and still isnt) clear at all whether we
want to do any fork/clone-time balancing.

	Ingo
