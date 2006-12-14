Return-Path: <linux-kernel-owner+w=401wt.eu-S932885AbWLNSAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885AbWLNSAc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932884AbWLNSAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:00:32 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39268 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932886AbWLNSAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:00:31 -0500
Date: Thu, 14 Dec 2006 10:00:08 -0800
From: Greg KH <greg@kroah.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Hans-J?rgen Koch <hjk@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: Userspace I/O driver core
Message-ID: <20061214180008.GA24568@kroah.com>
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il> <200612141125.14777.hjk@linutronix.de> <45812C17.4090309@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45812C17.4090309@argo.co.il>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 12:48:55PM +0200, Avi Kivity wrote:
> [why trim the cc?]
> 
> Hans-J?rgen Koch wrote:
> >Am Donnerstag, 14. Dezember 2006 10:44 schrieb Avi Kivity:
> >
> >  
> >>I understand one still has to write a kernel driver to shut up the irq.  
> >>How about writing a small bytecode interpreter to make event than 
> >>unnecessary?
> >>
> >>The userspace driver would register a couple of bytecode programs: 
> >>is_interrupt_pending() and disable_interrupt(), which the uio framework 
> >>would call when the interrupt fires.
> >>
> >>The bytecode could reuse net/core/filter.c, with the packet replaced by 
> >>the mmio or ioregion, or use something new.
> >>
> >>    
> >
> >I think this would be overkill. The kernel module you have to write
> >is _really_ very simple. And it has to be written only once, so even
> >a manufacturer who employs no experienced kernel developers can
> >easily outsource that task.
> >
> >  
> 
> It has to be written once, but compiled for every kernel version and 
> $arch out there (for out of tree drivers), or it has to wait for the 
> next kernel release and distro sync (for in-tree drivers).

No, just get the tiny driver into the main kernel tree, like all other
drivers are required to do.

> If we make userspace drivers possible, it makes sense that the entire 
> driver be in userspace, not just 98.7% of it.

If you see a way to do this that is race-free, I know a lot of people
would be glad to see such a patch.

But until then, no, we are not making any such claims of 100% userspace
driver for hardware such as pci devices and other things that this uio
core works with.

thanks,

greg k-h
