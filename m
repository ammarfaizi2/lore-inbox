Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293637AbSB1SPj>; Thu, 28 Feb 2002 13:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293641AbSB1SMl>; Thu, 28 Feb 2002 13:12:41 -0500
Received: from gw-nl4.philips.com ([212.153.190.6]:18961 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S293654AbSB1SIv>; Thu, 28 Feb 2002 13:08:51 -0500
From: fabrizio.gennari@philips.com
To: Ed Vance <EdV@macrolink.com>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: RE: Oxford Semiconductor's OXCB950 UART not recognized by serial.	c
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF473EC31B.7B4D4C9D-ONC1256B6E.00620423@diamond.philips.com>
Date: Thu, 28 Feb 2002 19:07:54 +0100
X-MIMETrack: Serialize by Router on hbg001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 28/02/2002 19:27:23,
	Serialize complete at 28/02/2002 19:27:23
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed, you are right, the card matches the entry before the last one in 
serial_pci_tbl[], the one with PCI_ANY_ID for both vendor and device. So I 
would like to add an entry in serial_pci_tbl[] for the vendor 
PCI_VENDOR_ID_OXSEMI and device 950b. However I do not know what to put in 
the field driver_data. Probably pbn_b0_1_115200 would be fine, but this is 
the default, so serial_init_one would try to call serial_pci_guess_board, 
but this fails...

Fabrizio Gennari
Philips Research Monza
via G.Casati 23, 20052 Monza (MI), Italy
tel. +39 039 2037816, fax +39 039 2037800




Ed Vance <EdV@macrolink.com>
21/02/2002 01.05

 
        To:     Fabrizio Gennari/MOZ/RESEARCH/PHILIPS@EMEA1
        cc:     rmk@arm.linux.org.uk
linux-kernel@vger.kernel.org
        Subject:        RE: Oxford Semiconductor's OXCB950 UART not recognized by serial.       c
        Classification: 



fabrizio.gennari@philips.com wrote:
> 
> We have 32-bit CardBus cards with OXCB950 CardBus (PCI ID 1415:950b) 
UART 
> chips on them (OXCB950 is the CardBus version of 16C950) . The module 
> serial_cb in the pcmcia-cs package recognizes them correctly. But, when 
> not using serial_cb, the function serial_pci_guess_board in serial.c 
> doesn't (kernel 2.4.17 tested). The problem is that the card advertises 
3 
> i/o memory regions and 2 ports. If one replaces the line
> 
> if (num_iomem <= 1 && num_port == 1) {
> 
> with
> 
> if (num_port >= 1) {
> 
> in the function serial_pci_guess_board(), the card is detected and works 

> perfectly. Only, when inserting it, the kernel displays the message:
> 
> Redundant entry in serial pci_table.  Please send the output of
> lspci -vv, this message (1415,950b,1415,0001)
> and the manufacturer and name of serial board or modem board
> to serial-pci-info@lists.sourceforge.net. 

The "Redundant entry" message comes out of serial.c when a card is found 
in
the PCI ID board list, but which function serial_pci_guess_board() also
detects as a generic single UART card (and overwrites the card's
board->flags field in the pci_boards[] array). 

Does anybody think this is a feature? Did I misunderstand?

I suspect that the thought was to detect and eventually remove 
pci_boards[]
entries for generic single-port cards that could also be detected by the
serial_pci_guess_board() function. Can anybody confirm or deny? 

Shouldn't the detection process be considered done when the PCI IDs match?
Why should the "guess" function even be called when the card has already
been found in the PCI board table?

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------



