Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268982AbUIQVHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268982AbUIQVHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 17:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269022AbUIQVDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 17:03:06 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:8677 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S269001AbUIQU6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:58:44 -0400
Date: Fri, 17 Sep 2004 22:56:39 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040917205639.GB15426@dualathlon.random>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu> <20040917125334.GA4954@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917125334.GA4954@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 02:53:34PM +0200, Ingo Molnar wrote:
> the attached debug patch is ontop of the above patch and prints warnings
> if code uses smp_processor_id() in a preemptible section of code. The
> patch gets rid of a number of common false positives but more false
> positives are more than likely.

This cannot be applied to 2.6 IMHO. it still doesn't track the
lock_kernel usage inside a spinlock, and even if it did,  we cannot use
the stable 2.6 userbase for the beta testing and see if some production
machine triggers those warnings.

If you would make this a config option *then* it could be included, OTOH
for these kind of things 2.7 would be more appropriate (the config
option is just a waste of resources since eventually the whole thing
will go away).

Overall I think this is not a change that a vendor kernel could ever
make in the middle of a stable series (it sounds quite similar to
preempt, even if less risky, and it really buys nothing to the end
user and in turn it's definitely not justified), and in turn I don't
think it's appropriate for a 2.6 mainline either (at least by default
without config option like you're posting).

Infact I'm not even convinced this is the right step forward in the
removal of the BKL, rather than wasting our time discussing this, it'd
be better to start removing the lock_kernel calls.
