Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTETA4P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTETA4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:56:15 -0400
Received: from dp.samba.org ([66.70.73.150]:42136 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263349AbTETA4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:56:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2 
In-reply-to: Your message of "Tue, 20 May 2003 00:33:53 +0100."
             <20030519233353.GD13706@mail.jlokier.co.uk> 
Date: Tue, 20 May 2003 10:39:38 +1000
Message-Id: <20030520010913.3300F2C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030519233353.GD13706@mail.jlokier.co.uk> you write:
> Ingo Molnar wrote:
> > FUTEX_FD is an instant DoS, it allows the pinning of one page per file
> > descriptor, per thread. With a default limit of 1024 open files per
> > thread, and 256 threads (on a sane/conservative setup), this means 1 GB of
> > RAM can be pinned down by a normal unprivileged user.
> 
> The correct solution [;)] is EP_FUTEX - allow a futex to be specified
> as the source of an epoll event.

Hi Jamie!

No, you don't understand (or maybe you were being facetious 8).

A normal futex blocks: ie. you can only have one futex being slept on
per process, so pinning a page is probably fine.

The NGPT guys wanted to allow waiting on more than one futex per
process.  If you want to allow this through *any* mechanism, you have to:

1) Allocate something for each futex.  The normal case uses the stack,
   so never fails.

2) Control the number which can be used at once.

The current implementation needs a tighter #2.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
