Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129276AbRBGMRR>; Wed, 7 Feb 2001 07:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRBGMQ5>; Wed, 7 Feb 2001 07:16:57 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:35858 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129110AbRBGMQx>;
	Wed, 7 Feb 2001 07:16:53 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "A.Sajjad Zaidi" <sajjad@vgkk.com>
Date: Wed, 7 Feb 2001 13:15:22 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <14CC6FFB19AD@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Feb 01 at 19:12, A.Sajjad Zaidi wrote:

> I just built a system that uses a K7V motherboard with the KT133
> chipset. It has an onboard Promise PDC20265 ATA-100 controller.  Im
> running RH6.2.
> 
> hda: dma_intr: bad DMA status
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> hda: dma_intr: bad DMA status
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> hda: dma_intr: bad DMA status
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> hda: dma_intr: bad DMA status
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> hda: DMA disabled
> hdb: DMA disabled
> 
> and the system freezes completely. I have no option, but to do a cold
> reboot.

It is known bug which I reported to Andre already. Open
drivers/ide/ide.c in favorite text editor, and replace strange
body of ide_delay_50ms() with simple mdelay(50). Promise driver
invokes ide_delay_50ms with interrupts disabled, so it freezes
here forever. If you have NMI watchdog, you'll get nice oopses.

As for DMA failure itself, I have no idea what is wrong in your
case, but I found that mine Promise works with Linux only iff there
is master on each channel, slave alone does not work. And I did not
tried master+slave together.
                                    Petr Vandrovec
                                    vandrove@vc.cvut.cz
                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
