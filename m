Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUCGLyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 06:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUCGLyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 06:54:17 -0500
Received: from mx1.elte.hu ([157.181.1.137]:65424 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261822AbUCGLyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 06:54:16 -0500
Date: Sun, 7 Mar 2004 12:55:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040307115510.GA22651@elte.hu>
References: <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <20040305201139.GA7254@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305201139.GA7254@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jamie Lokier <jamie@shareable.org> wrote:

> Ingo Molnar wrote:
> > if mysql in fact calls time() frequently, then it should rather start a
> > worker thread that updates a global time variable every second.
> 
> That has the same problem as discussed later in this thread with
> vsyscall-time: the worker thread may not run immediately it is woken,
> and also setitimer() and select() round up the delay a little more
> then expected, so sometimes the global time variable will be out of
> date and misordered w.r.t. gettimeofday() and stat() results of
> recently modified files.

we dont have any guarantees wrt. the synchronization of the time() and
the gettimeofday() clocks - irrespective of vsyscalls, do we?

	Ingo
