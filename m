Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVC2Veo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVC2Veo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVC2VdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:33:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:37560 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261461AbVC2Vcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:32:42 -0500
Date: Tue, 29 Mar 2005 22:32:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: David Howells <dhowells@redhat.com>, Ian Molton <spyro@f2s.com>,
       nickpiggin@yahoo.com.au, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
In-Reply-To: <20050325162926.6d28448b.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0503292223090.18131@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> 
    <4243A257.8070805@yahoo.com.au> 
    <20050325092312.4ae2bd32.davem@davemloft.net> 
    <20050325162926.6d28448b.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, David S. Miller wrote:

[ of flush_tlb_pgtables ]

> Since sparc64 is the only user of this thing...

Not quite.  sparc64 is the only user which makes any use of the
addresses passed to it, but frv does a little assembler with it,
and arm26 does a printk - eh? I'd take that to mean that it never
gets called there, but I don't see what prevents it, before or now.
Ian, does current -mm give you "flush_tlb_pgtables" printks?

> Let's make it so that the flush can be queued up
> at pmd_clear() time, as that's what we really want.
> 
> Something like:
> 
> 	pmd_clear(mm, vaddr, pmdp);
> 
> I'll try to play with something like this later.

Depends really on what DavidH wants there, not clear to me.
I suspect Ian can live without his printk!

Hugh
