Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265451AbTIDSeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbTIDSeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:34:07 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:33413 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S265451AbTIDSeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:34:02 -0400
Date: Thu, 4 Sep 2003 19:35:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
In-Reply-To: <20030904175939.GD30394@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309041924070.4300-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Jamie Lokier wrote:
> 
> I don't see why you can't clear the flag: the call to ->populate will
> change every page and pte_file to correspond with the linear page
> offsets, which is all that !VM_NONLINEAR indicates.

You're assuming that one call to sys_remap_file_pages precisely populates
a whole vma: no, it's quite likely it'll just do a single page of the vma.

> The important things are that the futex is queued prior to checking
> curval, the requested page won't change (it's protected by mmap_sem),
> and any parallel waker changes the word prior to waking us.

Ah, that may well be so, it's beyond me,
just so long as Rusty is happy with it.

(I don't think you mean "the requested page won't change" - the
down_read on mmap_sem does not prevent it from being swapped out
before the get_user, but nor does it prevent a replacement page
being faulted back in by get_user, and we no longer have any
dependence on those being the same physical page.)

Hugh

