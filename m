Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSGIV0d>; Tue, 9 Jul 2002 17:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSGIV0c>; Tue, 9 Jul 2002 17:26:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37116 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317419AbSGIV0c>; Tue, 9 Jul 2002 17:26:32 -0400
Subject: Re: BKL removal
From: Robert Love <rml@mvista.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D2AF10A.1020603@us.ibm.com>
References: <20020709201703.GC27999@kroah.com>	<200207092055.g69Ktt418608@eng4.beaverton
	 .ibm.com> 	<20020709210053.GF25360@holomorphy.com>
	<1026249175.1033.1178.camel@sinai>  <3D2AF10A.1020603@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Jul 2002 14:29:11 -0700
Message-Id: <1026250151.1623.1185.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-09 at 07:19, Dave Hansen wrote:

> Robert Love wrote:
>
> > The problem is, it is needed in a _lot_ of places.  Mostly instances
> > where the lock is held across something that may implicitly sleep.
> 
> And _that_ is why I wrote the BKL debugging patch, to help find these 
> places at runtime.  It may not be pretty, but it works.  I'll post it 
> again if you're interested.

I saw the patch... the problem is we cannot say "oh I ran this code path
with the patch and did not see anything, it is safe".  Can sleep != will
sleep, and thus we have code that 99% will not sleep but it may.

I suspect on my 1GB machine I rarely page fault on copy_*_user but that
does not mean it could not sleep.

If you find all the culprits and think you can safely remove the
release/reacquire routines from schedule, all the power to you.

	Robert Love

