Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274680AbRIYWz2>; Tue, 25 Sep 2001 18:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274681AbRIYWzS>; Tue, 25 Sep 2001 18:55:18 -0400
Received: from hermes.csd.unb.ca ([131.202.3.20]:15581 "EHLO hermes.csd.unb.ca")
	by vger.kernel.org with ESMTP id <S274680AbRIYWzD>;
	Tue, 25 Sep 2001 18:55:03 -0400
X-WebMail-UserID: newton
Date: Tue, 25 Sep 2001 20:04:54 -0300
From: Chris Newton <newton@unb.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00003025, 00003442
Subject: FWD: RE: excessive interrupts on network cards
Message-ID: <3BB13732@webmail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu got me to run 'lspci -x', and came to the conclusion that the 
net card and scsi card are sharing IRQs...

  Someone just told me tha the had had a sound card and a network card sharing 
IRQs, and that caused the network card to generate 'oodles of interrupts for 
no apparent reason'.

  This on the right track?

Thanks

Chris

>===== Original Message From Francois Romieu <romieu@cogenit.fr> =====
Chris Newton <newton@unb.ca> :
[...]
> 00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
> 08)
> 00: 86 80 29 12 17 01 90 02 08 00 00 02 08 20 00 00
> 10: 00 20 10 fe c1 ec 00 00 00 00 00 fe 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 9b 00
> 30: 00 00 00 fd dc 00 00 00 00 00 00 00 0b 01 08 38
                                           ^
[...]
> 01:02.0 SCSI storage controller: Adaptec 7899P (rev 01)
> 00: 05 90 cf 00 16 01 b0 02 01 00 00 01 08 20 80 80
> 10: 01 dc 00 00 04 10 00 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ce 00
> 30: 00 00 00 f8 dc 00 00 00 00 00 00 00 05 01 28 19
                                           ^
[...]
> 01:02.1 SCSI storage controller: Adaptec 7899P (rev 01)
> 00: 05 90 cf 00 16 01 b0 02 01 00 00 01 08 20 80 80
> 10: 01 d8 00 00 04 00 00 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ce 00
> 30: 00 00 00 f8 dc 00 00 00 00 00 00 00 0b 02 28 19
                                           ^
[...]
> 01:06.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
> [Python-T] (rev 78)
> 00: b7 10 05 98 17 01 10 02 78 00 00 02 08 20 00 00
> 10: 81 d4 00 00 00 24 00 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
> 30: 00 00 00 f8 dc 00 00 00 00 00 00 00 05 01 0a 0a
                                           ^
[...]
> 01:08.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
> [Python-T] (rev 78)
> 00: b7 10 05 98 17 01 10 02 78 00 00 02 08 20 00 00
> 10: 01 d4 00 00 00 20 00 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
> 30: 00 00 00 f8 dc 00 00 00 00 00 00 00 0b 01 0a 0a
                                           ^
Each of your ethernet adapter shares an irq with a scsi controller.
I had some results pulling some cards from the PCI slots and moving
the network adapter around until its irq differs but I won't claim
it's the cure for your problem (it was on HP Netserver motherboards).

--
Ueimor

