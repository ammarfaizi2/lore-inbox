Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTICTIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTICTHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:07:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:40328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263937AbTICTFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:05:51 -0400
Date: Wed, 3 Sep 2003 12:05:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309031924430.2462-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309031201170.31853-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Sep 2003, Hugh Dickins wrote:
> 
> Of course (not).  That's the point, they do work on private mappings, but
> the semantics are different on private mappings from on shared mappings:
> on private mappings they're private to the mm, on shared mappings they're
> shared with other mms (via the shared file).

That's not true. It never has been true in Linux.

Private mappings that haven't been broken by COW (and a read-only mapping
never will be) will see updates as they happen on the file that backs it.
That's the fundamental difference between "mmap(MAP_PRIVATE)" and
"read()".

You may not like it, and others too have not liked it (Hurd and Mach do 
this big dance about MAP_COPY that really creates a static _copy_ of the 
state at the time of the mmap), but it's just a fact.

Repeat after me: private read-only mappings are 100% equivalent to shared
read-only mappings. No ifs, buts, or maybes. This is a FACT. It's a fact 
codified in many years of Linux implementation, but it's a fact outside of 
that too.

(Yeah, yeah, I know some broken old Unixes do not offer mmap consistency
guarantees, and nntpd is unhappy. But Linux isn't broken.)

			Linus

