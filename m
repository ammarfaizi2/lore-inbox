Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRCLNVi>; Mon, 12 Mar 2001 08:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbRCLNV2>; Mon, 12 Mar 2001 08:21:28 -0500
Received: from mail.sonytel.be ([193.74.243.200]:3299 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S130211AbRCLNVU>;
	Mon, 12 Mar 2001 08:21:20 -0500
Date: Mon, 12 Mar 2001 14:19:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: tulip-users@lists.sourceforge.net,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 21041 transmit timed out
In-Reply-To: <Pine.LNX.4.05.10012201318030.1508-100000@callisto.of.borg>
Message-ID: <Pine.GSO.4.10.10103121407450.15717-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Geert Uytterhoeven wrote:
> Since I switched from the de4x5 driver to the tulip driver several months ago
> (before that, tulip didn't work on PPC), I never saw 21041 transmit timed out
> messages again, until today:
> 
> | Dec 20 12:13:29 callisto kernel: Linux Tulip driver version 0.9.11 (November 3, 2000)
> | Dec 20 12:13:29 callisto kernel: PCI: Enabling device 00:04.0 (0000 -> 0003)
> | Dec 20 12:13:29 callisto kernel: eth0: Digital DC21041 Tulip rev 33 at 0x1080, 21041 mode, 00:80:C8:5A:F8:5B, IRQ 29.
> | Dec 20 12:13:29 callisto kernel: eth0: 21041 Media table, default media 0800 (Autosense).
> | Dec 20 12:13:29 callisto kernel: eth0:  21041 media #0, 10baseT.
> | Dec 20 12:13:29 callisto kernel: eth0:  21041 media #4, 10baseT-FD.
> | Dec 20 12:13:29 callisto kernel: eth0:  21041 media #1, 10base2.
> | Dec 20 12:55:27 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
> | Dec 20 12:55:27 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000001c8, CSR13 ffffef05, CSR14 ffffff3f, resetting...
> | Dec 20 12:55:27 callisto kernel: eth0: 21143 100baseTx sensed media.
> | Dec 20 12:55:35 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
> | Dec 20 12:55:35 callisto kernel: eth0: 21041 transmit timed out, status fc660010, CSR12 000002c8, CSR13 ffffef0d, CSR14 fffff73d, resetting...
> | Dec 20 12:55:35 callisto kernel: eth0: 21143 100baseTx sensed media.

    [...]

> Then I tried ifconfig down/up, which didn't work. An additional rmmod/insmod
> pair for the tulip module woke up the card again:
> 
> | Dec 20 13:00:43 callisto kernel: Linux Tulip driver version 0.9.11 (November 3, 2000)
> | Dec 20 13:00:43 callisto kernel: eth0: Digital DC21041 Tulip rev 33 at 0x1080, 21041 mode, 00:80:C8:5A:F8:5B, IRQ 29.
> | Dec 20 13:00:43 callisto kernel: eth0: 21041 Media table, default media 0800 (Autosense).
> | Dec 20 13:00:43 callisto kernel: eth0:  21041 media #0, 10baseT.
> | Dec 20 13:00:43 callisto kernel: eth0:  21041 media #4, 10baseT-FD.
> | Dec 20 13:00:43 callisto kernel: eth0:  21041 media #1, 10base2.
> 
> The machine is a CHRP LongTrail (PPC 604e), running some kind of 2.4.0-test11
> kernel.
> 
> The card is a D-Link DE-530CT, with a 21041 on a 10baseT network (hence not
> 100baseTx, as detected during the problem phase!).

lspci output:

| 00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
|         Subsystem: D-Link System Inc DE-530+
|         Flags: bus master, medium devsel, latency 0, IRQ 29
|         I/O ports at 1080 [size=128]
|         Memory at c1080000 (32-bit, non-prefetchable) [size=128]
|         Expansion ROM at c11c0000 [disabled] [size=256K]

I made a list of driver versions that showed the problem so far:

| Tulip driver version 0.9.11 (November 3, 2000)
| Tulip driver version 0.9.13 (January 2, 2001)
| Tulip driver version 0.9.13a (January 20, 2001)
| Tulip driver version 0.9.14 (February 20, 2001)

There's one version I never had problems with:

| Tulip driver version 0.9.5 (May 30, 2000) (from 2.4.0-test1-ac10)

Of course I'm not 100% sure, but I ran 2.4.0-test1-ac10 for nearly 6 months on
that machine, without a single Tulip problem. All other versions caused
problems in a much shorter timeframe.

BTW, do you want me to try 1.1.2?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

