Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVHBVSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVHBVSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVHBVPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:15:23 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:15853 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261810AbVHBVOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:14:06 -0400
Date: Wed, 3 Aug 2005 01:13:37 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>,
       Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050803011337.A18001@jurassic.park.msu.ru>
References: <Pine.LNX.4.58.0507311125360.29650@g5.osdl.org> <1122846072.17880.43.camel@deep-space-9.dsnet> <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org> <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain> <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru> <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org> <20050802205023.B16660@jurassic.park.msu.ru> <Pine.LNX.4.58.0508021002300.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0508021002300.3341@g5.osdl.org>; from torvalds@osdl.org on Tue, Aug 02, 2005 at 10:11:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 10:11:40AM -0700, Linus Torvalds wrote:
> So I think it would be much easier to just make the change in
> "pci_bus_alloc_resource()", and say that if the parent resource that we're
> testing starts at some non-zero value, we just use that instead of "min"  
> when we call down to allocate_resource(). That gets it for MEM resources 
> too.

Cool! I think it's the way to go.

> Something like the following (also _totally_ untested, but even simpler 
> than yours). It basically says: if the parent resource starts at non-zero, 
> we use that as the starting point for allocations, otherwise the passed-in 
> value.

Tested on alpha. Initially I was concerned a bit about architectures
where resources _never_ start at zero (due to some specific bus to
resource conversions), but this change is just a no-op for them.

> That, together with changing PCIBIOS_MIN_IO to 0x2000 (or even 0x4000)  
> might be the ticket...

Definitely 0x4000. Then we can get rid of PCIBIOS_MIN_CARDBUS_IO which
was introduced exactly for this reason, I guess.

Ivan.
