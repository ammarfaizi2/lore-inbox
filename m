Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbUKUVkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUKUVkq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUKUVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:40:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:42146 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261815AbUKUVkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:40:40 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1101027009.4052.11.camel@mhcln03>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03>
	 <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
	 <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
	 <1100921760.3561.1.camel@mhcln03>  <1100936059.5238.3.camel@gaston>
	 <1100937706.3497.11.camel@mhcln03>  <1100989638.3796.9.camel@gaston>
	 <1101027009.4052.11.camel@mhcln03>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 08:39:57 +1100
Message-Id: <1101073197.3796.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I did some more tests today and found out that 
> "0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP
> Controller (rev 21) (prog-if 00 [Normal decode])"
> 
> wasn't correctly resumed either.
> 
> I wrote a script to dump the pci data (from lspci -x $device). Importing
> the data after a resume freezes the machine *if one is touching data
> that hasn't been changed during S3*. If I only change the values which
> were modified after resume, the machine does *not* freeze.
> 
> Maybe that's the problem with pci_default_resume. It looks like it is
> just writing back the data it has stored before resuming. Maybe one
> should only write the values which have actually changed?
> 
> Anyways, using my little script, i managed to restore the PCI data of
> the "Processor to AGP Controller" and the Radeon card after a resume.

That "update only what changed" makes little sense ... can you send me
the lspci state of the Intel bridge before you try to resume it ? I
suspect our pci_restore_state() should be smarter, that is check if
something changed (a BAR), if yes, switch mem/io off, restore the BARs,
then switch mem/io back on...

Ben.


