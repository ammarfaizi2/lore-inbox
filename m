Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVFTQBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVFTQBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVFTQBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:01:11 -0400
Received: from silver.veritas.com ([143.127.12.111]:56196 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261364AbVFTQBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:01:02 -0400
Date: Mon, 20 Jun 2005 17:02:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
In-Reply-To: <Pine.LNX.4.61.0506201114310.5144@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0506201655170.3911@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
 <Pine.LNX.4.61.0506201443400.2903@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0506201018460.5458@chaos.analogic.com>
 <Pine.LNX.4.61.0506201530450.3324@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0506201114310.5144@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Jun 2005 16:01:01.0889 (UTC) FILETIME=[41860310:01C575B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Richard B. Johnson wrote:
> On Mon, 20 Jun 2005, Hugh Dickins wrote:
> > On Mon, 20 Jun 2005, Richard B. Johnson wrote:
> > > On Mon, 20 Jun 2005, Hugh Dickins wrote:
> > > > 
> > > > It's the BUG_ON(!pte_none(*pte)) in remap_pte_range.  Maybe your
> > > > page
> > > > table is corrupt, maybe your driver is trying to remap_pfn_range
> > > > on
> > > > top of something already mapped.
> 
> Well there is no existing 'populated mapping' whatever that means.
> I think the logic in the header is wrong.

Then perhaps your page table is corrupt.  But my guess would be
that for some reason you're mapping it into userspace twice,
and the second attempt is BUGing.

> The driver gets contiguous DMA RAM by telling the kernel that ...
> [ snipped because which pages you are mapping is irrelevant to this problem ]
> ... These pages will be subsequently mapped into
> user-space when the user calls mmap().
> 
> Previous to 2.6.12, there was no problem memory-mapping and using
> this data-area. Now there is some artificial constraint.

Strange.  We don't know of any new artificial constraint there.
You'd better do some debugging e.g. print out what's in the pte
that isn't pte_none, and what is pte you want to replace it by.

Hugh
