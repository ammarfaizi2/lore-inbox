Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVCKQqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVCKQqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVCKQqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:46:04 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:48342 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261196AbVCKQpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:45:30 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for 2.6.11)
Date: Fri, 11 Mar 2005 08:45:10 -0800
User-Agent: KMail/1.7.2
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
References: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU> <16945.22566.593812.759201@wombat.chubb.wattle.id.au> <20050311152106.GA32584@kroah.com>
In-Reply-To: <20050311152106.GA32584@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503110845.10694.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 11, 2005 7:21 am, Greg KH wrote:
> > The only call that would go is usr_pci_open() -- you'd still need
> > usr_pci_map()
>
> see mmap(2)
>
> > , usr_pci_unmap()
>
> see munmap(2)

Aren't those different cases though?  E.g. you might have a buffer in userland 
that you want to DMA to a card, sure you can mmap the registers to program 
the DMA, but you need a way to pin the memory and get the bus address to send 
down, right?

> In fact, both of the above can be done today from /proc/bus/pci/ right?
>
> > and usr_pci_get_consistent().
>
> Hm, this one might be different.  How about just opening and mmap a new
> file for the pci device for this?

New syscalls seem like the cleanest solution.  For basic, non-dma programming 
though, I'd suggest just using sysfs, since all the PCI resources are 
exported there; you can mmap them and do simple programming that way.

As for the idea of userland drivers in general, I'm not sure I like it.  I'm 
afraid it will just encourage more undebuggable, x86 binary blobs (or big 
source code blobs with their own bridge drivers like X) that people are 
forced to run to get their hardware to work...

Jesse
