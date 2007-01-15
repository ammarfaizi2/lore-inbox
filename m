Return-Path: <linux-kernel-owner+w=401wt.eu-S1751440AbXAOUIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbXAOUIg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 15:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbXAOUIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 15:08:36 -0500
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:47065 "EHLO
	south-station-annex.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751440AbXAOUIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 15:08:35 -0500
X-Greylist: delayed 728 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 15:08:29 EST
Subject: Re: allocation failed: out of vmalloc space error treating and  
	VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
From: David Moore <dcm@MIT.EDU>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bill Davidsen <davidsen@tmr.com>, theSeinfeld@users.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       libdc1394-devel@lists.sourceforge.net
In-Reply-To: <1168885223.3122.304.camel@laptopd505.fenrus.org>
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
	 <200701100023.39964.theSeinfeld@users.sf.net>
	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
	 <1168802934.3123.1062.camel@laptopd505.fenrus.org> <45ABC1A2.90109@tmr.com>
	 <1168885223.3122.304.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 14:54:40 -0500
Message-Id: <1168890881.10136.29.camel@pisces.mit.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.599
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 10:20 -0800, Arjan van de Ven wrote:
> if you need that much you probably should redesign your algorithms to
> not need vmalloc in the first place....

I think you've convinced me that vmalloc is not a good choice when a
driver needs a large buffer (many megabytes) for DMA.

In this case, we need a large ring buffer for reception of isochronous
packets from a firewire device.  If I understand you correctly, you are
suggesting that this buffer be obtained as followed:

1. Application performs malloc() in user-space and mmap()s it.
2. Driver uses vmalloc_to_page() on every page of the malloc'ed memory
and constructs a scatter-gather list.
3. Map the sg list with pci_map_sg().
4. Commence DMA.

Is that correct?  In particular, does it do the right thing in terms of
pinning the memory and dealing with high memory?

I notice that the block I/O API has some convenience functions for this,
but this is not a block device.  Are there some other convenience
functions that can be used?

Forgive me if these are obvious questions -- I'm not the developer of
video1394, but I'd still like get it right for the new firewire stack
that's being developed.

Thanks,

David

