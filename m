Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264496AbRFJC2a>; Sat, 9 Jun 2001 22:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264497AbRFJC2V>; Sat, 9 Jun 2001 22:28:21 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:17796 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S264496AbRFJC2P>;
	Sat, 9 Jun 2001 22:28:15 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106100228.TAA18829@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 9 Jun 2001 19:28:11 -0700 (PDT)
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106091148380.26187-100000@penguin.transmeta.com> from "Linus Torvalds" at Jun 09, 2001 12:01:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 9 Jun 2001, Alexander Viro wrote:
> > 
> > Another difference from spinlocks is that BKL is recursive. I'm
> > actually surprised that it didn't show up first.
> 
> Good point. Spinlocks (with the exception of read-read locks, of course)
> and semaphores will deadlock on recursive use, while the BKL has this
> "process usage counter" recursion protection.

Actually, it did show up all over the place --- I'd just selected two
candidates to examine out of hundreds.  (Checking call chains is
strenous, even when you know what you're looking for.)

> And I suspect that the current checker doesn't realize that any user mode
> access is equivalent to calling "do_page_fault()" from a call-chain
> standpoint.
>
> Dawson - the user-mode access part is probably _the_ most interesting from
> a lock checking standpoint, could you check doing the page fault case?

Sure, it's a pretty interaction.  To be sure about the rule: any *_user
call can be treated as an implicit invocation of do_page_fault?  

Dawson
