Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966643AbWKOE4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966643AbWKOE4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966642AbWKOE4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:56:08 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:20961 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966643AbWKOE4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:56:07 -0500
Message-ID: <455A9DE2.8080908@garzik.org>
Date: Tue, 14 Nov 2006 23:56:02 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>	<20061114.190036.30187059.davem@davemloft.net>	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>	<20061114.192117.112621278.davem@davemloft.net>	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>	<455A938A.4060002@garzik.org> <ada8xidz5zn.fsf@cisco.com>
In-Reply-To: <ada8xidz5zn.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > That reminds me of a potential driver bug -- MSI-aware drivers need to
>  > call pci_intx(pdev,0) to turn off the legacy PCI interrupt, before
>  > enabling MSI interrupts.
> 
> Huh?  The device can't generate any legacy interrupts once MSI is
> enabled.  As the PCI spec says:
> 
>     "While enabled for MSI or MSI-X operation, a function is prohibited
>     from using its INTx# pin (if implemented) to request service (MSI,
>     MSI-X, and INTx# are mutually exclusive)."
> 
> Although the MSI core does do pci_intx() for PCIe devices only, for
> some reason I can't grok.

Probably the same reason I just mentioned in a reply to DaveM.  Wildly 
speculating, some chips may depend on software to disable INTX -- i.e. 
depend on software to provide this aspect of PCI spec compliance.


>  > The only thing that has changed recently is that people are trying to
>  > get it working on AMD/NV as well.  (Brice Goglin's stuff starting at
>  > 6397c75cbc4d7dbc3d07278b57c82a47dafb21b5 in 'git log')
> 
> Actually NVidia/AMD was working on some systems long before that -- I
> had it working at least 2 years ago.

Well, just noting that AMD/NV seems to be a common pattern in the 
referenced bug reports, and the set of Linux platforms which claim to 
support MSI had recent churn.

	Jeff


