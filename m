Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUCWCoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUCWCoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:44:21 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:5048 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262134AbUCWCoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:44:14 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Issues with /proc/bus/pci
Date: Mon, 22 Mar 2004 18:44:09 -0800
User-Agent: KMail/1.6.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1080007613.22212.61.camel@gaston>
In-Reply-To: <1080007613.22212.61.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403221844.09663.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 March 2004 6:06 pm, Benjamin Herrenschmidt wrote:
> case with the HyperTransport host on the G5, though I could fix
> that in the long term, I suspect it may happen again elsewhere
> as they aren't required to show up as devices).

The same thing happens on Altix machines, our xio<->pci bridges don't show up.

> What do you think of dealing with that with a slight addition to
> the current ioctl's, basically adding a pair equivalent to
> PCIIOC_MMAP_IS_IO and PCIIOC_MMAP_IS_MEM that would be
> PCIIOC_MMAP_IS_HOST_IO and PCIIOC_MMAP_IS_HOST_MEM ? That would
> be, imho, the simplest solution, as far as userland is concerned,
> though it requires updating the implementation of pci_mmap_page_range()
> of all archs that implement it.

It's been awhile since I looked at this API, but this would allow userland to 
map legacy I/O or mem space for a given device using the above commands?

> Another simpler solution would be to consider that mapping outside
> of a device is only ever useful for legacy ISA IO space and simply
> fix the archs to allow an IO mapping of the IO region below 0x400
> using any device pci_dev (provided the region exist on a given host
> of course), since the value passed by userland is an absolute BAR
> address in bus space, that would work.

This would also work, but then on some platforms (like ia64) legacy space 
requires special treatment since target aborts can cause hard fails, so I'd 
prefer the previous approach since it would make setup for dealing with such 
platforms a bit more explicit.

Thanks,
Jesse
