Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289885AbSBKR4q>; Mon, 11 Feb 2002 12:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289899AbSBKR4h>; Mon, 11 Feb 2002 12:56:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18705 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289885AbSBKR4X>; Mon, 11 Feb 2002 12:56:23 -0500
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
To: weber@nyc.rr.com (John Weber)
Date: Mon, 11 Feb 2002 18:10:04 +0000 (GMT)
Cc: tom_gall@vnet.ibm.com (Tom Gall), linux-kernel@vger.kernel.org
In-Reply-To: <3C680184.9090208@nyc.rr.com> from "John Weber" at Feb 11, 2002 12:38:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aKtw-0007Q0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> address and a physical address (via dma_addr_t), so it should be simple 
> to change the code to use this function.  However, I don't know where 
> the hell I'm supposed to find pci_dev -- I'll try rereading the 
> driver-model.txt code again :).

For ISA devices pass NULL. For the PCI devices you get it when you do the
initial PCI probing. So for the cs46xx you'll see its passed to cs46xx_probe()
and saved in card->pci_dev for future use. So you can get it from there.

If you are going to hack on cs46xx.c please pick up the one from 2.4.18pre9
and use that not the one in 2.5 , unless someone also updated that to
match the 2.4 changes. The one in 2.5 seems to still have holes where any 
user can oops the system that will get fixed by porting forward the current
driver

Alan
