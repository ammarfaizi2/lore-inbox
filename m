Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVCWNxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVCWNxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVCWNxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:53:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21222 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262522AbVCWNtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:49:17 -0500
Date: Wed, 23 Mar 2005 13:49:11 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha build fixes
Message-ID: <20050323134911.GI21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[I'm not subscribed, please excuse the thread-breaking]

Alan Cox wrote:
> > +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > +{
> > + return channel ? 15 : 14;
> > +}
> 
> The issue is bigger - it's needed for the CMD controllers on PA-RISC for
> example it appears - and anything else where IDE legacy IRQ is wired
> oddly.

The built-in IDE controller on the Astro/Elroy based PA-RISC workstations
(B1000, C3000, J5000 and similar) is part of a NS87560 chip.  By default
(and we don't currently touch this), we route the internal interrupts
to Linux interrupts 14 and 15.  We could change that, but I don't currently
see a need to, since we're "the same as x86".  It uses the ns87415 driver.

I don't know what the situation is with the zx1-based boxes, currently only
the C8000.  If it's the same as the ia64 zx1 boxes, it'll have a CMD 649.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
