Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268676AbUHLTed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268676AbUHLTed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268678AbUHLTed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:34:33 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:62436 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268676AbUHLTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:34:30 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nathan Bryant <nbryant@optonline.net>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040812191120.GA14903@elf.ucw.cz>
References: <4119611D.60401@optonline.net>
	<20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net>
	<1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston>
	<1092314892.1755.5.camel@mulgrave> <20040812131457.GB1086@elf.ucw.cz>
	<1092328173.2184.15.camel@mulgrave>  <20040812191120.GA14903@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Aug 2004 15:34:02 -0400
Message-Id: <1092339247.1755.36.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 15:11, Pavel Machek wrote:
> Ok, but what happens on next resume? If coherent mbox is at exactly
> same place at every boot I guess it could even work, but...

Er, well this is a huge problem then.  Even if DMA were stopped, the
registers for all these locations need to be altered to change the
location of the DMA mboxes.  This isn't just a SCSI problem, it's a
general device problem (most devices having mboxes programmed by
register).  If we can't rely on the resuming kernel setting up these
registers for us to exactly what they were in the resume image, then
we're in a bit of trouble.

Architecturally what you are trying to do is to re POST the SCSI card. 
Except it's the kernel's job to POST it, so the kernel init code needs
to be re-run.  I assume that's what the pci suspend/resume calls are
supposed to do?

James


