Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTICSpQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbTICSmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:42:35 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:35550 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264307AbTICSle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:41:34 -0400
Date: Wed, 3 Sep 2003 19:43:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309031111050.31853-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309031924430.2462-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Linus Torvalds wrote:
> 
> If the patches can't be made to work for private mappings, then there's
> something fundamentally wrong with them.

Of course (not).  That's the point, they do work on private mappings, but
the semantics are different on private mappings from on shared mappings:
on private mappings they're private to the mm, on shared mappings they're
shared with other mms (via the shared file).

> So the thing boils down to:
> 
>  - if the futex works on a proper private mapping, then the downgrade is 
>    still proper, and the futex should never care about anything but a real
>    VM_SHARED.

In the usual mm case, yes, deciding by VM_SHARED and
ignoring VM_MAYSHARE turns out to be the right thing to do.

But a futex differs from the usual mm case, that much was clear when
they were invented, but we're still discovering just how they are.

As I've said before, I haven't a clue about the user/glibc end of
futexes, and for all I know a futex on a shared-readonly-cannot-be-
mprotected-for-writing mapping cannot be used as a futex.  If that's
so, then perhaps we should simply prohibit sys_futex on such an area,
and settle this dispute in that way.  Is that the case?

Hugh

