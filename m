Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTDTLBc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 07:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTDTLBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 07:01:32 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:49861 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263552AbTDTLBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 07:01:30 -0400
Date: Sun, 20 Apr 2003 13:12:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: tulip-users@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 21041 transmit timed out
Message-ID: <Pine.GSO.4.21.0304201237140.14680-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

Under heavy network activity (e.g. downloading ISOs), my Tulip card (D-Link
DE-530+ with DECchip 21041) still goes down with 2.4.20.

Suddenly I start getting messages of the form:
| NETDEV WATCHDOG: eth0: transmit timed out
| eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| eth0: 21143 100baseTx sensed media.

and the network no longer works. Sometimes it automatically recovers after a
while (without printing additional messages), but usually I need to do a manual
ifconfig down/up sequence to revive the network.

The register values may differ. Last time I saw these, with their respective
number of occurrencies:

 1741 x status fc260010, CSR12 000000c8, CSR13 ffffef09, CSR14 ffffff7f
  581 x status fc260010, CSR12 000002c8, CSR13 ffffef09, CSR14 ffffff7f
   20 x status fc260010, CSR12 000050c8, CSR13 ffffef09, CSR14 fffff7fd
    6 x status fc260010, CSR12 000052c8, CSR13 ffffef09, CSR14 fffff7fd
   28 x status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff

Once it printed

| eth0: 21041 media switched to 10baseT.

after which the network seemed to work again for a few minutes.

I also got 27 times

| eth0: No 21041 10baseT link beat, Media switched to 10base2.

which I find, together with the zillions of `21143 100baseTx sensed media'
messages very strange, since the card is 10 Mbps-only and connected using UTP
to a 10 Mbps-only Ethernet hub (D-Link DE816-TP).

Driver startup:

| Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
| PCI: Enabling device 00:04.0 (0000 -> 0003)
| tulip0: 21041 Media table, default media 0800 (Autosense).
| tulip0:  21041 media #0, 10baseT.
| tulip0:  21041 media #4, 10baseT-FDX.
| tulip0:  21041 media #1, 10base2.
| eth0: Digital DC21041 Tulip rev 33 at 0xc9855000, 21041 mode, 00:80:C8:5A:F8:5B, IRQ 29.

lspci output:

| 00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
| 	Subsystem: D-Link System Inc DE-530+
| 	Flags: bus master, medium devsel, latency 0, IRQ 29
| 	I/O ports at 1080 [size=128]
| 	Memory at c1080000 (32-bit, non-prefetchable) [size=128]
| 	Expansion ROM at c11c0000 [disabled] [size=256K]

The machine is a PPC box (CHRP LongTrail).

Is there _anything_ I can do to help resolve this problem? Which debug options
do I have to enable to give you more information?

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

