Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUHaRYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUHaRYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUHaRPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:15:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:56968 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268754AbUHaROy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:14:54 -0400
Subject: Re: Driver retries disk errors.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <20040831170016.GF17261@harddisk-recovery.com>
References: <20040830163931.GA4295@bitwizard.nl>
	 <1093952715.32684.12.camel@localhost.localdomain>
	 <20040831135403.GB2854@bitwizard.nl>
	 <1093961570.597.2.camel@localhost.localdomain>
	 <20040831155653.GD17261@harddisk-recovery.com>
	 <1093965233.599.8.camel@localhost.localdomain>
	 <20040831170016.GF17261@harddisk-recovery.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093968767.597.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 17:12:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 18:00, Erik Mouw wrote:
> > For non hard disk cases many devices do want and need retry.
> 
> And many others do not. CompactFlash readers are usually implemented as
> a USB storage device, which on its turn is implemented as a SCSI
> "disk". So far I haven't seen a CompactFlash which could be "fixed" by
> retries.

It does no harm trying. It does real harm not being conservative and
losing peoples data. You recover people's data after its lost, the
IDE layer's job is to make sure it doesn't get lost in the first place.

> (1) Imagine an application doing a linear read on a file with an 8
> block read ahead and the last block being bad. The kernel will try to
> read that bad block 16 times, but because the IDE driver also has 8
> retries, the kernel will try to read that bad block *64* times. It
> usually takes an IDE drive about 2 seconds to figure out a block is
> bad, so the application gets stuck for 2 minutes in that single bad
> block.

Right now I know of no way to tell which is readahead for a failed
command or of telling the block layer to forget them. Fix this at the
block layer and IDE can abort the readahead sequence happily enough
because IDE is too dumb to have issued further commands to the drive at
this point.

Alan

