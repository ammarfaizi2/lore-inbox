Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbUDONp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263882AbUDONp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:45:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:18174 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263715AbUDONp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:45:27 -0400
Date: Thu, 15 Apr 2004 14:45:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarking objrmap under memory pressure
In-Reply-To: <20040415132256.GC2150@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404151439140.8774-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Andrea Arcangeli wrote:
> 
> yes, that's a major benefit, doing vma merging with file mappings is a
> lot more important than for anonymous ram, most people only uses
> mprotect to switch the write bit on the vma before/after using some
> MAP_SHARED segment, if a bug accours while they don't use the mapping
> they won't risk to corrupt the data. That's a very common behaviour for
> big apps and it has never been possible to merge until now in anon-vma.

I like file vma merging, but I am puzzled why we (you) bothered 
to implement anon vma merging before and not file vma merging,
if the file vma merging is so much more important.  I suppose
it's something you learnt later, or the apps evolved.

> But this is pretty orthgonal with the anon-vma vs anonmm comparison, if
> you're ok to deal with the anon-vma complexity you can merge this bit on
> top of anonmm too, the compexity of doing anon-vma merging is the same
> one of doing the inode-vma merging.

Indeed.  If anonmm does live on, I would want to add the file
vma merging; but when things (mpol, prio_tree, i_shared locking)
have settled down rather than now - we've lived without it for
some years, can live without it for a few weeks more.

Hugh

