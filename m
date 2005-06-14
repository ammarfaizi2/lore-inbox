Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFNNuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFNNuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 09:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVFNNuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 09:50:07 -0400
Received: from gold.veritas.com ([143.127.12.110]:11385 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261189AbVFNNuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 09:50:01 -0400
Date: Tue, 14 Jun 2005 14:51:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: li nux <lnxluv@yahoo.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: rmap.c: try_to_unmap_file(): VM_LOCKED not respected
In-Reply-To: <20050614051405.42342.qmail@web33307.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61.0506141444040.9201@goblin.wat.veritas.com>
References: <20050614051405.42342.qmail@web33307.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Jun 2005 13:49:58.0780 (UTC) FILETIME=[F4444BC0:01C570E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005, li nux wrote:
> My application is using remap_file_pages and mlocks
> those pages.
> So in the code of  try_to_unmap_file (see below),
> I should never reach the call to try_to_unmap_cluster,
> because for those pages VM_LOCKED is always set.
> But, under heavy load I am seeing try_to_unmap_cluster
> is getting called. Stack:
> try_to_unmap_cluster
> try_to_unmap_file
> try_to_unmap
> shrink_list
> 
> Any idea why VM_LOCKED is not being respected ?

Does your application fork occasionally, probably to exec something?
VM_LOCKED is masked off the flags of the child's copy vma (see dup_mmap),
so you might be seeing page reclaim hitting the child in between fork
and exec.  The parent's should remain safely VM_LOCKED as you intended.

Hugh
