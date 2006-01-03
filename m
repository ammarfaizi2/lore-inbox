Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWACMWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWACMWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 07:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWACMWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 07:22:00 -0500
Received: from alg145.algor.co.uk ([62.254.210.145]:21255 "EHLO
	dmz.algor.co.uk") by vger.kernel.org with ESMTP id S1751388AbWACMV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 07:21:59 -0500
Date: Tue, 3 Jan 2006 12:21:34 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: {SPAM?} unable to mount root device in 2.6.14.5 (was: Re: [PATCH]
 PCI patches for 2.6.10)
In-Reply-To: <20060102182018.GA25971@ds20.borg.net>
Message-ID: <Pine.LNX.4.61.0601031214160.21127@perivale.mips.com>
References: <20060102182018.GA25971@ds20.borg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.1,
	required 4, AWL, BAYES_00, IPADDR)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2006, Thorsten Kranzkowski wrote:

> I just upgraded from Kernel 2.6.10 to 2.6.14.5 and got this message:
> 
> PCI: Unable to reserve I/O region #1:100@10000 for device 0000:00:06.0
> 
> instead of the usual initialisation messages of my scsi controller. As
> a consequence no scsi device and thus no root device is found. 
> I tracked this down to this patch (to be precise, the PCI_CLASS_NOT_DEFINED 
> part of it). Removing the 'class == PCI_CLASS_NOT_DEFINED ||' clause makes
> it boot again.

 You need to add a quirk for the device to initialize its class to be a 
SCSI controller.

> This is a DEC alpha AXPpci33 (aka 'noname') board with an sym810 onboard scsi-
> controller:
> 
> [Marvin:~#] lspci -v
> 00:06.0 Non-VGA unclassified device: Symbios Logic Inc. (formerly NCR) 53c810 (rev 01)
>         Flags: bus master, medium devsel, latency 255, IRQ 11
>         I/O ports at 8000 [size=256]
>         Memory at 0000000001230000 (32-bit, non-prefetchable) [size=256]

 Use the vendor/device ID of this device as the key.

> Your patch description suggests that a platform specific solution might be
> better. So can you point me tho the right place under arch/alpha to implement
> this? Or would a patch to remove the comparison be acceptable?

 Well, it's a generic SCSI chip apparently, so the quirk should be placed 
in generic code.  There are quirks for such devices provided here and 
there already -- use them as references.

  Maciej
