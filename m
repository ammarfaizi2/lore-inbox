Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTKIVMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 16:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTKIVMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 16:12:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50664 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261384AbTKIVMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 16:12:12 -0500
Date: Sun, 9 Nov 2003 22:12:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to allocate pages for a scatter-gather buffer?
Message-ID: <20031109211211.GS2831@suse.de>
References: <Pine.LNX.4.44L0.0311091533520.23369-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0311091533520.23369-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09 2003, Alan Stern wrote:
> Jens:
> 
> Thanks for your help in tracking down that problem with the usb-storage 
> sddr09 driver.
> 
> Now a slightly different question.  Suppose I want to allocate some pages
> as a scatter-gather buffer for I/O to a device.  I've got the device's
> dma_mask; what's the right way to convert that to a GFP bitmask for
> alloc_pages() or get_free_pages()?

This is a bit problematic, unfortunately... There really is no good way
to do this, the best you can do is approximate.

> Also, assuming I'll have to use memcpy() to transfer data into or out of 
> the scatter-gather buffer (so it will have to get a kernel virtual mapping 
> at some point), am I better off using alloc_pages() followed by 
> kmap_atomic()/kunmap_atomic() or get_free_pages()?  Or even kmalloc()?

My suggestion would be to do page allocations (not kmalloc()). With kmap
that'll work just fine for you, and it's easy to extend to just use the
right gfp mask if/when we ever get something that works for this.

-- 
Jens Axboe

