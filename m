Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317410AbSGIVKS>; Tue, 9 Jul 2002 17:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSGIVKR>; Tue, 9 Jul 2002 17:10:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10741 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317410AbSGIVKR>; Tue, 9 Jul 2002 17:10:17 -0400
Subject: Re: BKL removal
From: Robert Love <rml@mvista.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020709210053.GF25360@holomorphy.com>
References: <20020709201703.GC27999@kroah.com>
	<200207092055.g69Ktt418608@eng4.beaverton.ibm.com> 
	<20020709210053.GF25360@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Jul 2002 14:12:55 -0700
Message-Id: <1026249175.1033.1178.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-09 at 14:00, William Lee Irwin III wrote:

> This is an ugly aspect. But AFAICT the most that's needed to clean it
> up is an explicit release before potentially sleeping.

Yep that is all we need... remove the release_kernel_lock() and
reacquire_kernel_lock() from schedule and do it explicitly everywhere it
is needed.

The problem is, it is needed in a _lot_ of places.  Mostly instances
where the lock is held across something that may implicitly sleep.

Places that call schedule() explicitly holding the BKL are rare enough
we can probably handle them.  I have a patch that does so (thus turning
all cond_resched() calls into no-ops with the preemptive kernel -- my
goal).  The other implicit situations are near impossible to handle.

Summary is, I would love to do things like dismantle the BKLs odd-ball
features... cleanly and safely.  Good luck ;)

	Robert Love


