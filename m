Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbUKVExc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUKVExc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUKVExc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 23:53:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:61861 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261924AbUKVEx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 23:53:29 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1101098057.4589.2.camel@mhcln03>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03>
	 <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
	 <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
	 <1100921760.3561.1.camel@mhcln03>  <1100936059.5238.3.camel@gaston>
	 <1100937706.3497.11.camel@mhcln03>  <1100989638.3796.9.camel@gaston>
	 <1101027009.4052.11.camel@mhcln03>  <1101073197.3796.72.camel@gaston>
	 <1101098057.4589.2.camel@mhcln03>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 15:52:20 +1100
Message-Id: <1101099140.13598.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 05:34 +0100, Matthias Hentges wrote:
> Am Montag, den 22.11.2004, 08:39 +1100 schrieb Benjamin Herrenschmidt:
> 
> > That "update only what changed" makes little sense
> 
> Sorry, I was merely stating my observations.
> 
> >  ... can you send me
> > the lspci state of the Intel bridge before you try to resume it ? I
> > suspect our pci_restore_state() should be smarter, that is check if
> > something changed (a BAR), if yes, switch mem/io off, restore the BARs,
> > then switch mem/io back on...
> 
> Attached.

Ok, it's clearly visible that your CPU->AGP bridge isn't properly
restored. I can't tell if the "default" resume code is enough tho, but
it's fairly probably that this isn't the only problem, and that the
video chip itself isn't restored neither...

I don't think the default resume code is to blame here, though the CPU
to AGP bridge may need some special restore code restoring more than
just it's config space (very probable even). I suspect there is some
ACPI trickery here that should be happening and isn't but my knowledge
of ACPI isn't that great.

Once the config space is resumed, I suppose doing a soft-boot of the
card with the BIOS would work, but then, that means preventing anything
from actually touching the video card until that happens... 

Ben.

