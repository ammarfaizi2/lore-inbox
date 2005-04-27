Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVD0EbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVD0EbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 00:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVD0EbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 00:31:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:23507 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261908AbVD0EbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 00:31:03 -0400
Subject: Re: pci-sysfs resource mmap broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com
In-Reply-To: <20050427035535.GI2612@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
	 <20050427035535.GI2612@colo.lackof.org>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 14:30:21 +1000
Message-Id: <1114576221.7182.140.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 21:55 -0600, Grant Grundler wrote:
> On Wed, Apr 27, 2005 at 08:47:34AM +1000, Benjamin Herrenschmidt wrote:
> > No. I don't agree. userspace has no business understanding the kernel
> > resources content.
> 
> Sorry - you are right. Userspace doesn't need to understand kernel
> resources. It just needs some sort of handle so it can talk
> to the device in whatever way is appropriate. I was thinking
> the resource content (which happens to be CPU View of a BAR)
> could be that handle.

Ok, we are crossing each other here, I was about to reply that you were
indeed right :) Anyway, I'm about to post another message explaining all
that I think I found and my proposed fix for ppc. Should be up as soon
as I have finished testing the patch.

> ...
> > The only thing I dislike a bit is that forces me to read the BAR on
> > every access to "un-offset" the kernel resource. We may be able to have
> > some arch hook do that properly, but for now, that would fix the problem
> > and make the whole stuff work again.
> 
> 
> What is wrong with reading the BAR?
> Is the "IO View" needed in the performance path someplace?
> 
> It should be trivial since config space is exported via /sys and /proc.
> libpci probably already has everything that's needed.

True, but then, I tend to prefer you idea of a CPU view ... so my new
"proposal" is something like pci_resource_to_user() implementation.
Anyway, wait a bit so I can polish this patch and tell me what you
think :)

Ben.


