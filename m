Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTESVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTESVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:13:26 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:32013 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263023AbTESVNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:13:24 -0400
Date: Mon, 19 May 2003 23:33:12 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SIS-650+CPQ Presario 3045US+USB ...
In-Reply-To: <Pine.LNX.4.55.0305181533280.3568@bigblue.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0305190153290.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Davide Libenzi wrote:

> > Well, "lspci -vxxx -d 1039:0008" should be sufficient. If possible
> > combined with the pci routing table (from dump_pirq for example).
> 
> I know, but even that one is hard to do w/out the machine under your nose ;)

Sure ;-)

> > Ok, looks like they have moved the location of the PCI INTA-INTD routing
> > registers from 0x41-0x44 to 0x60-0x63. Since this works for you it means
> > the vendor/device-id is still 1039:0008. We really need to check the
> > revision id here.
> 
> Nope, I still see 0x4* commands for all devices != from USB. So more then
> a "move" is an extension.

Ok, second guess: they've kept the 0x41-44 for INTA-INTD and just added 
the several onboard USB root-HC's at 0x6* - which might also explain if 
you need bit 6 set. Well, it seems we'd really need the docs.

> > So, for your patch I'd suggest to check the PCI_REVISION_ID from the
> > config space and apply your new layout for this revision only.
> 
> Instead of just trolling, isn't there a documentation about this chipset ?
> The SIS web site is pretty/very weak about docs.

Well, trolling or not, when I submitted the current sis pci irq routing 
stuff it was based on existing documentation for the 85C503 isa-bridge 
with pci router function (as used in the 5595 chipset).

We were also looking at a number of routing tables from different people 
to get the stuff right - given the different ideas vendors have about link 
values. IIRC it was around 2.4.0 release and we also had some confirmation 
from somebody at SiS before Linus applied it.

I've no idea about docs for the 650 chipset, sorry.

Martin

