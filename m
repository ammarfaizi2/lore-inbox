Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWFUHiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWFUHiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 03:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWFUHit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 03:38:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:37017 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932473AbWFUHit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 03:38:49 -0400
Message-ID: <4498F760.6070709@de.ibm.com>
Date: Wed, 21 Jun 2006 09:38:08 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Jes Sorensen <jes@sgi.com>, Robin Holt <holt@sgi.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <20060619224952.GA17685@lnx-holt.americas.sgi.com> <4497AB46.4000402@sgi.com> <200606201003.52307.bjorn.helgaas@hp.com>
In-Reply-To: <200606201003.52307.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> I do have a case where I used pages without struct pages, but
> I don't really like the implementation, and I'd love to have
> someone who knows about VM tell me "no, dummy, you should do it
> this way instead."
> 
> Here's the scenario:  I'm trying to implement
> /sys/class/pci_bus/DDDD:BB/legacy_mem so we can run X servers
> on multiple VGA cards.  The chipset (used in HP parisc and ia64
> boxes) supports multiple PCI root bridges, and it routes the
> VGA legacy MMIO space at 0xA0000-0xBFFFF to one of them.
> 
> This region is MMIO, so there are no struct pages for it.  I can
> easily mmap the space for the first VGA device.  But to support
> a second device, I have to be able to invalidate the mappings
> for the first device, twiddle stuff in the chipset, and make new
> mappings for the second device.  And of course I have to do the
> reverse (invalidate mappings of second device, twiddle chipset,
> map first device) when the first X server faults on the frame
> buffer.
> 
> Basically, only one of the /sys/class/pci_bus/DDDD:BB/legacy_mem
> files can have an active mmap at a time, and I haven't figured
> out a good way to do the mutual exclusion.
Probably you can just nuke the pte's similar to __xip_unmap() in
mm/filemap_xip.c.

cheers,
Carsten

