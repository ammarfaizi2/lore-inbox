Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbUCJLjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 06:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbUCJLjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 06:39:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:21203 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262386AbUCJLjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 06:39:14 -0500
Subject: Re: inconsistent do_gettimeofday for copy_page
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ashwin Rao <ashwin_s_rao@yahoo.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20040310111919.83754.qmail@web10901.mail.yahoo.com>
References: <20040310111919.83754.qmail@web10901.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1078918542.9745.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 22:35:42 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 22:19, Ashwin Rao wrote:
> For calculating the time required to copy_page i tried
> the do_gettimeofday for 1000 pages in a loop. But as
> the number of pages changes the time required varies
> non-linearly.

That's expected, unless you have no cache ;) Then you also
have the TLB misses..

> I also tried reading xtime and using monotonic_clock
> but they didnt help either. For do_gettimeof day for a
> single invocation of copy_page on a pentium 4 gave me
> 10 microsecs but when invoked for a 1000 pages the
> time required was 750ns per page.
> Is there some way of finding out the exact time
> required for copying a page.

No. It depends mostly on cache effects and bus usage, though
you can probably get good approximation for both the cases
where everything is in the cache on both sides of the copy,
and when you are in the worst case scenario of cold cache
or larger copy than the cache.

Ben.


