Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTKDWT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTKDWT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:19:29 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:25579 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262649AbTKDWT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:19:26 -0500
Date: Tue, 4 Nov 2003 17:19:04 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
Message-ID: <20031104221904.GE30612@ti19.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Linus Torvalds <torvalds@osdl.org>, Paul Venezia <pvenezia@jpj.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
References: <20031104212813.GC30612@ti19.telemetry-investments.com> <Pine.LNX.4.44.0311041335200.20373-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311041335200.20373-100000@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 01:40:51PM -0800, Linus Torvalds wrote:
> On Tue, 4 Nov 2003, Bill Rugolsky Jr. wrote:
> > 
> > Well, I'm too lazy to wait for a long test, but with a mere
> > 100MB file, on 1GHz P3:
> > 
> > Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
> >                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> > NPTL          100M  7735  99 127068  98 63048  84  7890  98 +++++ +++ +++++ +++
> > LinuxThreads  100M 11000  99 127928  97 59075  84 11290  98 +++++ +++ +++++ +++
> > 
> > So something is amiss.
> 
> Ok, so NPTL locking (even in the absense of any threads and thus any 
> contention) seems to be noticeably higher-overhead than the old 
> LinuxThreads. 
> 
> 90% of the overhead of a putc()/getc() implementation these days is likely
> just locking. Even so, this implies that NPTL locking is about twice as 
> expensive as the old LinuxThreads one.

On Fedora 0.95, Pentium M 1.6GHz, 2.4.22-1.2115.nptl, glibc-2.3.2-10, (NPTL 0.60),
I get:

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
NPTL           100M 13070 100 +++++ +++ 14141   4 13099 100 +++++ +++ +++++ +++
LinuxThreads   100M 25957 100 +++++ +++ 20037   5 26777  99 +++++ +++ +++++ +++

Ugh, still there.

	Bill Rugolsky
