Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136776AbREAXdw>; Tue, 1 May 2001 19:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136769AbREAXdf>; Tue, 1 May 2001 19:33:35 -0400
Received: from adsl-63-206-198-42.dsl.snfc21.pacbell.net ([63.206.198.42]:25303
	"EHLO adsl-63-206-198-42.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S135666AbREAXdV>; Tue, 1 May 2001 19:33:21 -0400
Date: Tue, 1 May 2001 16:30:28 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
To: Keith Owens <kaos@ocs.com.au>
cc: "Michael H. Warfield" <mhw@wittsend.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Elmer Joandi <elmer@linking.ee>, Ookhoi <ookhoi@dds.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work 
In-Reply-To: <18097.988678844@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0105011332210.18582-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I tried 2.4.4-ac2 this morning. The warning about rx_queue_len is
gone :-) but I have one about tx_full_rate:

May  1 12:37:25 oleron cardmgr[150]: + Warning: /lib/modules/2.4.4-ac2/kernel/drivers/net/aironet4500_core.o 
symbol for parameter tx_full_rate not found

   That's easily solved by applying the following:

--- cut here ---
--- aironet4500_core.c.orig     Mon Apr 30 19:14:38 2001
+++ aironet4500_core.c  Mon Apr 30 19:14:47 2001
@@ -2568,7 +2568,7 @@
 MODULE_PARM(awc_debug,"i");
 MODULE_PARM(tx_rate,"i");
 MODULE_PARM(channel,"i");
-MODULE_PARM(tx_full_rate,"i");
+//MODULE_PARM(tx_full_rate,"i");
 MODULE_PARM(adhoc,"i");
 MODULE_PARM(master,"i");
 MODULE_PARM(slave,"i");
--- cut here ---



On Tue, 1 May 2001, Keith Owens wrote:
> >> Apr 30 13:19:35 oleron cardmgr[148]: get dev info on socket 0
> >> failed: Resource temporarily unavailable
> 
> Separate problem, the aironet4500_cs driver could not get its
> resources.

   I still get this message but I didn't have much time to play with the
irq / ioport allocations. That's what you meant by 'resources', right?
   Unfortunately I don't have access to the card anymore (well, I'll try
to borrow it again) so I won't be able to do more tests. Since it looks
like a hardware resource issue here are some more details about my
config for future cross-referencing. The laptop is a Sony Vaio F560.
lspci says the following:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222 i.LINK Controller (rev 02)
00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
00:0a.0 Communication controller: CONEXANT: Unknown device 2443 (rev 01)
00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
00:0c.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
01:00.0 VGA compatible controller: Neomagic Corporation: Unknown device 0016 (rev 10)

   On another laptop the card was using interrupt 15 and ioports
0140-017f which on this one would conflict with ide1. But there's other 
ranges available.
  0170-0177 : ide1
  15:          0          XT-PIC  ide1

--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
           If it stinks, it's chemistry. If it moves, it's biology.
                  If it does not work, It's computer science.






