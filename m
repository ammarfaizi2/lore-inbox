Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVAMDKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVAMDKp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVAMDKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:10:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15111 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261451AbVAMDJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:09:46 -0500
Date: Thu, 13 Jan 2005 03:09:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, <clameter@sgi.com>, <torvalds@osdl.org>,
       <ak@muc.de>, <linux-mm@kvack.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <41E5B7AD.40304@yahoo.com.au>
Message-ID: <Pine.LNX.4.44.0501130258210.4577-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Nick Piggin wrote:
> Andrew Morton wrote:
> 
> Note that this was with my ptl removal patches. I can't see why Christoph's
> would have _any_ extra overhead as they are, but it looks to me like they're
> lacking in atomic ops. So I'd expect something similar for Christoph's when
> they're properly atomic.
> 
> > Look, -7% on a 2-way versus +700% on a many-way might well be a tradeoff we
> > agree to take.  But we need to fully understand all the costs and benefits.
> 
> I think copy_page_range is the one to keep an eye on.

Christoph's currently lack set_pte_atomics in the fault handlers, yes.
But I don't see why they should need set_pte_atomics in copy_page_range
(which is why I persuaded him to drop forcing set_pte to atomic).

dup_mmap has down_write of the src mmap_sem, keeping out any faults on
that.  copy_pte_range has spin_lock of the dst page_table_lock and the
src page_table_lock, keeping swapout away from those.  Why would atomic
set_ptes be needed there?  Probably in yours, but not in Christoph's.

Hugh

