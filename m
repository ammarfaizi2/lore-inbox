Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263376AbVCKPV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbVCKPV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbVCKPV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:21:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:7330 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263422AbVCKPV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:21:28 -0500
Date: Fri, 11 Mar 2005 07:21:06 -0800
From: Greg KH <greg@kroah.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for 2.6.11)
Message-ID: <20050311152106.GA32584@kroah.com>
References: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU> <20050311071825.GA28613@kroah.com> <16945.22566.593812.759201@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16945.22566.593812.759201@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 07:34:46PM +1100, Peter Chubb wrote:
> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
> 
> Greg> On Fri, Mar 11, 2005 at 02:37:17PM +1100, Peter Chubb wrote:
> >> +/* + * The PCI subsystem is implemented as yet-another pseudo
> >> filesystem, + * albeit one that is never mounted.  + * This is its
> >> magic number.  + */ +#define USR_PCI_MAGIC (0x12345678)
> 
> Greg> If you make it a real, mountable filesystem, then you don't need
> Greg> to have any of your new syscalls, right?  Why not just do that
> Greg> instead?
> 
> 
> The only call that would go is usr_pci_open() -- you'd still need 
> usr_pci_map()

see mmap(2)

> , usr_pci_unmap()

see munmap(2)

In fact, both of the above can be done today from /proc/bus/pci/ right?

> and usr_pci_get_consistent().

Hm, this one might be different.  How about just opening and mmap a new
file for the pci device for this?

thanks,

greg k-h
