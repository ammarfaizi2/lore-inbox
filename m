Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUBTGdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267780AbUBTGdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:33:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:44713 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267777AbUBTGdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:33:09 -0500
Subject: Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	 <1077256996.20789.1091.camel@gaston>
	 <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1077258504.20781.1121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 17:28:24 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-20 at 17:30, Linus Torvalds wrote:
> On Fri, 20 Feb 2004, Benjamin Herrenschmidt wrote:
> > 
> > A while ago, I've advertised making this API a set of function
> > pointers attached to the struct device inherited from the bus
> > parent, so the core code just set one for the root PCIs and
> > everybody inherits them.... But of course, since x86 isn't
> > affected, nobody cared ;)
> 
> Well, in all fairness, that _is_ what "platform_data" is supposed to be. A
> platform-specific pointer to whatever data structure that platform needs
> to have to do the device ops. Platforms that don't need the function 
> pointers wouldn't have any function pointers there, while others would 
> have not just the function pointers, but could have some other 
> bus-dependent data too.

Yes, but we don't have a hook for actually filling this pointer, do we ?

We should have a way, when creating a device, to fill it properly, like

platform_device_setup(struct device *new_dev, struct device *parent)

That would allow me to deal with the hierarchy thing (inheriting by
default the DMA stuff from the parent typically).

Now, the question is where is the best place to call this "hook" ?

> (And this is what at least HP-PA does, as does ARM...)
> 
> So it's definitely not unsuitable for this. It does seem like USB jumped 
> the gun a bit, though.

Yes. I also remember a time where the dma mask for the DMA API was all
broken too (would not be possible to map the PCI one on top of it),
but I think that got fixed. 



