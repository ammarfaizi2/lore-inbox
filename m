Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbUKRUbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbUKRUbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbUKRUaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:30:14 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:7145 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261153AbUKRTmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:42:21 -0500
Date: Thu, 18 Nov 2004 19:41:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Tony Luck <tony.luck@intel.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma
In-Reply-To: <20041118105546.Q2357@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0411181932250.4013-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Chris Wright wrote:
> * Hugh Dickins (hugh@veritas.com) wrote:
> > 
> > Chris, shouldn't your patch also cover the setup_arg_pages clones for
> > 32-bit support on 64-bit architectures, with something - uncompiled,
> > untested - like the below?  I'm not sure how necessary the additional
> > vma->vm_start < mpnt->vm_end test is, but suspect ia64 might need it.
> 
> I expect other arches should need the fix as well, it would be nice
> to test them.

ia64, s390 and x86_64 seem to be the only ones with their own code
to insert_vm_struct for 32-bit setup_arg_pages.

> I'm not clear on that extra test.  Wouldn't it imply vm_end < vm_start?

Whose vm_end and whose vm_start?  Well, no need to answer...

Check the comment on find_vma in mm/mmap.c:
/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
but perhaps you thought it returns NULL if addr is not covered by a vma?

If so, maybe your original fs/exec.c fix also needs that check added:
it's usually the case that there cannot be a vma above the stack being
set up here, but I don't know enough of all the architectures to say
that's always so (and it looks like not the case for 32-bit on ia64).

Hugh

