Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSGIT3D>; Tue, 9 Jul 2002 15:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317388AbSGIT3C>; Tue, 9 Jul 2002 15:29:02 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36065 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317387AbSGIT3A>;
	Tue, 9 Jul 2002 15:29:00 -0400
Message-Id: <200207091931.g69JVD417360@eng4.beaverton.ibm.com>
To: Greg KH <greg@kroah.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal 
In-reply-to: Your message of "Mon, 08 Jul 2002 21:38:58 PDT."
             <20020709043857.GA24418@kroah.com> 
Date: Tue, 09 Jul 2002 12:31:13 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

    > The problem is, of course, that to responsibly use the BKL, you must
    > fully understand ALL the code that utilizes it, so that you know your
    > new use of it doesn't conflict or interfere with existing code and
    > usage.  That's the same problem we have when it DOES show contention --
    > is the problem in the functions which can't grab it (for trying
    > unnecessarily), or in the functions that can (for holding it
    > unnecessarily)?
    
Greg responded:

    But the driverfs and USB code do _not_ show contention.  Or if they
    do (as Dave pointed out in the driverfs code) it's in a
    non-critical point in the kernel's life (boot time, USB device
    removal, etc.)

Ok, I think this underscores something I haven't seen clearly stated
here before.  Yes, if you can demonstrate contention, you have a
problem that needs fixing, and I think few would argue it shouldn't be
addressed.

However, I look at this from a supportability point of view as well --
a lock such as the BKL which is used for multiple reasons by multiple
subsystems, when it DOES show contention, is harder to fix.  People
trying to fix old code wonder if a particular section really needs the
BKL, and give up figuring it out because its too hard.

So while contention can bring a lot of (unwanted) attention to a
spinlock, including the BKL, I want to see the BKL reduced even if it's
NOT showing contention, because it makes it easier to debug the cases
where it IS being used.  Unless a developer is relying on the
release-on-sleep mechanism or the nested-locks-without-deadlock
mechanism, there's no reason an instance of the BKL can't be replaced
with another spinlock.

Arguing that efforts to replace it have indicated we don't know
how it is really used just supports my point.  I don't think anybody
exists who can claim (or will admit :) that they know why the BKL is
used everywhere it is.  We either need to develop that person (and keep
them safe from harm!) or make it easier to understand "on the fly".
I believe that reducing the varied usages, even harmless ones", will
make it easier to either clearly document the remaining usages or
to understand it "on the fly".

Rick
