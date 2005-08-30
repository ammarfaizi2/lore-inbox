Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVH3Gsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVH3Gsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 02:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVH3Gsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 02:48:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:34775 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750998AbVH3Gsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 02:48:38 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: jonsmirl@gmail.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       helgehaf@aitel.hist.no, torvalds@osdl.org
In-Reply-To: <20050829.223238.18109086.davem@davemloft.net>
References: <200508261859.j7QIxT0I016917@hera.kernel.org>
	 <1125369485.11949.27.camel@gaston>
	 <9e47339105082921356543098c@mail.gmail.com>
	 <20050829.223238.18109086.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 16:43:46 +1000
Message-Id: <1125384226.11949.70.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 22:32 -0700, David S. Miller wrote:
> From: Jon Smirl <jonsmirl@gmail.com>
> Date: Tue, 30 Aug 2005 00:35:11 -0400
> 
> > As far as I can tell no one has built recent hardware this way. But I
> > believe there are some old SCSI controllers that do this. I provided a
> > ROM API for disabling sysfs access, if we identify one of these cards
> > we should just add a call to it's driver to disable ROM access instead
> > of bothering with the copy. Currently the copy is not being used
> > anywhere in the kernel.
> 
> Qlogic ISP is one such card, but there are several others.
> 
> I think enabling the ROM is a very bad idea, since we in fact
> know it disables the I/O and MEM space decoders on a non-empty
> set of PCI cards.

This is why pci_map_rom is under driver control. There is still a
potential issue with userland using the "rom" file in sysfs, which is
why we probably should cleanup the pci_map_rom_copy to have the kernel
read the ROM once & backstore it upon request from the driver so that
further userland accesses will not toggle the real ROM enable.

Ben.


