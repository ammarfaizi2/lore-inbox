Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136707AbREAUaX>; Tue, 1 May 2001 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136712AbREAUaM>; Tue, 1 May 2001 16:30:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41227 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136707AbREAUaC>; Tue, 1 May 2001 16:30:02 -0400
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 1 May 2001 21:32:41 +0100 (BST)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        jlundell@pobox.com (Jonathan Lundell), linux-kernel@vger.kernel.org
In-Reply-To: <200105011653.f41Grwm12595@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at May 01, 2001 10:53:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ugpA-0002J3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm wary of this, because Linus has stated that the current "struct
> pci_dev" is really meant to be a generic thing, and it might change to
> "struct dev" (now that we've renamed the old "struct dev" to "struct
> netdev").

It is already being (ab)used this way. Its an isa pnp device in 2.4.*. Its
also a bios pnp device in 2.4-ac

> However, it's my understanding that Linus isn't trying to push
> existing drivers, which work well with devfs, into implementing their
> own FS. He just wants the option left open for new drivers where a
> driver-specific FS makes more sense.

Having thought over the issues I plan to maintain a 32bit dev_t kernel with
conventional mknod behaviour, even if Linus won't. One very interesting item
that Peter Anvin noted is that its not clear in POSIX that

	mknod /dev/ttyF00 c 100 100

	open("/dev/ttyF00/speed=9600,clocal");

is illegal. That may be a nice way to get much of the desired behaviour without
totally breaking compatibility

