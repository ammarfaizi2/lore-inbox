Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269448AbUJSPEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269448AbUJSPEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269449AbUJSPEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:04:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:61133 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269448AbUJSPEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:04:16 -0400
Date: Tue, 19 Oct 2004 08:04:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Delete drivers/pci/syscall.c?
In-Reply-To: <20041019124850.GM16153@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0410190801250.2317@ppc970.osdl.org>
References: <20041019124850.GM16153@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Oct 2004, Matthew Wilcox wrote:
> 
> Linus, I noticed you touching drivers/pci/syscall.c which made me look
> a bit more carefully at that file.  It is broken for machines with
> overlapping PCI bus numbers in separate domains.  There's basically no
> way to fix this unless we encode the domain into the upper bits of the
> bus number.
> 
> The information is already available through /proc and /sys.  It's hooked
> into the syscall tables of alpha, arm, ia64, ppc, ppc64, sparc and
> sparc64.  Whatever's using those syscalls must have some kind of backup
> strategy for grovelling around in files.

While the system calls may be broken in theory (multiple domains) they are 
not broken in practice (single-domain workstations), and they _were_ used 
by X, at least on alpha last time I looked.

And no, expectign X to have a fallback and to understand multiple domains 
is likely not a valid expectation.

So right now X may work only on single-domain setups, or on setups where 
the video card has a unique address when ignoring the domnain number. 
That's pretty much all of the affected machines, so no, I don't think we 
can/should remove it.

Will X eventually learn about multiple domains? Maybe. 

			Linus
