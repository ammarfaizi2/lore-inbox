Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRDPWgj>; Mon, 16 Apr 2001 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132373AbRDPWga>; Mon, 16 Apr 2001 18:36:30 -0400
Received: from albireo.ucw.cz ([62.168.0.14]:2052 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S132372AbRDPWgU>;
	Mon, 16 Apr 2001 18:36:20 -0400
Date: Tue, 17 Apr 2001 00:35:58 +0200
From: Martin Mares <mj@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.4.3: pci_enable/disable_device stuff
Message-ID: <20010417003558.B270@albireo.ucw.cz>
In-Reply-To: <3AD962D3.2E6E6DC1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD962D3.2E6E6DC1@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Apr 15, 2001 at 04:58:59AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The attached patch does two things:
> 
> 1) Take PCI devices to D0 state before enabling them.  We both think
> this is the right thing to do, but there is always the crazy chance this
> change will break something.  So, think twice before applying, but IMHO
> apply :)

I'm not able to cite the PCI PM specs by heart :) ... but looks OK to me.

> 2) Adds pci_disable_device.  Right now is just disables busmastering. 
> When suspending devices, the last task that should occur is to disable
> busmastering, before ceding control to ACPI.  Also its a good idea in
> general to disable busmastering when its not in use; it's friendlier to
> the bus.

OK.

> When unloading drivers too, we should be more "green" about
> disabling devices.

Yes, but not before we're sure we can wake them up correctly. Probably
also needs to handle wakeup of PCI-to-PCI bridges.

> I wonder if we should disable IO and MEM decoding too, and I also like
> to ack PCI_STATUS.  I didn't add those things because I'm not yet sure
> we want to do that unconditionally.

I'd rather prefer to avoid this. It brings nothing except for possible
problems.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
Compatible: Gracefully accepts erroneous data from any source.
