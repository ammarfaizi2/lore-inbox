Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVC3Tc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVC3Tc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVC3Tc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:32:28 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:24525 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262398AbVC3TaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:30:22 -0500
Date: Wed, 30 Mar 2005 20:30:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
In-Reply-To: <42420928.7040502@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0503302008080.21817@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> 
    <20050323115736.300f34eb.davem@davemloft.net> 
    <42420928.7040502@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, Nick Piggin wrote:
> 
> OK, attached is my first cut at slimming down the boundary tests.
> I have only had a chance to try it on i386, so I hate to drop it
> on you like this - but I *have* put a bit of thought into it....
> Treat it as an RFC, and I'll try to test it on a wider range of
> things in the next couple of days.

I've stared and stared at it.  I think I mostly like it.
It's nicer to be rounding end up than ceiling down.

It's clearly superior to what David and I had, in branching
less (other than in your BUG_ONs), and I do believe your
"if (end - ceiling - 1 < P*_SIZE - 1)" is correct and efficient.

But I still find it harder to understand than ours; and don't
understand at all your comment "end can't have approached ceiling
from above...." - but I think you're bravely trying to explain the case
I sidestepped with a lordly unexplained "end can't go down to 0 there".

Let others decide.

One thing I believe is outright wrong, at least with out-of-tree
patches: your change from "if (addr > end - 1)" to "if (addr >= end)",
after you've just rounded up end (perhaps to 0).

(And let me astonish you by asking for the blank lines back before
pmd_offset and pud_offset!)

Hugh
