Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268798AbUIQOWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268798AbUIQOWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268794AbUIQOW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:22:29 -0400
Received: from holomorphy.com ([207.189.100.168]:45740 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268798AbUIQOSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:18:23 -0400
Date: Fri, 17 Sep 2004 07:18:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040917141819.GW9106@holomorphy.com>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu> <20040917132641.GR15426@dualathlon.random> <20040917134737.GS9106@holomorphy.com> <20040917135657.GW15426@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917135657.GW15426@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 06:47:37AM -0700, William Lee Irwin III wrote:
>> as the BKL is acquired before spinlocks in all instances. There are

On Fri, Sep 17, 2004 at 03:56:57PM +0200, Andrea Arcangeli wrote:
> that reinforces my argument, that's another case that can break with
> this patch.
> I don't think it has a chance to fix any bug, if something it will
> trigger some deadlock or race condition, but OTOH I agree it should work
> fine (all code I can recall by memory takes the BKL before any inner
> spinlock too, and I don't think we left anything that depends on
> smp_processor_id()), but again this is the kind of change that requires
> some testing and cannot be shipped by default in a stable tree, it
> requires config option at the very least.

But the corner cases I outlined don't exist; the case that does exist
is where the BKL is dropped by mistake by e.g. a call to a function
that may sleep. c.f. fs/fcntl.c:setfl().


-- wli
