Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFORzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFORzm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFORzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:55:42 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:14003 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261249AbVFORzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:55:07 -0400
Date: Wed, 15 Jun 2005 10:54:47 -0700
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/04] PCI: use the MCFG table to properly access pci devices (i386)
Message-ID: <20050615175447.GA29138@suse.de>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615094833.GB11898@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615094833.GB11898@wotan.suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 11:48:33AM +0200, Andi Kleen wrote:
> On Tue, Jun 14, 2005 at 10:31:20PM -0700, Greg KH wrote:
> > Now that we have access to the whole MCFG table, let's properly use it
> > for all pci device accesses (as that's what it is there for, some boxes
> > don't put all the busses into one entry.)
> > 
> > If, for some reason, the table is incorrect, we fallback to the "old
> > style" of mmconfig accesses, namely, we just assume the first entry in
> > the table is the one for us, and blindly use it.
> 
> I think it would be better to set different bus->ops at probe
> time, not walk the table at runtime.

Yeah, I thought of that, but it's the same ops pointers that we want to
have called for the different devices.  The only thing different is the
base address of the bus.

In sleeping on it, I thought about just using the void * we have
availble for the bus to use to hold this base address, that way we only
have to look it up at bus creation time, not for every device access.

Of course to do that I might need another callback in the ops structure,
but hey, what's one more pointer :)

Sound a bit more reasonable?  I'll try to prototype this later tonight.

thanks,

greg k-h
