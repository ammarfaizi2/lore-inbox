Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbULJEyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbULJEyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbULJEyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:54:49 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:18596 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261707AbULJEyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:54:47 -0500
Message-ID: <41B92C11.80106@yahoo.com.au>
Date: Fri, 10 Dec 2004 15:54:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Hugh Dickins <hugh@veritas.com>, Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain> <41B92567.8070809@yahoo.com.au>
In-Reply-To: <41B92567.8070809@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Yep, the update_mmu_cache issue is real. There is a parallel problem
> that is update_mmu_cache can be called on a pte who's page has since
> been evicted and reused. Again, that looks safe on IA64, but maybe
> not on other architectures.
> 
> It can be solved by moving lru_cache_add to after update_mmu_cache in
> all cases but the "update accessed bit" type fault. I solved that by
> simply defining that out for architectures that don't need it - a raced
> fault will simply get repeated if need be.
> 

The page-freed-before-update_mmu_cache issue can be solved in that way,
not the set_pte and update_mmu_cache not performed under the same ptl
section issue that you raised.
