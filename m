Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUCDQWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUCDQWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:22:34 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:61402 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261999AbUCDQWT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:22:19 -0500
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
	end)
From: Peter Zaitsev <peter@mysql.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040304045212.GG4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random>
	 <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	 <20040229014357.GW8834@dualathlon.random>
	 <1078370073.3403.759.camel@abyss.local>
	 <20040303193343.52226603.akpm@osdl.org>
	 <1078371876.3403.810.camel@abyss.local>
	 <20040303200704.17d81bda.akpm@osdl.org>
	 <20040304045212.GG4922@dualathlon.random>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1078417285.2770.100.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 08:21:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 20:52, Andrea Arcangeli wrote:

Andrea,

> mysql is threaded (it's not using processes that force tlb flushes at
> every context switch), so the only time a tlb flush ever happens is when
> a syscall or an irq or a page fault happens with 4:4. Not tlb flush
> would ever happen with 3:1 in the whole workload (yeah, some background
> tlb flushing happens anyways when you type char on bash or move the
> mouse of course but it's very low frequency)

Do not we get TLB flush also due to latching or are pthread_mutex_lock
etc implemented without one nowadays ?

> 
> (to be fair, because it's threaded it means they also find 512m of
> address space lost more problematic than the db using processes, though
> besides the reduced address space there would be no measurable slowdown
> with 2.5:1.5)

Hm. What 512Mb of address space loss are you speaking here. Are threaded
programs only able to use 2.5G in  3G/1G memory split ? 


> 
> Also the 4:4 pretty much depends on the vgettimeofday to be backported
> from the x86-64 tree and an userspace to use it, so the test may be
> repeated with vgettimeofday, though it's very possible mysql isn't using
> that much gettimeofday as other databases, especially the I/O bound
> workload shouldn't matter that much with gettimeofday.

You're right.  MySQL does not use gettimeofday very frequently now,
actually it uses time() most of the time, as some platforms used to have
huge performance problems with gettimeofday() in the past.

The amount of gettimeofday() use will increase dramatically in the
future so it is good to know about this matter.


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

