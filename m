Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUHNJrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUHNJrG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 05:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUHNJrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 05:47:06 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:14976 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S263743AbUHNJrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 05:47:02 -0400
Date: Sat, 14 Aug 2004 11:47:00 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040814094700.GA662@ucw.cz>
References: <20040813181725.GD5685@ucw.cz> <20040814053449.35464.qmail@web14928.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814053449.35464.qmail@web14928.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I removed the call to pci_assign_resource(). The sysfs attribute code
> builds the attributes before the pci subsystem is fully initialized.
> specifically before arch pcibios_init() has been called. If
> pci_assign_resource() is called for the ROM before pcibios_init() the
> kernel's resource maps have not been built yet. This will result in the
> ROM being assigned a location on top of the framebuffer; as soon as it
> is enabled the system will lock. Right now the code relies on the BIOS
> getting the ROM address set up right. If we can figure out how to
> initialize the sysfs attributes after pcibios_init() then I can put the
> assign call back.

If I understand correctly, you don't need that. Just don't map the ROM
before somebody explicitly requests it -- be it either some driver
or sysfs. In both cases, the PCI subsystem is already initialized.

> I think the decoder sharing problem is being blown out of proportion
> there are very few boards with this problem.

Yes, but it's no excuse for writing code which triggers these problems
if there is an easy way how to do that more safely.

> Also, one card I have has a 256MB PCI window over a 48KB ROM. If I use
> the window size instead of true size for a copy I would waste a lot of
> memory.

BTW, if the card doesn't share decoders, is there any need to create
a copy of the ROM? If not, no memory gets wasted.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
How an engineer writes a program: Start by debugging an empty file...
