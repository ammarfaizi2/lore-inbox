Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbTIDVfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbTIDVfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:35:22 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:34108 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S265553AbTIDVfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:35:14 -0400
Date: Thu, 4 Sep 2003 22:36:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
In-Reply-To: <20030904201133.GC31590@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309042224240.5364-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Jamie Lokier wrote:
> Hugh Dickins wrote:
> > 
> > You're assuming that one call to sys_remap_file_pages precisely populates
> > a whole vma: no, it's quite likely it'll just do a single page of the vma.
> 
> What are you talking about?  The condition for clearing VM_NONLINEAR
> is an explicit check to see if the range to be populated covers the
> whole vma.

I apologize, I'm just not reading, am I?  Thanks for re-explaining.

You're right, the condition on clearing is fine.  It's the (lack of
condition on) setting that's over-enthusiastic, should be saying:

	if (start - vma->vm_start != (pgoff - vma->vm_pgoff) << PAGE_SHIFT)
		vma->vm_flags |= VM_NONLINEAR;

(Unless I'm making a fool of myself again.)

Hugh

