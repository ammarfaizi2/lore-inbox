Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbUKRS5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbUKRS5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbUKRS40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:56:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:39883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262890AbUKRSzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:55:49 -0500
Date: Thu, 18 Nov 2004 10:55:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Tony Luck <tony.luck@intel.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Message-ID: <20041118105546.Q2357@build.pdx.osdl.net>
References: <20041116151937.E2357@build.pdx.osdl.net> <Pine.LNX.4.44.0411181720550.2971-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0411181720550.2971-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Nov 18, 2004 at 05:39:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins (hugh@veritas.com) wrote:
> On Tue, 16 Nov 2004, Chris Wright wrote:
> > Florian Heinz built an a.out binary that could map bss from 0x0 to
> > 0xc0000000, and setup_arg_pages() would BUG() in insert_vma_struct
> > because the arg pages overlapped.  This just checks before inserting,
> > and bails out if it would overlap.
> 
> Chris, shouldn't your patch also cover the setup_arg_pages clones for
> 32-bit support on 64-bit architectures, with something - uncompiled,
> untested - like the below?  I'm not sure how necessary the additional
> vma->vm_start < mpnt->vm_end test is, but suspect ia64 might need it.

I expect other arches should need the fix as well, it would be nice
to test them.  I'm not clear on that extra test.  Wouldn't it imply
vm_end < vm_start?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
