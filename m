Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVCVTuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVCVTuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVCVToC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:44:02 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:61085 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261759AbVCVThu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:37:50 -0500
Date: Tue, 22 Mar 2005 19:36:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <20050322112329.70bde057.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com> 
    <20050322034053.311b10e6.akpm@osdl.org> 
    <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com> 
    <20050322110144.3a3002d9.davem@davemloft.net> 
    <20050322112125.0330c4ee.davem@davemloft.net> 
    <20050322112329.70bde057.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, David S. Miller wrote:
> On Tue, 22 Mar 2005 11:21:25 -0800
> "David S. Miller" <davem@davemloft.net> wrote:
> 
> > I'm trying to analyze my traces some more.
> 
> I think I see what's going wrong.  On the first
> address space traversal (free_pgd_range()), we
> clear out the pgd, even though there are still
> more PMD's to process in that PGD.
> 
> So the future loops never do anything since the
> PGD is cleared out already.

Yes, that's the conclusion I was coming to from your excellent traces.

I notice that although both i386 and sparc64 use pgtable-nopud.h, the
i386 pud_clear does nothing at all and the sparc64 pud_clear resets to 0.

If that really is the problem, well, I get as easily mixed between
the levels as the next man, and haven't a clue which is the right
way to do it - beyond i386 not seeing these nr_pte bugs.

But if this is the issue, I don't see how it's new to my freepgt
patches - beyond the fact that they add this BUG_ON consistency check.

Hugh
