Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVFTOki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVFTOki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 10:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVFTOkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 10:40:36 -0400
Received: from silver.veritas.com ([143.127.12.111]:53622 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261264AbVFTOk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 10:40:29 -0400
Date: Mon, 20 Jun 2005 15:41:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
In-Reply-To: <Pine.LNX.4.61.0506201018460.5458@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0506201530450.3324@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
 <Pine.LNX.4.61.0506201443400.2903@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0506201018460.5458@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Jun 2005 14:40:29.0164 (UTC) FILETIME=[00FEB2C0:01C575A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Richard B. Johnson wrote:
> On Mon, 20 Jun 2005, Hugh Dickins wrote:
> > 
> > It's the BUG_ON(!pte_none(*pte)) in remap_pte_range.  Maybe your page
> > table is corrupt, maybe your driver is trying to remap_pfn_range on
> > top of something already mapped.
> 
> But of course it is. There is some memory that is mapped into the
> driver's address space, used for DMA. It was obtained using
> ioremap_nocache(). This memory is then mapped into user-space
> when the user executes mmap(). This is how we DMA directly to
> user-space. Is this no longer allowed?

Of course that is allowed.  But mapping it into userspace on top of
an existing populated mapping in userspace is not and has never been
allowed (well, in 2.4.0 it just generated a printk, from 2.4.10
onwards it's been a BUG).

Hugh
