Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUHaPH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUHaPH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUHaPH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:07:59 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:14292 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268690AbUHaPHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:07:55 -0400
Subject: Re: What policy for BUG_ON()?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: bunk@fs.tum.de, arjanv@redhat.com, axboe@suse.de, torvalds@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1093964782.434.7054.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 Aug 2004 11:06:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, Adrian Bunk wrote:

> Let me try to summarize the different options regarding BUG_ON, 
> concerning whether the argument to BUG_ON might contain side effects, 
> and whether it should be allowed in some "do this only if you _really_ 
> know what you are doing" situations to let BUG_ON do nothing.
> 
> Options:
> 1. BUG_ON must not be defined to do nothing
> 1a. side effects are allowed in the argument of BUG_ON
> 1b. side effects are not allowed in the argument of BUG_ON
> 2. BUG_ON is allowed to be defined to do nothing
> 2a. side effects are allowed in the argument of BUG_ON
> 2b. side effects are not allowed in the argument of BUG_ON

It comes down to the relative importance of:

i.  BUG_ON(expensive_and_unneeded_debug_test())
ii. BUG_ON(something_that_must_execute())

I think case i should get priority, since then the
removal of side effects is a nice way to eliminate
the expensive code for non-debug builds.

For case ii, it's easy enough to split out the
need-to-execute code and assign results to a
variable that can be checked later. Since it is
something that must execute, you probably need
the return value anyway.

The normal expectation for non-debug builds
would be this:

#define BUG_ON(x)


