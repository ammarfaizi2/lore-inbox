Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbULJFH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbULJFH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 00:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbULJFH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 00:07:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:52126 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261726AbULJFHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 00:07:11 -0500
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
	performance tests
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <41B92C11.80106@yahoo.com.au>
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
	 <41B92567.8070809@yahoo.com.au>  <41B92C11.80106@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 16:06:16 +1100
Message-Id: <1102655177.22746.29.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 15:54 +1100, Nick Piggin wrote:
> Nick Piggin wrote:
> 
> > Yep, the update_mmu_cache issue is real. There is a parallel problem
> > that is update_mmu_cache can be called on a pte who's page has since
> > been evicted and reused. Again, that looks safe on IA64, but maybe
> > not on other architectures.
> > 
> > It can be solved by moving lru_cache_add to after update_mmu_cache in
> > all cases but the "update accessed bit" type fault. I solved that by
> > simply defining that out for architectures that don't need it - a raced
> > fault will simply get repeated if need be.
> > 
> 
> The page-freed-before-update_mmu_cache issue can be solved in that way,
> not the set_pte and update_mmu_cache not performed under the same ptl
> section issue that you raised.

What is the problem with update_mmu_cache ? It doesn't need to be done
in the same lock section since it's approx. equivalent to a HW fault,
which doesn't take the ptl...

Ben.


