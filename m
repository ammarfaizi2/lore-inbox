Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265270AbUENNN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUENNN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbUENNN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:13:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:21967 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265270AbUENNNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:13:53 -0400
Date: Fri, 14 May 2004 15:11:00 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: ata_piix: port disabled.  ignoring.
Message-ID: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

I'm trying to install Linux on a SATA disk in a Dell PowerEdge 750, which has
an Intel 82875P chipset with an Intel 6300ESB SATA Storage Controller.

I managed to do the actual installation by booting from a Knoppix 3.4 CD (using
kernel 2.4.26 or 2.6.5 (apparently SATA drivers were not included), doesn't
matter much) in an external USB CD-ROM driver, and installing Debian testing
using FAI (Fully Automatic Installation). It took a while because the SATA
drive was used in backwards compatiblity mode without DMA, but it succeeded.

The kernel I installed was kernel-image-2.6.5-1-686-smp from Debian, which has
SATA support included. But when I want to boot it, I get (manual copy):

| ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFEA0 irq 14
| ata1: port disabled. ignoring.

I don't care, no PATA devices attached.

| ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFEA8 irq 15
| ata2: port disabled. ignoring.

Bad, the Maxtor 6Y080M0 I want to boot from is there :-(

And after that it tries the normal IDE driver, which of course fails with:

| ide0: I/O resource 0x1F0-0x1F7 not free

I looked at ata_piix.c, and apparently the driver decides whether a port is
disabled by checking a bit in PCI config space, so this looks like a BIOS setup
problem to me. But the BIOS has the first SATA port enabled (`AUTO', and it
does see a 80 GB disk there), while the PATA and second SATA ports are marked
`OFF'.

Just to be sure, I also tried acpi=off and pci=noacpi, but no avail.

Do you have a clue? Would it help to try 2.6.6?

Thanks for all suggestions!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
