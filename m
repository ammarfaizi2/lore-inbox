Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265503AbRGBXy6>; Mon, 2 Jul 2001 19:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265509AbRGBXyt>; Mon, 2 Jul 2001 19:54:49 -0400
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:62084 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265503AbRGBXyn>; Mon, 2 Jul 2001 19:54:43 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] I/O Access Abstractions
Date: Tue, 3 Jul 2001 01:54:47 +0200
Message-Id: <20010702235447.1201@smtp.wanadoo.fr>
In-Reply-To: <E15HByZ-0006hZ-00@the-village.bc.nu>
In-Reply-To: <E15HByZ-0006hZ-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Can you give me an idea of what sort of cookie decoding a PPC/PMac would need
>and why - Im working off things like pa-risc so I dont have a full picture.

Each domain provide an IO space (size depends on the bridge, recent Apple
UniNorth hosts have 16Mb per domain). 

That IO space can be in any location (depends on the box, bridge config,
..), so basically, we must assume that each host bridge can have it's IO
space anywhere in CPU mem space.

Currently, we store the physical address of those in our pci_controller
structure, and ioremap all of them. One is picked up as the "ISA" io base
(for VGA and such things as legacy devices on non-pmac PPCs). That
isa_io_base is used as an offset to inx/outx, and all PCI IO_RESOURCES
are fixed up to be their real virtual address offset'ed with isa_io_base.
(A bit weird but works and we have only an addition in inx/outx).

I'm more concerned about having all that space mapped permanently in
kernel virtual space. I'd prefer mapping on-demand, and that would
require a specific ioremap for IOs.

Ben.




