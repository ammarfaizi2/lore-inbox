Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317984AbSHKS2e>; Sun, 11 Aug 2002 14:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318008AbSHKS2d>; Sun, 11 Aug 2002 14:28:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:12532 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317984AbSHKS2d>; Sun, 11 Aug 2002 14:28:33 -0400
Subject: Re: 2.4.19 IDE Partition Check issue (again)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: steveb@unix.lancs.ac.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E17diPZ-0004bU-00@wing1.lancs.ac.uk>
References: <E17diPZ-0004bU-00@wing1.lancs.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Aug 2002 20:53:38 +0100
Message-Id: <1029095618.16216.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ALI15X3: IDE controller on PCI bus 00 dev 20
> PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
> ALI15X3: chipset revision 196

Perfect you have revision C4, you answered the outstanding mystery about
whether C4 is capable of LBA48 or its >C4 that is

Try this
--- drivers/ide/alim15x3.c~	2002-08-11 19:33:14.000000000 +0100
+++ drivers/ide/alim15x3.c	2002-08-11 19:33:14.000000000 +0100
@@ -810,7 +810,7 @@
 
 	/* Don't use LBA48 on ALi devices before rev 0xC4 */
 
-	if(m5229_revision < 0xC4)
+	if(m5229_revision <= 0xC4)
 		hwif->addressing = 1;
 
 }
