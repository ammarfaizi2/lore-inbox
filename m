Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265589AbTIDV6v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbTIDV6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:58:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:5517 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265591AbTIDV6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:58:43 -0400
Date: Thu, 4 Sep 2003 22:58:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
Message-ID: <20030904215814.GH31590@mail.jlokier.co.uk>
References: <20030904201133.GC31590@mail.jlokier.co.uk> <Pine.LNX.4.44.0309042224240.5364-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309042224240.5364-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> You're right, the condition on clearing is fine.  It's the (lack of
> condition on) setting that's over-enthusiastic, should be saying:
> 
> 	if (start - vma->vm_start != (pgoff - vma->vm_pgoff) << PAGE_SHIFT)
> 		vma->vm_flags |= VM_NONLINEAR;

I hadn't thought of that.

I wonder if it's useful, though.  The only time it's likely to not set
the flag with it not already set, in real use, is when other VM code
calls remap_file_pages() with the whole vma.  But then the flag is
cleared by the next line.

So it's correct and nice, but I'm not sure it adds anything practical.

-- Jamie
