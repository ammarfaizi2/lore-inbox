Return-Path: <linux-kernel-owner+w=401wt.eu-S1755419AbXABVR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbXABVR6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755420AbXABVR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:17:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59293 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755419AbXABVR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:17:57 -0500
Date: Tue, 2 Jan 2007 21:27:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
Message-ID: <20070102212701.4b4535cf@localhost.localdomain>
In-Reply-To: <459AC808.1030807@pobox.com>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	<459973F6.2090201@pobox.com>
	<20070102115834.1e7644b2@localhost.localdomain>
	<459AC808.1030807@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a silly complaint because the SFF layer in libata doesn't handle
> > this case yet anyway.
> 
> Yes, it's "silly" people people use configurations you find inconvenient.
> 
> At least one embedded x86 case cares, that I know of.  They only needed 
> to make two minor changes to make it work.

*It is not part of 2.6.20*

> The code no long reserves resources for the "extra" PCI BAR that often 
> exists on PCI controllers regardless of legacy/native mode.  Previously, 
> the code called pci_request_regions() to reserve ALL regions attached to 
> the PCI device.

We use BAR5 on two devices in legacy mode. Both of those reserve all the
other resources. We can fix BAR5 in .21 when all the combined mode crap
goes away.

> You have suddenly decided that it's OK to --not reserve at all-- these 
> additional regions.

It's not ideal - but it is perfectly sufficient for 2.6.20

> Proof:  The AHCI PCI BAR (#5, zero-based) is clearly NOT reserved, even 
> though we talk to it, in piix_disable_ahci() of ata_piix.c.

We always claim the other BARs so catch a collision.

Alan
