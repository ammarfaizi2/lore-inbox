Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289759AbSAOXnR>; Tue, 15 Jan 2002 18:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289764AbSAOXnH>; Tue, 15 Jan 2002 18:43:07 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:19646 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S289759AbSAOXm6> convert rfc822-to-8bit; Tue, 15 Jan 2002 18:42:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: xavier <tyro_no_spam_@bartica.org>
To: linux-kernel@vger.kernel.org
Subject: hang after modprobe hisax
Date: Wed, 16 Jan 2002 00:37:03 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02011600370300.01886@balthus.xanadu>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
I own a passiv ISDN card (model : Gazel PCI 128[R753], vendor : Bewan) which is badly initialized by the bios.
The io ports are not rightly configured after the boot of my linux box.
The result is a complete hang of the machine after typing an "modprobe hisax type=34 protocol=2".
The last words of the console are "Gazel: PCI card automatic recognition".
Albeit I've upgraded to the latest bios available for my motherboard (an MSI 5169), nothing changed.

Karsten Keil wrote a hack called "pcitst" for setting the right io ports for the card.
Alas, this module was written for the 2.2 kernel serie, and doesn't work with the 2.4 one.

I'm not enough competent to port it for the new serie.
Does someone know about a new version of pcitst ?

This is really painful to keep stuck to the 2.2 serie, cause some new package are no more compatible with it (nfs, cdrecord ...)

I thought that a way to solve the problem would be to manually set the io using setpci.
I've started my box with the old kernel.
In order to know the wrong detected settings, I typed "lspci -vv -s 10.0" and I got this :


00:10.0 Network controller: PLX Technology, Inc.: Unknown device 1152 (rev 01)
	Subsystem: PLX Technology, Inc.: Unknown device 1152
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at dfffff80 (32-bit, non-prefetchable)
	Region 1: I/O ports at d880
	Region 2: I/O ports at dff0

After having loaded the pcitst module in order to get the working settings, I obtained :

	(...)
	Region 0: Memory at dfffff80 (32-bit, non-prefetchable)
	Region 1: I/O ports at 6100
	Region 2: I/O ports at dff0
	Region 3: [virtual] I/O ports at 6200

After rebooting whith my 2.4.17 kernel, I naively tried
"setpci -d 10b5:1152 BASE_ADDRESS_1=0x6101 BASE_ADDRESS_3=0x6201"
but didn't get what I had expected.
I get
	(...)
	Region 1: I/O ports at d880

Which isn't what I meant.

Does anyone have a clue ?

Since I do not belong to the lkmailing list,
could you please CC any answer to my address (whithout the _no_spam_, of course).
Thanks.


