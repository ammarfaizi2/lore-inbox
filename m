Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131753AbQLLMwU>; Tue, 12 Dec 2000 07:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131803AbQLLMwL>; Tue, 12 Dec 2000 07:52:11 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:62468 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S131753AbQLLMwB>; Tue, 12 Dec 2000 07:52:01 -0500
Message-ID: <3A36183F.1EBD9368@agelectronics.co.uk>
Date: Tue, 12 Dec 2000 12:21:19 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: groudier@club-internet.fr, mj@suse.cz, lk@tantalophile.demon.co.uk,
        davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.10.10012112207400.2144-100000@linux.local> <200012112221.OAA01081@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> Interpreting physical BAR values is another issue altogether.  Kernel
> wide interfaces for this may be easily added to include/asm/pci.h
> infrastructure, please just choose some sane name for it and I will
> compose a patch ok? :-)

There's a semi-respectable use for BAR values: peer-to-peer mastering. 
A new kernel interface could actually make that portable, eg:

int pci_peer_master_address(struct pci_dev *master,
	struct pci_dev *target, int resource, unsigned long offset,
	unsigned long *address);
Return values PCI_PEER_OK, PCI_PEER_NOWAY, PCI_PEER_FXBUG,
PCI_PEER_YOURE_JOKING_RIGHT, ... Bus address usable by master placed in
address.

Implementing something like this with a single hostbridge is simple.
It's  harder on boards like my Intel 840 motherboard here, where the
33MHz and 66MHz buses don't talk to each other. It could eventually grow
into a big list of platform specific workarounds, but at least they'd
all be in one place where we could see them.


- Adrian Cox, AG Electronics
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
