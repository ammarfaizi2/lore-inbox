Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVB1Xv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVB1Xv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVB1Xv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:51:58 -0500
Received: from peabody.ximian.com ([130.57.169.10]:28112 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261823AbVB1Xvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:51:55 -0500
Subject: Re: [RFC] PCI bridge driver rewrite
From: Adam Belay <abelay@novell.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050224100332.A26582@flint.arm.linux.org.uk>
References: <1109226122.28403.44.camel@localhost.localdomain>
	 <20050224100332.A26582@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 18:50:38 -0500
Message-Id: <1109634638.28403.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 10:03 +0000, Russell King wrote:
> On Thu, Feb 24, 2005 at 01:22:01AM -0500, Adam Belay wrote:
> > 5.) write a bridge driver for Cardbus hardware
> 
> We have this already - it's called "yenta".

Yes, I'm aware.  It should read:

5.) adapt the Yenta driver to the new PCI bus class

:)

> 
> What you need to be aware of is that cardbus hardware is special - it
> may change its resource requirements at any time, both in terms of the
> number of BUS IDs it wishes to consume, and the number and size of
> IO and memory resources.

We can have default sizes allocated for these windows.  Maybe, we'll
even have rebalancing at some point.

As for BUS IDs, I'm not sure about the best behavior.  I don't really
like reserving 4 positions like we do now.  It has a tendency to create
conflicts, and seems to be unnecessary.  How common are PCI bridge
devices that attach to cardbus controllers?  Does the BIOS ever
preconfigure the cardbus bridge for this situation?  I think it's
important that we get bus numbering correct.  Some hardware has problems
now.

> 
> Note also that if a cardbus bridge isn't on the root bus (it happens on
> some laptops) these resource changes may impact on upstream bridges and
> devices.
> 

Yeah, also legacy resources can't pass through properly if the parent
bridge isn't transparent.  Complex bus topologies make the problem much
more difficult when legacy hardware is involved.

Thanks,
Adam


