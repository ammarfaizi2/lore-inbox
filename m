Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbTIDPkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbTIDPkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:40:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:40933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265054AbTIDPkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:40:35 -0400
Date: Thu, 4 Sep 2003 08:40:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309041230020.3647-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309040837560.580-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Hugh Dickins wrote:
> 
> Isn't it the case that to use sys_futex (in the way it's intended),
> userspace needs write access to the futex?  FUTEX_WAIT and FUTEX_WAKE
> are used (depending on condition) after decrementing or incrementing
> the futex in userspace.  FUTEX_FD is not such a clear case, but again
> it appears that you'd use it for an async wait after decrementing.
> FUTEX_REQUEUE seems to be a move or remap, doesn't change the picture.

Yes. 

We can certainly just document it as a nonsense op. All I care about is
that it is _consistently_ broken, and that people don't make read-only
MAP_SHARED do something it has never ever done before - differ from a
semantic standpoint.

> The particular case above: if it's !PROT_WRITE MAP_PRIVATE, I'm
> saying that's not an area you can manipulate mutexes in anyway;

However, the thing is, the case really can be a totally writable
MAP_PRIVATE that just hasn't been modified (and thus not COW'ed) _yet_.

But sure, we could just require that futex pages are dirty in this case.

		Linus

