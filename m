Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVC2Uvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVC2Uvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVC2Uva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:51:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:6309 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261388AbVC2UvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:51:08 -0500
Date: Tue, 29 Mar 2005 21:50:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: "Luck, Tony" <tony.luck@intel.com>, nickpiggin@yahoo.com.au, akpm@osdl.org,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
In-Reply-To: <20050323111955.728f03d5.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0503292132090.17913@goblin.wat.veritas.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0324516D@scsmsx401.amr.corp.intel.com> 
    <20050323111955.728f03d5.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, David S. Miller wrote:
> On Wed, 23 Mar 2005 11:16:27 -0800
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
> > Can we legislate that "end==0" isn't possible.
> 
> It is possible with some out-of-tree patches.
> 
> I could certainly support it on sparc64, the only
> glitch is that this is where the virtually mapped
> linear page tables sit right now :-)

Though my knowledge of out-of-tree patches is very limited,
I believe "end == 0" is not possible on any arch - when "end"
originates from vma->vm_end (or vm_struct->addr + size).  There
are plenty of "BUG_ON(addr >= end)"s dotted around to support that,
and other places that would be confused by vm_start > vm_end.

(And when Linus first proposed the sysenter page at 0xfffff000,
I protested, and he brought it down to 0xffffe000: I think we'll
do well ever to keep that last virtual page invalid.)

But certainly "ceiling == 0" is possible and common, and "rounded-up
end" may well be 0 with out-of-tree patches.  When I did those
free_pgtables tests, it seemed simpler to treat "end" in the same
way as "ceiling", implicitly allowing it the 0 case.  Perhaps
that's not so in Nick's version, I've yet to think through it.

Hugh
