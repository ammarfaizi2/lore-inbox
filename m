Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317408AbSGIUxV>; Tue, 9 Jul 2002 16:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317409AbSGIUxU>; Tue, 9 Jul 2002 16:53:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4789 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317408AbSGIUxT>;
	Tue, 9 Jul 2002 16:53:19 -0400
Message-Id: <200207092055.g69Ktt418608@eng4.beaverton.ibm.com>
To: Greg KH <greg@kroah.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal 
In-reply-to: Your message of "Tue, 09 Jul 2002 13:17:03 PDT."
             <20020709201703.GC27999@kroah.com> 
Date: Tue, 09 Jul 2002 13:55:55 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

    > Unless a developer is relying on the release-on-sleep mechanism or the
    > nested-locks-without-deadlock mechanism, there's no reason an instance
    > of the BKL can't be replaced with another spinlock.
    
Greg replied:

    Um, not true.  You can call schedule with the BKL held, not true for a
    spinlock.

Well, this is what I meant by the release-on-sleep.  When you go to
sleep, the BKL is actually released in the scheduler.

Anything which is relying on this behavior needs to be redesigned.  It
is holding, at best, an advisory lock.  The lock, after all, is only in
effect until you go to sleep.  No other lock behaves this way.  Is
there any code in the kernel which MUST have this feature? The code
should be written so that the code itself releases any locks it holds
before putting itself to sleep.  "magic" which happens simply because
you down'ed a semaphore is just more obfuscated code to the uninitiated
and more trouble to even the informed.

    And see the oft repeated messages on lkml about the
    spinlock/semaphore hell that some oses have turned into when they
    try to do this.  Let's learn from history this time around please.

Fire burns, but we seem to have gotten a handle on it.

Proper locking is hard, but that's not a reason to ignore it.  Be
careful, yes.  Avoid, no.

Rick
