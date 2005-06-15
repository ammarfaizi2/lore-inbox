Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVFOTQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVFOTQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFOTQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:16:53 -0400
Received: from kanga.kvack.org ([66.96.29.28]:4590 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261438AbVFOTQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:16:38 -0400
Date: Wed, 15 Jun 2005 15:18:30 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] aio_down() for i386 and x86_64
Message-ID: <20050615191830.GA28261@kvack.org>
References: <20050614215022.GC21286@kvack.org> <20050615165349.GA4521@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615165349.GA4521@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 10:23:49PM +0530, Suparna Bhattacharya wrote:
> Interesting approach - using ki_wait.private for this.
> Could we make aio_down take a wait queue parameter as well instead of
> the iocb ?

Hmmm, I guess there might be instances where someone has to wait on 
multiple wait queues.  Will add that to the next version of the patch.

> Need to think a little about impact on io cancellation.

It should be possible to cancel semaphore operations fairly easily -- 
the aio_down function can set ->ki_cancel to point to a semaphore cancel 
routine.  I'll give coding that a try.

> BTW, is the duplication of functions across architectures still needed ? I
> thought that one of advantages of implementing a separate aio_down
> routine vs modifiying down to become retryable was to get away from
> that ... or wasn't it ?

Good point.  The fast path for down() will probably need to remain a 
separate function, but we could well unify the code with the 
down_interruptible() codepath.

> Meanwhile, I probably need to repost my aio_wait_bit patches - there
> may be some impact here.

Sure -- any version of those would be useful to build on.  Cheers!

		-ben
