Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbULPQ1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbULPQ1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbULPQ1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:27:15 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:36575 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261183AbULPQ05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:26:57 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add legacy I/O and memory access routines to /proc/bus/pci API
Date: Thu, 16 Dec 2004 08:26:31 -0800
User-Agent: KMail/1.7.1
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200412140941.56116.jbarnes@engr.sgi.com> <200412150900.18890.jbarnes@engr.sgi.com> <1103208922.25262.10.camel@gaston>
In-Reply-To: <1103208922.25262.10.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412160826.32315.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 16, 2004 6:55 am, Benjamin Herrenschmidt wrote:
> On Wed, 2004-12-15 at 09:00 -0800, Jesse Barnes wrote:
> > Good, because that's exactly what it does.  The arch is responsible for
> > returning the legacy I/O port or legacy ISA memory base address given a
> > pci_dev, which is used as a base for the page offset passed into mmap. 
> > So e.g. mmap(..., 0xa0000) after doing ioctl(fd,
> > PCIIOC_MMAP_IS_LEGACY_MEM, ...) would get you the VGA framebuffer for the
> > device corresponding to 'fd'.
>
> Sounds good... The only thing is a pci_dev may not be available if you
> have a PCI->ISA bridge, tho you may just use the pci_dev of the
> bridge...

Well, you'll have to have a fake one at least.  Remember the fds used in the 
above example come from fd = open("/proc/bus/pci/BB/SS.F", O_RDWR)...

Jesse
