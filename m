Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUCEULy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbUCEULx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:11:53 -0500
Received: from mail.shareable.org ([81.29.64.88]:37511 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262689AbUCEULw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:11:52 -0500
Date: Fri, 5 Mar 2004 20:11:39 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305201139.GA7254@mail.shareable.org>
References: <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305150225.GA13237@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> if mysql in fact calls time() frequently, then it should rather start a
> worker thread that updates a global time variable every second.

That has the same problem as discussed later in this thread with
vsyscall-time: the worker thread may not run immediately it is woken,
and also setitimer() and select() round up the delay a little more
then expected, so sometimes the global time variable will be out of
date and misordered w.r.t. gettimeofday() and stat() results of
recently modified files.

Also, if there's paging the variable may be out of date by quite a
long time, so mlock() should be used to remove that aspect of the delay.

I don't know if such delays a problem for MySQL.

-- Jamie
