Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbUKKPmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbUKKPmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbUKKPmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:42:21 -0500
Received: from peabody.ximian.com ([130.57.169.10]:36069 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262243AbUKKPlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:41:09 -0500
Subject: Re: mmap vs. O_DIRECT
From: Robert Love <rml@novell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41937C1A.30800@tmr.com>
References: <cmtsoo$j55$1@gatekeeper.tmr.com>
	 <1100121230.4739.1.camel@betsy.boston.ximian.com>  <41937C1A.30800@tmr.com>
Content-Type: text/plain
Date: Thu, 11 Nov 2004 10:41:56 -0500
Message-Id: <1100187716.5358.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 09:50 -0500, Bill Davidsen wrote:

> I miss your point about synchronous, with hundreds of clients doing 
> small reads against a 10TB database, the benefit of pushing them through 
> the page cache isn't obvious. No particular data are in memory long 
> enough to have much chance of being shared, so it looks like overhead to 
> me. Feel free to educate me.

There is a difference between being synchronous and not going through
the page cache, although in Linux we don't really have the distinction.

> I certainly DO want to put more users per server, and direct I/O has 
> proven itself in actual use. I'm not sure why you think the double copy 
> is a good thing, but I have good rea$on to want more users per server.
> 
> Alan: point on MAP_SHARED taken.

BTW, Alan's point on MAP_SHARED is just that you can have the mmap
region and the page cached region be one and the same.  You still aren't
doing direct I/O.

Maybe that is ultimately what you want.

It is rare to see direct I/O perform better when you use it as normal
file I/O (e.g. don't perform your own caching and scheduling) but if you
really do measure improvements, and if you never reaccess the data (and
thus the lack of cache is not a problem), then by all means use it.

But we still don't want to make normal mmap's be direct.

	Robert Love


