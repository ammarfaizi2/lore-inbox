Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTH1Th5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTH1Th5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:37:57 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:64516 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264257AbTH1Th4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:37:56 -0400
Subject: Re: [PATCH] make voyager work again after the cpumask_t changes
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030828121016.2c0e2716.akpm@osdl.org>
References: <1062097375.1952.41.camel@mulgrave> 
	<20030828121016.2c0e2716.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Aug 2003 15:37:17 -0400
Message-Id: <1062099437.1952.45.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 15:10, Andrew Morton wrote:
> Yes, the generic code was like that too.  It was causing lockups.  Sorry, I
> did not realise that voyager had a private invalidatation implementation.

It actually has to since the invalidation implementation is a property
of the SMP HAL...fortunately voyager is the only subarch that has to
replace the SMP HAL wholesale.

> Officially smp_invalidate_needed should be a cpumask_t and
> smp_invalidate_interrupt() should be using cpu_isset() rather than
> open-coded bitops.  For all those 64-way voyagers out there ;)
> 
> (Actually it is legitimate: you may want to run a NR_CPUS=48 kernel on a
> 2-way voyager just for testing purposes).  I'll drop your patch in as-is,
> and maybe Bill can take a look at cpumaskifying it sometime?

OK.

Actually, looking at the code made me realise that we can kill the
tlbstate_lock and run lockless, so I'll play with doing that too.

James


