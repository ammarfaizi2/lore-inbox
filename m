Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTKDVH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 16:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTKDVH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 16:07:56 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:18163 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S262569AbTKDVHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 16:07:55 -0500
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
From: Paul Venezia <pvenezia@jpj.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0311041227180.20373-100000@home.osdl.org>
References: <Pine.LNX.4.44.0311041227180.20373-100000@home.osdl.org>
Content-Type: text/plain
Message-Id: <1067980063.24247.23.camel@d8000>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 16:07:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-04 at 15:30, Linus Torvalds wrote:
> On Tue, 4 Nov 2003, Bill Rugolsky Jr. wrote:
> > 
> > Unless bonnie++ is using the _unlocked() variants, it might be an issue of
> > the mutex overhead from NPTL v. LinuxThreads.  Red Hat 9 has its share
> > of NPTL bugs.
> 
> Hmm.. That would easily explain the differences, since NPTL will trigger 
> both on 2.6.0 and the RH-2.4 kernel, but not on the standard 2.4.22 
> kernel.
> 
> But there really should be zero contention on the stdio data structures, 
> so the locking would have to be _seriously_ broken to make that kind o 
> fdifference (not necessarily buggy, but seriously badly implemented). 
> 
> A non-contended lock should be at most one locked instruction if well 
> done, both on LinuxThreads and NPTL.

Good point... 

A truncated strace under 2.4.22 is here:
http://groove.jpj.net/bonnie-strace-trunc

It's incomplete, but shows the putc calls.

> > It is probably worth rerunning the tests with LD_ASSUME_KERNEL=2.4.1 on
> > the Red Hat kernel.
> 
> That would be interesting.

Tests are running now. Updates as events warrant.

-Paul

