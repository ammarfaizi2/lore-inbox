Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129727AbRCARAD>; Thu, 1 Mar 2001 12:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRCAQ7o>; Thu, 1 Mar 2001 11:59:44 -0500
Received: from cc946626-a.vron1.nj.home.com ([24.5.103.153]:51465 "EHLO
	tela.bklyn.org") by vger.kernel.org with ESMTP id <S129723AbRCAQ7j>;
	Thu, 1 Mar 2001 11:59:39 -0500
Date: Thu, 1 Mar 2001 11:59:38 -0500
From: Caleb Epstein <cae@bklyn.org>
To: linux-kernel@vger.kernel.org
Subject: NETDEV WATCHDOG: eth0: transmit timed out
Message-ID: <20010301115938.A8178@tela.bklyn.org>
Reply-To: Caleb Epstein <cae@bklyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: Brooklyn Dust Bunny Mfg.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I am seeing the following error after my machine has been up
	for a while.  My eth0 is connected to a switched, local
	subnet.  There is not a lot of traffic on the interface, maybe
	a few 100 Mbytes or so.  Taking the interface down and then up
	again fixes the problem (until it happens again :)

	Here is the relevant section from my kernel log

Mar  1 10:48:44 tela kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar  1 10:48:44 tela kernel: eth0: transmit timed out, tx_status 00 status e000.
Mar  1 10:48:44 tela kernel:   diagnostics: net 0ec0 media 4810 dma 00000021.
Mar  1 10:48:44 tela kernel:   Flags; bus-master 1, full 1; dirty 87959(7) current 87975(7).
Mar  1 10:48:44 tela kernel:   Transmit list 01252270 vs. c1252270.
Mar  1 10:48:44 tela kernel:   0: @c1252200  length 800000f7 status 000000f7
Mar  1 10:48:44 tela kernel:   1: @c1252210  length 8000010c status 0000010c
Mar  1 10:48:44 tela kernel:   2: @c1252220  length 800000f7 status 000000f7
Mar  1 10:48:44 tela kernel:   3: @c1252230  length 8000010c status 0000010c
Mar  1 10:48:44 tela kernel:   4: @c1252240  length 800000f7 status 000000f7
Mar  1 10:48:44 tela kernel:   5: @c1252250  length 8000002a status 8000002a
Mar  1 10:48:44 tela kernel:   6: @c1252260  length 8000002a status 8000002a
Mar  1 10:48:44 tela kernel:   7: @c1252270  length 8000010c status 0000010c
Mar  1 10:48:44 tela kernel:   8: @c1252280  length 800000f7 status 000000f7
Mar  1 10:48:44 tela kernel:   9: @c1252290  length 8000010c status 0000010c
Mar  1 10:48:44 tela kernel:   10: @c12522a0  length 800000f7 status 000000f7
Mar  1 10:48:44 tela kernel:   11: @c12522b0  length 8000010c status 0000010c
Mar  1 10:48:44 tela kernel:   12: @c12522c0  length 800000f7 status 000000f7
Mar  1 10:48:44 tela kernel:   13: @c12522d0  length 8000010c status 0000010c
Mar  1 10:48:44 tela kernel:   14: @c12522e0  length 800000f7 status 000000f7
Mar  1 10:48:44 tela kernel:   15: @c12522f0  length 8000010c status 0000010c
Mar  1 10:48:44 tela kernel: eth0: Resetting the Tx ring pointer.

	Then a similar dump repeats until the interface is recycled.
	It appears that the interface was not functioning for some
	hours before the message was generated, and it was my attempt
	to ping a host on the local subnet that caused the NETDEV
	WATCHDOG error to be generated (e.g. the card locked up, but
	the kernel didn't notice until I tried to send something on
	the wire).

	The card is:

	eth0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0x1400,
	00:60:08:bd:ab:0e, IRQ 9

	I am running kernel 2.4.2, and have seen this error in 2.4.1
	as well; not sure about 2.4.0.  I do not ever recall
	encountering this error with the 2.2.x kernels, though my
	network topology has changed, but not my hardware.  I know of
	at least one other person who gets this same error with a
	eth0: 3Com PCI 3c905B Cyclone 100baseTx card.  The system is a
	P2-300, 128 Mb RAM, running various versions of Linux very
	happily for 3 years.

	FWIW, IRQ 9 is shared with the bttv module, though the network
	lockup doesn't seem to be related to my use of that module.  I
	was using xawtv last night while the interface was stil active
	and functioning.  The lockup happened this morning.

	Sorry for the long-winded post.  Is this a known bug?
	Anything I can do to help track it down and squash it if so?

-- 
cae at bklyn dot org | Caleb Epstein | bklyn . org | Brooklyn Dust Bunny Mfg.
