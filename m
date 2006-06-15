Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWFOGsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWFOGsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWFOGsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:48:15 -0400
Received: from fmr17.intel.com ([134.134.136.16]:56986 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750707AbWFOGsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:48:15 -0400
Message-ID: <4491029D.4060002@linux.intel.com>
Date: Wed, 14 Jun 2006 23:47:57 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Brice Goglin <brice@myri.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because
 of e820
References: <44907A8E.1080308@myri.com> <44907B13.2030402@linux.intel.com> <4490BE76.6040008@myri.com>
In-Reply-To: <4490BE76.6040008@myri.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Well, we are talking about using a different method to access the
> extended config space only. This space is independent from the legacy
> config space.

not really. In many ways it's the same space.

> I don't see how mixing the old and new methods like this could lead to
> any problem, we are not going to mix them to access the same registers.

the spec simply doesn't allow it. Sure it may work on your machine today,
but that doesn't make it a good idea ;)

> We need to improve this "mmconfig disabled" anyhow. Having the extended
> config space unavailable on lots of machines is also far from a viable
> solution :)

it's unlikely to be many machines though.

  If you still do not like this first proposal, what do you
> think of my other one ? (having chipset-specific checks in
> pci_mmcfg_init to find out for sure whether mmconfig will work)

I'm all in favor of a more detailed test; just we HAVE to have a test
for this since it's simply broken too often. What the test needs to do
is check if the MCFG entry actually points to a working mmconfig area,
so 1) that it actually points to an mmconfig area and not to garbage, and 2)
that accesses to it actually work ;)

the current approach doesn't test 2) realistically, only 1), but if you weaken
the 1) test as you propose you really ought to substitute it with a 2) test...

