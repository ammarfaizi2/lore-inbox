Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUIQOBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUIQOBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUIQOBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:01:39 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:8324 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S268769AbUIQN5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:57:49 -0400
Date: Fri, 17 Sep 2004 15:56:57 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040917135657.GW15426@dualathlon.random>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu> <20040917132641.GR15426@dualathlon.random> <20040917134737.GS9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917134737.GS9106@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 06:47:37AM -0700, William Lee Irwin III wrote:
> as the BKL is acquired before spinlocks in all instances. There are

that reinforces my argument, that's another case that can break with
this patch.

I don't think it has a chance to fix any bug, if something it will
trigger some deadlock or race condition, but OTOH I agree it should work
fine (all code I can recall by memory takes the BKL before any inner
spinlock too, and I don't think we left anything that depends on
smp_processor_id()), but again this is the kind of change that requires
some testing and cannot be shipped by default in a stable tree, it
requires config option at the very least.
