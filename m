Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292339AbSCSTvI>; Tue, 19 Mar 2002 14:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292336AbSCSTu7>; Tue, 19 Mar 2002 14:50:59 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:32520 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292316AbSCSTuw>; Tue, 19 Mar 2002 14:50:52 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A771A@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'fabrizio.gennari@philips.com'" <fabrizio.gennari@philips.com>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: about the Oxford 16pci952
Date: Tue, 19 Mar 2002 11:50:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabrizio Gennari wrote:
> 
> ... the device [with] ID 0x950A, is in fact a 16PCI954! 
> The card is an Exsys EX-41092 rev. A, with an 
> OX16PCI954-TQC60-A1 0105 chip.

Thanks for digging out the real answer. That certainly explains why the
current serial driver config entry for 16PCI952 does not match the
datasheet! I will submit a patch to correct the identification of the device
associated with that entry and add a correct entry for the 16PCI952 chip.
Good work! 

> There are some mysteries: why are the device IDs different 
> from the official Ox Semi ones? Probably the guys at Exsys 
> did so intentionally, so the parallel port that cannot be 
> used because of the lack of a connector would not be 
> detected by the system?

Yes, Exsys undoubtedly did this intentionally with the EEPROM. You can do
some really interesting changes and initialization from the EEPROM.
Unfortunately, Exsys seems to have been confused about how the PCI spec says
card identification is to be done. They were not supposed to touch the
vendor and device IDs, because those fields define the PCI interface
silicon. They are supposed to change the subvendor and subsystem IDs to
uniquely represent their card. The whole card is the "subsystem". For
uniqueness, they would either get an official subsystem ID from Oxford Semi
to use with Oxford's vendor ID in the subvendor ID field, or get their own
vendor ID from those nice folks at the PCI SIG to put in the subvendor ID
field with their own arbitrary choice of subsystem ID. 

I quote from section 6.2.4 "Miscellaneous Registers" of the "PCI Local Bus
specification" Revision 2.2, page 200:

| Subsystem Vendor ID and Subsystem ID
| 
| These registers are used to uniquely identify the expansion board or 
| subsystem where the PCI device resides. They provide a mechanism for 
| expansion board vendors to distinguish their boards from one another 
| even though the boards may have the same PCI controller on them (and, 
| therefore, the same Vendor ID and Device ID). 

The earlier PCI spec did not spell this out explicitly, so a lot of people
got it wrong. 

Thanks again for clearing up the 16PCI952 mystery.

Best regards,
Ed Vance

---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------



