Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWBJTwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWBJTwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWBJTwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:52:06 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:37045 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1751360AbWBJTwE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:52:04 -0500
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
Reply-To: bernd-schubert@gmx.de
To: Andrew Morton <akpm@osdl.org>
Subject: Re: a couple of oopses with 2.6.14
Date: Fri, 10 Feb 2006 20:51:49 +0100
User-Agent: KMail/1.7.2
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <200602091934.20732.bernd.schubert@pci.uni-heidelberg.de> <200602101924.45467.bernd.schubert@pci.uni-heidelberg.de> <20060210112958.025a7bfb.akpm@osdl.org>
In-Reply-To: <20060210112958.025a7bfb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602102051.50886.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 20:29, Andrew Morton wrote:
> Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de> wrote:
> > > Can you test 2.6.15?
> >
> > Yes, 2.6.15.3 works, no oopses.
>
> Some progress.
>
> > Only this information
> >
> > [4294743.341000] scsi0 : ata_piix
> > [4294743.514000] ATA: abnormal status 0x7F on port 0xE407
> >
> > I can't test if sata works, there's just nothing connected.
>
> Has this machine's sata support ever worked?  If so, in which kernel?
> (Apologies if you've already described this).

Don't know, there was never anything connected to the sata ports. It was also 
just an accident that sata was compiled statically into the kernel.
Though, with 2.6.11 we don't get the warnings:

libata version 1.10 loaded.
ata_piix version 1.03
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 18
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 18
ata1: SATA port has no device.
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
ieee1394: Initialized config rom entry `ip1394'


>
> > Btw, the printk timing information seem to be uninitalized, is this by
> > intentention or is it a bug?
>
> It's expected.  We use a very raw, low-level funtion for the printk
> timestamping because we don't want to be taking locks from within printk.
> The timestamping is mainly for working out the time duration between
> printk's, rather than for absolute time.

Ah, I see.

Thanks,
	Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
