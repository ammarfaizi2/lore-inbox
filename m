Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUIOULh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUIOULh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUIOUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:09:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:17553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267365AbUIOUHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:07:08 -0400
Date: Wed, 15 Sep 2004 13:06:29 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915200629.GA24723@kroah.com>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org> <20040915173236.GE6158@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409151045530.2333@ppc970.osdl.org> <20040915193414.GA24131@kroah.com> <Pine.LNX.4.58.0409151251060.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409151251060.2333@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 12:53:51PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 15 Sep 2004, Greg KH wrote:
> > 
> > Currently a few drivers do:
> > 	status = readl(&regs.status);
> 
> I assume that's "&regs->status", since regs had better be a pointer..

Yes, sorry.

> > which causes sparse warnings.
> > 
> > How should that code be changed to prevent this?  Convert them all to
> > ioread32()?  Or figure out a way to supress the warning for readl()?
> 
> Just make sure that you annotate "regs" as a pointer to IO space.

Ah, ok, that works.  Thanks for the clarification, I now realize that
__iomem can be a marker for any type of pointer, not just a void.
That's where I was confused.

thanks,

greg k-h
