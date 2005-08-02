Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVHBV1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVHBV1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVHBVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:22:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:22920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261866AbVHBVWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:22:15 -0400
Date: Tue, 2 Aug 2005 14:21:44 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Manuel Lauss <mano@roarinelk.homelinux.net>,
       Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050802212143.GA8738@kroah.com>
References: <1122846072.17880.43.camel@deep-space-9.dsnet> <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org> <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain> <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru> <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org> <20050802205023.B16660@jurassic.park.msu.ru> <Pine.LNX.4.58.0508021002300.3341@g5.osdl.org> <20050803011337.A18001@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803011337.A18001@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 01:13:37AM +0400, Ivan Kokshaysky wrote:
> On Tue, Aug 02, 2005 at 10:11:40AM -0700, Linus Torvalds wrote:
> > So I think it would be much easier to just make the change in
> > "pci_bus_alloc_resource()", and say that if the parent resource that we're
> > testing starts at some non-zero value, we just use that instead of "min"  
> > when we call down to allocate_resource(). That gets it for MEM resources 
> > too.
> 
> Cool! I think it's the way to go.
> 
> > Something like the following (also _totally_ untested, but even simpler 
> > than yours). It basically says: if the parent resource starts at non-zero, 
> > we use that as the starting point for allocations, otherwise the passed-in 
> > value.
> 
> Tested on alpha. Initially I was concerned a bit about architectures
> where resources _never_ start at zero (due to some specific bus to
> resource conversions), but this change is just a no-op for them.
> 
> > That, together with changing PCIBIOS_MIN_IO to 0x2000 (or even 0x4000)  
> > might be the ticket...
> 
> Definitely 0x4000. Then we can get rid of PCIBIOS_MIN_CARDBUS_IO which
> was introduced exactly for this reason, I guess.

Nice, care to make up a single patch with these two changes in it?

thanks,

greg k-h
