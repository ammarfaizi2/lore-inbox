Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271700AbRHQRKq>; Fri, 17 Aug 2001 13:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271699AbRHQRK0>; Fri, 17 Aug 2001 13:10:26 -0400
Received: from scl-ims.phoenix.com ([134.122.1.73]:25617 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S271695AbRHQRKS>; Fri, 17 Aug 2001 13:10:18 -0400
Message-ID: <D973CF70008ED411B273009027893BA401BE6BA9@irv-exch.phoenix.com>
From: David Christensen <David_Christensen@Phoenix.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
        Holger Lubitz <h.lubitz@internet-factory.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Encrypted Swap
Date: Fri, 17 Aug 2001 10:10:24 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ryan Mack proclaimed:
> > > is running.  If the system is physically compromised, 
> there is little way
> > > I can think of to take root without having to at least reboot the
> > > computer, thus destroying the unencrypted contents of RAM.
> > 
> > This is a myth. RAM survives rebooting, even after a quick 
> power cycle
> > most cells will probably still be ok. And with todays 
> memory sizes, it
> > would take a noticable amount of time to initialize all of 
> it to a given
> > value, so most systems don't do it (just testing some bytes of every
> > megabyte instead).
> > 
> > Holger
> > -
> 
> Errrm no. All BIOS that anybody would use write all memory found when
> initializing the SDRAM controller. They need to because nothing,
> refresh, precharge, (or if you've got it, parity/crc) will work
> until every cell is exercised. A "warm-boot" is different. However,
> if you hit the reset or the power switch, nothing in RAM survives.

Most modern firmware does NOT clear memory during POST, it takes too long.
Certain compatibility areas are usually cleared (such as the 1st megabyte)
but the rest is
left as is, except for a few read/writes (usually on a megabyte boundary).
The 
exception to this rule is ECC systems.  They have to be written to make sure
the 
ECC information is correct.  

SDRAM memory sizing is usually done by reading an EEPROM on the SDRAM DIMM.
The BIOS doesn't need to guess the correct timing values, it simply reads
the EEPROM and programs the memory controller.  In the case of a BIOS that
doesn't use EEPROM you might lose data as the BIOS iteratively tries 
different memory timings and tests if they work.

I have done work implementing ACPI S3 (suspend-to-RAM) in DOS by simply
hitting 
the RESET button and restoring the memory controller settings.  The contents
of 
RAM have always been valid.

David Christensen
