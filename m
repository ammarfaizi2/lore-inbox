Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUHSAIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUHSAIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUHSAIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:08:06 -0400
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:26552 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S267670AbUHSAHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 20:07:53 -0400
Date: Wed, 18 Aug 2004 20:07:24 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@sapphire.engin.umich.edu
To: William Lee Irwin III <wli@holomorphy.com>
cc: Hugh Dickins <hugh@veritas.com>, "David S. Miller" <davem@redhat.com>,
       raybry@sgi.com, ak@muc.de, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for
 8,32     and    512 cpu SMP
In-Reply-To: <20040819000151.GU11200@holomorphy.com>
Message-ID: <Pine.GSO.4.58.0408182005080.9340@sapphire.engin.umich.edu>
References: <2uexw-1Nn-1@gated-at.bofh.it> <2uCTq-2wa-55@gated-at.bofh.it>
 <pan.2004.08.18.23.50.13.562750@umich.edu> <20040819000151.GU11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Aug 2004, William Lee Irwin III wrote:

> William Lee Irwin III wrote:
> >> It also protects against vma tree modifications in mainline, but rmap.c
> >> shouldn't need it for vmas anymore, as the vma is rooted to the spot by
> >> mapping->i_shared_lock for file pages and anon_vma->lock for anonymous.
>
> On Wed, Aug 18, 2004 at 07:50:21PM -0400, Rajesh Venkatasubramanian wrote:
> > If I am reading the code correctly, then without page_table_lock
> > in page_referenced_one(), we can race with exit_mmap() and page
> > table pages can be freed under us.
>
> exit_mmap() has removed the vma from ->i_mmap and ->mmap prior to
> unmapping the pages, so this should be safe unless that operation
> can be caught while it's in progress.

No. Unfortunately exit_mmap() removes vmas from ->i_mmap after removing
page table pages. Maybe we can reverse this, though.

Rajesh

