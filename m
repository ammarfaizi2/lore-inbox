Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVCVFxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVCVFxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVCVFuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:50:25 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14930 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262469AbVCVFsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:48:25 -0500
Date: Tue, 22 Mar 2005 05:47:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <20050321142650.7364fac1.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0503220543100.5484@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com> 
    <20050321142650.7364fac1.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, David S. Miller wrote:
> 
> flush_tlb_pgtables() on sparc64 has a BUG() check which
> is basically:
> 
> 	BUG((long)start > (long)end);
> 
> This catches two cases of bogus arguments:
> 
> 1) start --> end straddles sparc64 address space hole

That's an interesting remark.  I hadn't noticed the signed long type.
I believe the vma gathering in free_pgtables will have no problem with
that, but what about the old code?  What happens if an app does a huge
munmap straddling the address space hole?  Or is all the user address
space below the hole?

Hugh
