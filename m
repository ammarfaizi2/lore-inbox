Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290730AbSBLCp2>; Mon, 11 Feb 2002 21:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290729AbSBLCpS>; Mon, 11 Feb 2002 21:45:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22407 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290730AbSBLCpO>;
	Mon, 11 Feb 2002 21:45:14 -0500
Date: Mon, 11 Feb 2002 18:43:16 -0800 (PST)
Message-Id: <20020211.184316.70218682.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: weber@nyc.rr.com, tom_gall@vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16aKtw-0007Q0-00@the-village.bc.nu>
In-Reply-To: <3C680184.9090208@nyc.rr.com>
	<E16aKtw-0007Q0-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Mon, 11 Feb 2002 18:10:04 +0000 (GMT)
   
   For ISA devices pass NULL.

That is the recommended method for drivers that have to deal
with ISA and PCI variants of a chipset.

However, for "purely x86 ISA" devices one may use
isa_bus_to_virt and isa_virt_to_bus.

I hesitate to even mention this because what people should _not_ do is
just put "isa_" in front of the virt_to_bus et al. calls in all the
PCI drivers that stopped to link now.

There are other tangental issues I'd like to address and clarify in
this area.  This includes the "what can be invoked from interrupt"
questions.  Currently I think pci_{alloc,free}_consistent() should be
valid from an interrupt.
