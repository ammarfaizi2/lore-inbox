Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbTIDBmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTIDBmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:42:31 -0400
Received: from dp.samba.org ([66.70.73.150]:24497 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264492AbTIDBm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:42:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix 
In-reply-to: Your message of "Wed, 03 Sep 2003 12:19:53 +0100."
             <Pine.LNX.4.44.0309031141310.1273-100000@localhost.localdomain> 
Date: Thu, 04 Sep 2003 11:30:04 +1000
Message-Id: <20030904014229.2EFBF2C097@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309031141310.1273-100000@localhost.localdomain> you write:
> On Wed, 3 Sep 2003, Jamie Lokier wrote:
> > I have an obvious fix for mremap(): rehash all the futexes in its
> > range.  That's not in the attached patch, but it will be in the next one.
> 
> Will it be worth the code added to handle it?  I wonder the same of
> non-linear (sys_mremap and sys_remap_file_pages, familiar troublemakers).
> But all credit for handling them, good to reduce "undefined behaviour"s.

I don't have a problem with the omission.  mremap is logically
equivalent to munmap + mmap, so it's a subset of the "I unmapped
underneath my futex!".  It's not like it's going to happen without the
caller knowing: if the address doesn't change, then the futexes won't
break.  If they do, the caller needs to reset them anyway.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
