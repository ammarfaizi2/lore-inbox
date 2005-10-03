Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVJCGgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVJCGgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 02:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVJCGgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 02:36:36 -0400
Received: from sccrmhc12.comcast.net ([63.240.76.22]:42726 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932165AbVJCGgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 02:36:35 -0400
Date: Sun, 2 Oct 2005 23:05:24 -0400
From: Christopher Li <usb-devel@chrisli.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: chrisl@vmware.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH] incrase usbdevfs bulk buffer size
Message-ID: <20051003030524.GA678@64m.dyndns.org>
References: <20051001202059.GE3453@64m.dyndns.org> <20051002150829.35107f91.zaitcev@redhat.com> <20051002193422.GH3453@64m.dyndns.org> <20051002211014.195ff1c3.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002211014.195ff1c3.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 09:10:14PM -0700, Pete Zaitcev wrote:
> On Sun, 2 Oct 2005 15:34:22 -0400, Christopher Li <usb-devel@chrisli.org> wrote:
> > 
> > I think the API is kind of fine in this aspect. The usbdevfs should be
> > able to take bigger than 16K, but the internal copy of the urb does not
> > have to use kmalloc on data buffers.
> 
> You miss an important detail here, namely that single URBs do not have
> a capability to transfer to a discotiguous buffer. As long as you try

That is exactly my point that the kernel should not limit itself on only
using contiguous buffers. Every USB controller can handle discrete DMA
buffer why shouldn't the kernel? Obviously it should be nice to address
the contiguous buffer restriction before bump up the bulk transfer limit.

> to map one transfer insive VMware to one URB, one and only one kmalloc

The current usbdevfs does a extra copy between from the user space urb
to the kernel space urb. So it does not matter if the user space urb is
contiguous or not. If the kernel can handle discrete dma internally,
the usbdevfs could use it and maintain it's current API.

BTW, That is not VMware choice how the data buffer was arranged. It is the guest.

> has to be done. But if splitting the transfer is acceptable, there is

I still think fixing the kernel to allow address scatter-getter buffer and
allow bigger buffer size is the right thing to do.

Chris

