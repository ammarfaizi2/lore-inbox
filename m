Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129558AbQKHRwU>; Wed, 8 Nov 2000 12:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129386AbQKHRwA>; Wed, 8 Nov 2000 12:52:00 -0500
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:516 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S129113AbQKHRv4>; Wed, 8 Nov 2000 12:51:56 -0500
X-Server-Uuid: 7edb479a-fd89-11d2-9a77-0090273cd58c
Message-ID: <3A09920A.F6F298AD@sandia.gov>
Date: Wed, 08 Nov 2000 10:48:58 -0700
From: "Jim Schutt" <jaschut@sandia.gov>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
cc: kuznet@ms2.inr.ac.ru, "Andi Kleen" <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: tulip vs. de4x5 (was Re: Linux 2.4 Status / TODO page ...)
In-Reply-To: <200011031937.WAA10753@ms2.inr.ac.ru>
 <3A032E32.39E7B151@mandrakesoft.com>
X-WSS-ID: 16174D81286314-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> 
> de4x5 is becoming EISA-only in 2.5.x too, since its PCI support is
> duplicated now in tulip driver.
> 

I've got some DEC Miatas with DECchip 21142/43 ethernet cards, and I
don't get the same link speeds when using the de4x5 and tulip drivers,
as of 2.4.0-test10.  The machines are connected to a Netgear 16-port 
10/100 hub.  With the tulip driver the hub shows a 10 Mb/s connection;
with the de4x5 driver the hub shows a 100 Mb/s connection.  In both
cases the drivers are configured into the kernel, not as modules, if
it matters.

Am I doing something wrong, or is this a known issue?

FWIW, these machines are diskless, and according to the hub they download
the kernel at 100 Mb/s.  When the tulip-based kernel initializes the
card, the hub shows the link speed switching to 10 Mb/s.


from lspci -v:

00:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev
30)
	Flags: bus master, medium devsel, latency 255, IRQ 24
	I/O ports at 8000 [size=128]
	Memory at 0000000009000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 0000000009040000 [disabled] [size=256K]


de4x5 boot messages:

eth0: DC21143 at 0x8000 (PCI bus 0, device 3), h/w address 00:00:f8:76:3c:74,
      and requires IRQ24 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com


tulip boot messages:

Linux Tulip driver version 0.9.10 (September 6, 2000)
eth0: Digital DS21143 Tulip rev 48 at 0x8000, 00:00:F8:76:3C:74, IRQ 24.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
eth0:  Index #1 - Media 10baseT-FD (#4) described by a 21142 Serial PHY (2)
block.
eth0:  Index #2 - Media 10base2 (#1) described by a 21142 Serial PHY (2) block.
eth0:  Index #3 - Media AUI (#2) described by a 21142 Serial PHY (2) block.
eth0:  Index #4 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth0:  MII transceiver #5 config 2000 status 784b advertising 01e1.

-- Jim

-----
James A. Schutt
jaschut@sandia.gov

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
