Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRAHW2m>; Mon, 8 Jan 2001 17:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbRAHW2c>; Mon, 8 Jan 2001 17:28:32 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:18952 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129752AbRAHW2R>;
	Mon, 8 Jan 2001 17:28:17 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 23:27:13 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: PCI IRQ routing on buggy BIOSes
CC: mj@suse.cz
X-mailer: Pegasus Mail v3.40
Message-ID: <1206565040F1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  following happened on my well-known SMP VIA based GA6VXD7 motherboard.

Last week on Thursday I decided to connect printer to the box. To do that
I had to switch parallel port mode from ECP to Normal (because of I
had problems with that printer). Today I found, that since that time
(Thu 3:57) my second bttv, which is used for teletext grabbing, stopped
functioning.

After some testing I found that correct IRQ is 19, and not 18... And after
turning some options in BIOS I found that it is related to parallel port
setting:

Parallel port setting:   Normal   ECP     driver/location
B0,I7,P3                   18     19      usb 00:07.2 (not used)
B0,I7,P3                   18     19      usb 00:07.3 (not used)
B0,I10,P0                  18     18      bttv0 0:0a.0
B0,I11,P0                  18     19      bttv1-video 0:0b.0
B0,I11,P0                  18     19      bttv1-audio 0:0b.1
B0,I13,P0                  17     17      eth0 0:0d.0
B0,I14,P0                  18     18      dsp0 0:0e.0
B1,I0,P0                   16     16      dri0 1:00.0

Of course table reported for ECP mode is correct one. Anybody have any
idea how to get it to work in Normal/EPP mode without hardwiring this
routing table to kernel? There are no complaints in system dmesg.

Every IRQ in BIOS is selected as PCI/PnP, as there are no ISA devices
in box (except on-board southbridge COM/LPT). PnP OS setting does not
matter.

There is also one difference at BIOS info screen: in first case (normal),
it prints _all_ these devices on IRQ10, while in ECP mode some devices 
use IRQ5. Probably another bug in Award core, they generate wrong
PIRQ routing table when couple (all 4) PIRQ are routed to same 8259 IRQ :-(
This leaves open why all devices use IRQ10 in 8259 mode - are other really 
used by onboard unshareable ACPI/RTC/IDE/COM/LPT/PS2/KBD/TIMER/FLOPPY?!
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
