Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292595AbSBUAFd>; Wed, 20 Feb 2002 19:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSBUAFO>; Wed, 20 Feb 2002 19:05:14 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:6416 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292593AbSBUAFB>; Wed, 20 Feb 2002 19:05:01 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76A8@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'fabrizio.gennari@philips.com'" <fabrizio.gennari@philips.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: RE: Oxford Semiconductor's OXCB950 UART not recognized by serial.
	c
Date: Wed, 20 Feb 2002 16:05:13 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fabrizio.gennari@philips.com wrote:
> 
> We have 32-bit CardBus cards with OXCB950 CardBus (PCI ID 1415:950b) UART 
> chips on them (OXCB950 is the CardBus version of 16C950) . The module 
> serial_cb in the pcmcia-cs package recognizes them correctly. But, when 
> not using serial_cb, the function serial_pci_guess_board in serial.c 
> doesn't (kernel 2.4.17 tested). The problem is that the card advertises 3 
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

The "Redundant entry" message comes out of serial.c when a card is found in
the PCI ID board list, but which function serial_pci_guess_board() also
detects as a generic single UART card (and overwrites the card's
board->flags field in the pci_boards[] array). 

Does anybody think this is a feature? Did I misunderstand?

I suspect that the thought was to detect and eventually remove pci_boards[]
entries for generic single-port cards that could also be detected by the
serial_pci_guess_board() function. Can anybody confirm or deny? 

Shouldn't the detection process be considered done when the PCI IDs match?
Why should the "guess" function even be called when the card has already
been found in the PCI board table?

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
