Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTIDVAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbTIDVA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:00:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:653 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S264884AbTIDVA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:00:26 -0400
Date: Thu, 4 Sep 2003 22:00:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030904210007.GE31590@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309031141310.1273-100000@localhost.localdomain> <20030904014229.2EFBF2C097@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904014229.2EFBF2C097@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> I don't have a problem with the omission.  mremap is logically
> equivalent to munmap + mmap, so it's a subset of the "I unmapped
> underneath my futex!".  It's not like it's going to happen without the
> caller knowing: if the address doesn't change, then the futexes won't
> break.  If they do, the caller needs to reset them anyway.

I think mremap() on block of memory containing futexes is reasonable.
Imagine a big data structure with a table futex locks at the start of
it.  I'm not sure how useful it is, but it's not worthless.

Anyway, I have a patch, tested, which moves remapped futexes _and_
returns EFAULT to waiters when pages are unmapped.  It's kept separate
from the main futex patch so you can accept it or not.

-- Jamie

