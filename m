Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTETADf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTETADf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:03:35 -0400
Received: from dp.samba.org ([66.70.73.150]:4752 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262316AbTETAD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:03:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2 
In-reply-to: Your message of "Mon, 19 May 2003 18:06:50 +0200."
             <Pine.LNX.4.44.0305191752130.13233-100000@localhost.localdomain> 
Date: Tue, 20 May 2003 10:15:23 +1000
Message-Id: <20030520001623.8634A2C0F5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0305191752130.13233-100000@localhost.localdomain> you
 write:
> 
> > >  - start the phasing out of FUTEX_FD. This i believe is quite unclean and
> > >    unrobust, [...]
> 
> FUTEX_FD is an instant DoS, it allows the pinning of one page per file
> descriptor, per thread. With a default limit of 1024 open files per
> thread, and 256 threads (on a sane/conservative setup), this means 1 GB of
> RAM can be pinned down by a normal unprivileged user.

Yes.  There was a patch which limited it, never got applied.

The real solution is not to pin the page: I pinned the page originally
to prevent dealing with addresses changing due to swap out, but you
found the COW bug and that blew away that theory anyway 8)

I think the vcache callbacks or similar could be extended to cover the
swap out/swap in case.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
