Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268883AbUHLXRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbUHLXRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUHLXQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:16:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:7150 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268866AbUHLXKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:10:13 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Pavel Machek <pavel@ucw.cz>, Nathan Bryant <nbryant@optonline.net>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1092339247.1755.36.camel@mulgrave>
References: <4119611D.60401@optonline.net>
	 <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net>
	 <1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston>
	 <1092314892.1755.5.camel@mulgrave> <20040812131457.GB1086@elf.ucw.cz>
	 <1092328173.2184.15.camel@mulgrave>  <20040812191120.GA14903@elf.ucw.cz>
	 <1092339247.1755.36.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1092351878.26425.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 09:04:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 05:34, James Bottomley wrote:
> On Thu, 2004-08-12 at 15:11, Pavel Machek wrote:
> > Ok, but what happens on next resume? If coherent mbox is at exactly
> > same place at every boot I guess it could even work, but...
> 
> Er, well this is a huge problem then.  Even if DMA were stopped, the
> registers for all these locations need to be altered to change the
> location of the DMA mboxes.  This isn't just a SCSI problem, it's a
> general device problem (most devices having mboxes programmed by
> register).  If we can't rely on the resuming kernel setting up these
> registers for us to exactly what they were in the resume image, then
> we're in a bit of trouble.

Ugh ? What do you mean ? The suspend kernel will snapshot the kernel
memory at one point, after the device suspend call has been done. If
the device relies on some changes done after that, then it's broken
somewhat.

The resume will restore all memory, not MMIO of course, and it's up
to the driver to do whatever is necessary to restore operations
properly.

> Architecturally what you are trying to do is to re POST the SCSI card. 
> Except it's the kernel's job to POST it, so the kernel init code needs
> to be re-run.  I assume that's what the pci suspend/resume calls are
> supposed to do?

Yes.

The problem is the same with suspend-to-RAM basically.

Ben.


