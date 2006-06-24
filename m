Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933323AbWFXImP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933323AbWFXImP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933327AbWFXImP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:42:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:17857 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933323AbWFXImP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:42:15 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [discuss] Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Sat, 24 Jun 2006 10:42:49 +0200
User-Agent: KMail/1.9.1
Cc: discuss@x86-64.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <200606210329_MC3-1-C305-E008@compuserve.com> <200606231442.23073.ak@suse.de> <1151114785.23432.38.camel@galaxy.corp.google.com>
In-Reply-To: <1151114785.23432.38.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606241042.50139.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It just does not sound like a right interface.  Why should an app be
> giving the last time value that it asked for the same information.  

First this information comes with a good-before date stamp
so it's natural. Otherwise the application will never pick
up when the scheduler decides to schedule it somewhere else,
which would be bad.

And that came from conversation with application developers.

A: We want something to get the current node
me: how fast does it need to be? 
B: we will cache it anyways.

Problem is that normally the application can't do a good job
at doing the cache because it doesn't have a fast way to 
do time stamping (gettimeofday would be too slow and it's
the fastest timer available short of having a second thread
that sleeps and updates a counter) 

But the vsyscall incidentially knows this because of it
sharing data with  vgettimeofday(), so it can
do the job for the application

> User 
> wants cpu, package and node numbers and those are the three parameters
> that should be there.  Besides if we are using lsl then the latency part
> of cpuid is already gone so no need to optimize this any more.
>
> Though this will be good interface to export jiffies ;-)

No - jiffies don't have a defined unit and might even go away
on a fully tickless kernel.

If we just exported jiffies you would get lots of HZ dependent
programs.

-Andi
