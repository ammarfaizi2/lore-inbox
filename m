Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310468AbSDMUAX>; Sat, 13 Apr 2002 16:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310470AbSDMUAW>; Sat, 13 Apr 2002 16:00:22 -0400
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:4224 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S310468AbSDMUAV>;
	Sat, 13 Apr 2002 16:00:21 -0400
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200204131921.g3DJLHw02324@meduna.org>
Subject: Orinoco_plx, WEP and 0.7.6 fw
To: jt@hpl.hp.com
Date: Sat, 13 Apr 2002 21:21:17 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the file drivers/net/wireless/orinoco.c in 2.4.17 contains
on the line 1424:

  priv->has_wep = (firmver >= 0x00008);

I have the Siemens I-GATE 11M PCI card, which is a PrismII based
PCMCIA card in the PLX9052 PCI-PCMCIA adapter. This card has
firmware version 0.7.6 and definitely supports WEP - I am using
128-bit WEP in Windows without problems.

If I change the line to enable the WEP for fw 7, I get mixed
results in 2.4.19-pre6:

- I can ping, but I cannot telnet.
- My dmesg is full of
    eth1: Null event in orinoco_interrupt!
  and ocassionally I get
    eth1: Undecryptable frame on Rx. Frame dropped.
- when I ping I seem to get double replies sometimes (depending
  on who I ping - never for the access point, always for another
  client) - either I am somehow seeing both the packet from
  the client to the AP and from AP to me, or there is some
  problem in the receiving routines

Does the driver support interrupt sharing? I have quite a lot
devices on the PCI bus, the plx board is not able to get
a dedicated interrupt and shares it with the USB controller.
I have a SMP board, which can be a factor too.

Anyway, if I can ping and see the traffic of another clients
using tcpdump, the has_wep check is obviously too strict.
I would suggest to either lower the requirement to firmware 7,
or (if this is an exception and another cards are different)
to add a module parameter to override it.

BTW, 2.4.19-pre6 is better than 2.4.17 - in 2.4.17 I was not
able to get a single packet through. Keep up the good work
and let me know if I can help in testing patches etc.

linux-wlan does not work for me - most probably because
of a shared interrupt.

Upgrading the firmware to 0.8.x is not an option - tried the
update once and the card was on the way to manufacturer
(fortunately Siemens replaced it without problems).

L-K readers: experiences with a similar setup anyone?

Thanks
-- 
                                    Stano

