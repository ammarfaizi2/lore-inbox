Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUIOTe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUIOTe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUIOTe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:34:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:7554 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267334AbUIOTey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:34:54 -0400
Date: Wed, 15 Sep 2004 12:34:14 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915193414.GA24131@kroah.com>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org> <20040915173236.GE6158@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409151045530.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409151045530.2333@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 10:57:25AM -0700, Linus Torvalds wrote:
> 
> So you can absolutely still continue with
> 
> 	struct mydev_iolayout {
> 		__u32 status;
> 		__u32 irqmask;
> 		...
> 
> 	struct mydev_iolayout __iomem *regs = pci_map(...);
> 	status = ioread32(&regs.status);
> 
> which is often a lot more readable, and thus in fact _preferred_. It also
> adds another level of type-checking, so I applaud drivers that do this.

Currently a few drivers do:
	status = readl(&regs.status);
which causes sparse warnings.

How should that code be changed to prevent this?  Convert them all to
ioread32()?  Or figure out a way to supress the warning for readl()?

thanks,

greg k-h
