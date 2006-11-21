Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031276AbWKUScI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031276AbWKUScI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031279AbWKUScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:32:08 -0500
Received: from ns.suse.de ([195.135.220.2]:7376 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031278AbWKUScF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:32:05 -0500
From: Andi Kleen <ak@suse.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
Date: Tue, 21 Nov 2006 19:31:53 +0100
User-Agent: KMail/1.9.5
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Ray Lee <ray-lk@madrabbit.org>,
       linux-kernel@vger.kernel.org
References: <455B63EC.8070704@madrabbit.org> <200611211746.39173.ak@suse.de> <20061121182726.7d31451f@localhost.localdomain>
In-Reply-To: <20061121182726.7d31451f@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211931.53802.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The documentation is correct, the implementation is broken. The
> documented behaviour works for all platforms except one whose maintainer
> has a problem with it and refuses to follow the spec.

The reference is still what i386 does.

> > Possibly, but devices that cannot address at least 4GB are normally
> > categorized as "hardware bugs" (or less polite descriptions) and those don't 
> > tend to get much airtime in documentation.
> 
> The rest of the kernel deals with hardware limitations, 

Yes, but you don't find it normally in the documentation, just
in some very dark corners of the code.

> 30bit DMA works 
> on the other platforms. This is an x86-64 platform problem. It
> misimplements the basic pci_ functionality. 

Well, if you claim that then i386 misimplements it too. 

Normally people don't hit it on 32bit because with the default user/kernel split
the limit is 900MB, which tends to be ok for most hardware. But you
could easily hit it with non standard __PAGE_OFFSET as it is now
possible to configure. 

I claim x86-64 is bug to bug compatible to i386 as far as possible. 
Since that is what drivers are typically written for it's the most
important specification.

> If it doesn't wish to 
> implement the stuff (and there btw Andi I do think your view has
> considerable merit) it should fail the set_mask requests.

If it did like you're recommending a huge number of drivers
in the tree wouldn't work anymore (just think about what pci_alloc_consistent
does) 

I have a long term master plan to merge GFP_DMA and swiotlb
into a single pool -- if that ever happens it might be possible
to fix it properly. But probably most of the drivers who needed
it wouldn't work anyways because they typically tend to forget
enough *_sync calls to make software bounce buffering work.

-Andi
