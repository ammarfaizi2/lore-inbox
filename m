Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266618AbUGPVCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266618AbUGPVCB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 17:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbUGPVCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 17:02:01 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:57503 "EHLO
	texas.encore.com") by vger.kernel.org with ESMTP id S266618AbUGPVBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 17:01:02 -0400
Message-ID: <40F8420C.88E694F2@compro.net>
Date: Fri, 16 Jul 2004 17:01:00 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.26-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
References: <20031003214411.GA25802@rudolph.ccur.com>
		<40ADE959.822F1C23@compro.net>
		<20040521191326.58100086.akpm@osdl.org>
		<20040525142728.GA10738@tsunami.ccur.com> <20040525124715.5f7e61b6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Joe Korty <joe.korty@ccur.com> wrote:
> >
> > On Fri, May 21, 2004 at 07:13:26PM -0700, Andrew Morton wrote:
> >  > Mark Hounschell <markh@compro.net> wrote:
> >  > >
> >  > > Joe Korty wrote:
> >  > > >
> >  > > > 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
> >  > > > the registers of an IO device will hang that process uninterruptibly.
> >  > > > The task runs in an infinite loop in get_user_pages(), invoking
> >  > > > follow_page() forever.
> >  > > >
> >  > > > Using binary search I discovered that the problem was introduced
> >  > > > in 2.5.14, specifically in ChangeSetKey
> >  > > >
> >  > > >     zippel@linux-m68k.org|ChangeSet|20020503210330|37095
> >  > > >
> >  > >
> >  > > I know this is an old thread but can anyone tell me if this problem is
> >  > > resolved in the current 2.6.6 kernel?
> >  > >
> >  >
> >  > There's an utterly ancient patch in -mm which might fix this.
> >  >
> >  > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm4/broken-out/get_user_pages-handle-VM_IO.patch
> >
> >  [ 2nd send -- corporate email system in the throes of being scrambled / updated ]
> >
> >  Andrew,
> >  I have been using this patch for ages.  Any chance of it being forwared to
> >  the official tree?
> 
> That patch had its first birthday last week.  I wrote it in response to
> some long-forgotten problem, failed to changelog it at the time then forgot
> why I wrote it.  I kept it in the hope that I'd remember why I wrote it.  I
> subsequently wrote a best-effort changelog but am unconvinced by it.  Ho
> hum.
> 
> Let me genuflect a bit.  I guess we can be reasonably confident it won't
> break anything.

Strange thing about this patch is "it doesn't seem to work on all
machines". Originally it worked for me on a dual AMD1900 box. Now I'm
trying to use it on a Dual P4 box and a dual Opteron in both 32 and 64
bit modes with no luck at all???? I guess I need to go back to my
original AMD and reverify it's functionality.

The user level code I'm using:


    status = mlockall(MCL_CURRENT | MCL_FUTURE);        
    if (status < 0)
        perror("mlock all failure");

    dhan = rtom_usec_map(&rtom_microseconds, 0); mmaps rtom usec timer

?????


Regards
Mark
