Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUFSLhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUFSLhY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 07:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbUFSLhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 07:37:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54216 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265499AbUFSLhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 07:37:22 -0400
Date: Sat, 19 Jun 2004 13:38:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] flexible-mmap-2.6.7-D5
Message-ID: <20040619113836.GA16197@elte.hu>
References: <20040618213814.GA589@elte.hu> <20040618231631.GO1863@holomorphy.com> <20040619074612.GB12020@elte.hu> <20040619083446.GP1863@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619083446.GP1863@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> Also, I suspect some more graceful fallback would make sense
> particularly for the case of RLIM_INFINITY, which would leave users
> that run with, say, all rlimits at RLIM_INFINITY in the interest of
> having full access to system resources with a mere 512MB of
> virtualspace for the heap, which IIRC glibc is intelligent enough to
> circumvent for malloc(), but not for mmap(NULL, ...). [...]

well, the 5/6=stack 1/6=malloc rule in the RLIM_INFINITY can be changed. 
What would make the most sense - 1/2 for both?

> If it's been in production that long, I find it hard to believe that's
> never been tripped over. [...]

it's been tripped over and the 5/6 rule was a fix for such a bugreport. 
What happens more in practice frequently is that someone needs a big
stack and sets the stack ulimit to RLIM_INFINITY.

> [...] (also, that 128MB is currently wasted); [...]

the 128MB is 'wasted' to give some flexibility to the stack rlimits
changing runtime. But in practice it's far more important to have the
mmap()/malloc() space maximized and flexible than to give the stack
automatic flexibility.

	Ingo
