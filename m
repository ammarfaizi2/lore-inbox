Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292766AbSBUUgH>; Thu, 21 Feb 2002 15:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292765AbSBUUfr>; Thu, 21 Feb 2002 15:35:47 -0500
Received: from zero.tech9.net ([209.61.188.187]:28173 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292763AbSBUUfi>;
	Thu, 21 Feb 2002 15:35:38 -0500
Subject: Re: [PATCH] 2.5: conditional schedules with a preemptive kernel
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, kpreempt-tech@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0202211227260.18900-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202211227260.18900-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 21 Feb 2002 15:35:41 -0500
Message-Id: <1014323742.2576.41.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-21 at 15:29, Linus Torvalds wrote:
> 
> On 20 Feb 2002, Robert Love wrote:
> > 
> > With a preemptive kernel, explicit conditional schedules when
> > preempt_count is zero are a waste of cycles and code size.
> 
> Hmm.. Are there any other kind?
> 
> Another way of saying this: how can a conditional schedule _ever_ be 
> nothing but a waste of cycles and code size with preemption enabled?
> 
> If the reason is the BKL, then I would much prefer those paths to be 
> BKL-fixed, than have two different conditional schedules.
> 
> In short, I'd rather get a patch that just unconditionally makes the 
> conditional schedules no-ops with preemption enabled. That would seem to 
> make a lot more sense.

I assume (and hope) the reason is always the BKL.

I would rather not eliminate any explicit reschedules from the kernel
for the preemptive kernel case only.  That sort of defeats a purpose
(response improvement) of the kernel.

And I wholeheartedly agree that the situations where the BKL is held
should be handled and an ideal solution is to just not explicitly
schedule anywhere in the kernel with a preemptive kernel.  But I suspect
this will involve a lot of dark magic wrt BKL locking semantics.

What do you have in mind?

	Robert Love

