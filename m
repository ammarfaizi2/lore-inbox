Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263896AbTICSEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTICSEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:04:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39568 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263896AbTICSEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:04:39 -0400
Date: Wed, 3 Sep 2003 19:06:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309031052000.26650-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309031859370.2336-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Linus Torvalds wrote:
> 
> Actually: the VM_SHARED flag will never change, so testing VM_SHARED is 
> actually the _right_ thing from a mm perspective.
> 
> The only person who should ever test VM_MAYSHARE is somebody who does
> reporting back to user space: VM_MAYSHARE basically ends up meaning "the
> user _asked_ for a shared mapping". While "VM_SHARED" means "this mapping
> can actually contain a shared dirty page".
> 
> The VM itself should only ever care about VM_SHARED. Because that's the 
> only bit that has real semantic meaning.

To that part of the kernel interested in dirty pages, yes.
But when interested in futexes, it seems not.

If we're going to document a behaviour as depending on whether the user
said MAP_SHARED or MAP_PRIVATE, then it's VM_MAYSHARE we should check to
decide which behaviour to use.

We could use VM_SHARED, and document the behaviour of the futex as
depending on whether it's in an area that was MAP_SHARED from a file
which was opened for writing as well as reading - but do we really
want to complicate the documentation that way?   Principle of least
least surprise, principle of minimal doc.

Hugh

