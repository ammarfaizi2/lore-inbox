Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUCEPvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 10:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUCEPvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 10:51:18 -0500
Received: from ns.suse.de ([195.135.220.2]:12003 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262650AbUCEPvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 10:51:16 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
References: <20040228072926.GR8834@dualathlon.random>
	<Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	<20040229014357.GW8834@dualathlon.random>
	<1078370073.3403.759.camel@abyss.local>
	<20040303193343.52226603.akpm@osdl.org>
	<1078371876.3403.810.camel@abyss.local>
	<20040305103308.GA5092@elte.hu>
	<20040305141504.GY4922@dualathlon.random>
	<20040305143425.GA11604@elte.hu>
	<20040305145947.GA4922@dualathlon.random>
	<20040305150225.GA13237@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 05 Mar 2004 16:51:15 +0100
In-Reply-To: <20040305150225.GA13237@elte.hu.suse.lists.linux.kernel>
Message-ID: <p73ad2v47ik.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > I thought time() wouldn't be called more than 1 per second anyways,
> > why would anyone call time more than 1 per second?
> 
> if mysql in fact calls time() frequently, then it should rather start a
> worker thread that updates a global time variable every second.

I just fixed the x86-64 vsyscall vtime() to only read the user mapped
__xtime.tv_sec.  This should be equivalent. Only drawback is that if a
timer tick is delayed for too long it won't fix that, but I guess
that's reasonable for a 1s resolution.

-Andi
 
