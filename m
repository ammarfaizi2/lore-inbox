Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313476AbSC2QDq>; Fri, 29 Mar 2002 11:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313472AbSC2QD1>; Fri, 29 Mar 2002 11:03:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23818 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313473AbSC2QDX>; Fri, 29 Mar 2002 11:03:23 -0500
Subject: Re: 2.4.19-pre4-ac[23] do not boot
To: jean-luc.coulon@wanadoo.fr (Jean-Luc Coulon)
Date: Fri, 29 Mar 2002 16:20:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CA486FF.5003AA42@wanadoo.fr> from "Jean-Luc Coulon" at Mar 29, 2002 04:23:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qz6l-0001Ud-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19-pre4-ac[23] does not boot. I've not tested ac1 but vanilla pre4
> works.

Can you try backing out the following two changes, one at a time. These are
the only ALi specific changes. So firstly I want to see if its an ALi or
core IDE bug

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.19p4/drivers/ide/alim15x3.c linux.19pre4-ac3/drivers/ide/alim15x3.c
--- linux.19p4/drivers/ide/alim15x3.c	Mon Mar 25 17:47:11 2002
+++ linux.19pre4-ac3/drivers/ide/alim15x3.c	Tue Mar 26 18:36:23 2002
@@ -248,7 +248,7 @@
 	byte s_clc, a_clc, r_clc;
 	unsigned long flags;
 	int bus_speed = system_bus_clock();
-	int port = hwif->index ? 0x5c : 0x58;
+	int port = hwif->channel ? 0x5c : 0x58;
 	int portFIFO = hwif->channel ? 0x55 : 0x54;
 	byte cd_dma_fifo = 0;
 
@@ -442,6 +442,8 @@
 	ide_dma_action_t dma_func	= ide_dma_on;
 	byte can_ultra_dma		= ali15x3_can_ultra(drive);
 
+	(void) config_chipset_for_pio(drive);
+	
 	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
 		return hwif->dmaproc(ide_dma_off_quietly, drive);
 
