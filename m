Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283677AbRLEBtB>; Tue, 4 Dec 2001 20:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283674AbRLEBsw>; Tue, 4 Dec 2001 20:48:52 -0500
Received: from [203.117.131.12] ([203.117.131.12]:53892 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S283677AbRLEBsh>; Tue, 4 Dec 2001 20:48:37 -0500
Message-ID: <3C0D7CEA.2050307@metaparadigm.com>
Date: Wed, 05 Dec 2001 09:48:26 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011127
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Myers <rob.myers@gtri.gatech.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH] - 2.4.16 ns83820 optical support (Netgear GA621)
In-Reply-To: <3C0CED3B.7030409@metaparadigm.com> <1007501048.14051.28.camel@ransom>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Myers wrote:

> cool, i've tested your patch and it seems to work.  now i will be free
> of that unfriendly netgear driver. :)  i tested it on an updated redhat
> 7.2 box. (2.4.9-13smp)  it is an asus p2b-d motherboard.  (p3 smp,
> 32bitpci).
> 
> i did notice some odd dmesg output, however:
> 
> eth%d: enabling 64 bit PCI.
> eth%d: enabling optical transceiver
> eth1: ns83820.c v0.13: DP83820 00:40:f4:29:ea:d7 pciaddr=0xe1000000
> irq=12 rev 0x103
> eth1: link now 1000F mbps, full duplex and up.
> eth1: link now 1000F mbps, full duplex and up.
> 
> [now keeping in mind i know nothing of linux device drivers...]
> 
> this is only a 32bit pci box so why would it enable 64bit pci?


The code reads a 64bit detect flag from the ns chip - so I guess it
must be bogus with some motherboards. Mine is okay. Ben??


> are references to dev->net_dev.name valid before
> register_netdev(&dev->net_dev) in ns83820_init_one()?


Okay, so i'll move the register_netdev call earlier on in the
initialisation and add any necessary unregister call for failures.


> is/why phy_intr() called 2wice?


The card issues multiple interrupts during auto-negotiation. If you
change the dprintk to a printk on the line with the tbisr=, tanar=,
you'll see the details of the phy interrupt. The driver needs a link
status variable so we then only print link status changes when
link status changes. The current problem is purely cosmetic.


> thanks for the patch!
> 
> rob.



