Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbRFQXMK>; Sun, 17 Jun 2001 19:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbRFQXLv>; Sun, 17 Jun 2001 19:11:51 -0400
Received: from student.dei.uc.pt ([193.137.203.231]:18441 "EHLO
	student.dei.uc.pt") by vger.kernel.org with ESMTP
	id <S263142AbRFQXLp>; Sun, 17 Jun 2001 19:11:45 -0400
Message-ID: <004e01c0f782$01501ad0$5700030a@gandalf>
From: "Tiago J. S. Martins Cruz" <tjcruz@student.dei.uc.pt>
To: <linux-kernel@vger.kernel.org>
Subject: Strange behaviour with multiple IDE interfaces.
Date: Mon, 18 Jun 2001 00:05:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 I own one of these last BX motherboards released with an extra
 UDMA 66/100 interface:  the  ASUS  CUBX.  In this case, this
 model comes with a CMD-648 UDMA66 chip.

 Following some trouble I had with driver support to the chip (I also
use Win2K) I decided to buy a Promise Ultra100 PCI interface and
conected my HDD to it.

Now, this is where the things complicate: I can install either Mandrake
8.0 or RH 7.1 without problems, but when I try to boot the installation
the kernel  hangs after these lines are displayed:

     ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
     ide1 at 0x170-0x177,0x376 on irq 15

there is no mention of the other controllers. To isolate the problem, I
tried the following measures:

    A- disabled CMD-648 controller:
            the system booted

    B-  removed the Promise controller and connected the HDD to the CMD-648:
            the system booted

    C- tried ide=reverse boot parameter with the original config:
            the system booted displaying an error message informing that it
            was unable to find an IRQ to the CMD-648 interface.

Strange...Then I remembered one thing: "The kernel used in the installation
of both distributions worked". So I went back to the Mandrake CD and
tried to boot gain from it. The process went fine with the kernel  that was
used with the graphical installation procedure, but with the one used for
text install the system hanged  the same way I explained before.

So, I compiled an 2.4.2 kernel with the same config options used in the
standard RH kernel but with frame buffer support included and (amazing...)
the system booted perfectly (later I tried with 2.4.5 kernel and the same
thing
happened).

I have the following system configuration:

Motherboard: ASUS CUBX

    i82440BX hda: ATAPI ZIP
                     hdb: none
                     hdc: HP CDWriter 9300+
                     hdd: none

    CMD-648 hde: ASUS 50X ATAPI CDROM drive
                     hdf: none
                     hdg: none
                     hdh: none

    Promise U100 hdi: Pioneer DVD-116 UDMA66 DVD-ROM drive
                           hdj: none
                           hdk: IBM Deskstar 703070 30GB UDMA 100 IDE HDD
                           hdl: none


Both CMD and Promise are detected using IRQ 10. Lastest BIOS installed
for both.

Thanks for any help.

 --Tiago Cruz


