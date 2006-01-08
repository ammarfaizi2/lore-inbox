Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030625AbWAHJpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030625AbWAHJpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbWAHJpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:45:22 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:39180 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030625AbWAHJpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:45:21 -0500
Date: Sun, 8 Jan 2006 10:45:08 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20060108094508.GA14723@w.ods.org>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu> <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local> <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org> <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Fri, Jan 06, 2006 at 01:54:45PM -0800, Chris Stromsoe wrote:
> On Thu, 5 Jan 2006, Willy Tarreau wrote:
> >On Wed, Jan 04, 2006 at 07:52:36PM -0800, Chris Stromsoe wrote:
> >
> >>I booted 2.4.32 with the aic7xxx patch you pointed me at last week. 
> >>It's been up for a few hours.  I'll let it run for at least a week or 
> >>two and will report back positive or negative results.  After that, 
> >>I'll try 2.4.32 with nosmp and acpi=off.
> >
> >Thanks for your continued feedback, Chris. Your reports are very 
> >helpful, they tend to prove that your hardware is OK and that there's a 
> >bug in mainline 2.4.32 with SMP+ACPI+aic7xxx enabled. That's already a 
> >good piece of information.
> 
> After a little more than one day up with 2.4.32 SMP+ACP+aic7xxx, I got 
> another bad pmd and an oops this morning at 4:23am.  I'm going to boot 
> vanilla 2.4.32 with nosmp and acpi=off.

Well, I'm puzzled. On the one hand, your oopses don't all look the
same, so we could think it's a hardware problem. On the other hand,
your hardware tests did not find anything and 2.6.14 runs fine. BTW,
I also have other machines running in production with an adaptec
29160 like yours and I don't encounter this. It looks like some
memory corruption, but finding what causes it seems very hard. In
fact, it somewhat reminds me the problems encountered by Stephan
von Krawczynski 2.5 years ago. He encountered data corruption when
saving large amounts of data to a DLT connected to an AIC7xxx, and
often had freezes, and sometimes an oops. IIRC, changing the board
for something else fixed his problem.

I've compared the driver between 2.4 and 2.6, and the core has not
changed much, but its interface to the OS has changed a lot, so it's
not easy to identify a potential fix.

Eventhough I don't like this, I would join Roberto's advice to
upgrade to 2.6 and stick to it. If you finally encounter the
same problem on 2.6 after a very long time, then it would be
an indication that the problem is well in your hardware.

> -Chris

Thanks for all your investigations,
Willy

