Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWJBNxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWJBNxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWJBNxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:53:03 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:39338 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S932340AbWJBNxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:53:00 -0400
Message-Id: <200610021352.k92DqRwa015220@cmf.nrl.navy.mil>
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, mac@melware.de,
       markus.lidel@shadowconnect.com, samuel@sortiz.org,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       Greg KH <greg@kroah.com>, thomas@winischhofer.net, ak@suse.de
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Subject: Re: [PATCH] Introduce BROKEN_ON_64BIT facility 
In-reply-to: <20061002045512.GA8835@havoc.gtf.org> 
Date: Mon, 02 Oct 2006 09:52:27 -0400
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20061002045512.GA8835@havoc.gtf.org>,Jeff Garzik writes:
>Several driver have been marked as dependent on CONFIG_32BIT in the
>past, when they should really be dependent on this new
>CONFIG_BROKEN_ON_64BIT option, because the 32BIT marker was due to bugs
>rather than fundamentals.

some of the drivers in atm are already marked with !64BIT and some
need to be marked.  this might be more complete for drivers/atm/Kconfig:

diff --git a/drivers/atm/Kconfig b/drivers/atm/Kconfig
index cfa5af8..f4e0978 100644
--- a/drivers/atm/Kconfig
+++ b/drivers/atm/Kconfig
@@ -139,7 +139,7 @@ config ATM_ENI_BURST_RX_2W
 
 config ATM_FIRESTREAM
 	tristate "Fujitsu FireStream (FS50/FS155) "
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_64BIT
 	help
 	  Driver for the Fujitsu FireStream 155 (MB86697) and
 	  FireStream 50 (MB86695) ATM PCI chips.
@@ -149,7 +149,7 @@ config ATM_FIRESTREAM
 
 config ATM_ZATM
 	tristate "ZeitNet ZN1221/ZN1225"
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_64BIT
 	help
 	  Driver for the ZeitNet ZN1221 (MMF) and ZN1225 (UTP-5) 155 Mbps ATM
 	  adapters.
@@ -173,7 +173,7 @@ #      bool '  Enable extended debugging
 #   fi
 config ATM_NICSTAR
 	tristate "IDT 77201 (NICStAR) (ForeRunnerLE)"
-	depends on PCI && ATM && !64BIT
+	depends on PCI && ATM && BROKEN_ON_64BIT
 	help
 	  The NICStAR chipset family is used in a large number of ATM NICs for
 	  25 and for 155 Mbps, including IDT cards and the Fore ForeRunnerLE
@@ -241,7 +241,7 @@ config ATM_IDT77252_USE_SUNI
 
 config ATM_AMBASSADOR
 	tristate "Madge Ambassador (Collage PCI 155 Server)"
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_64BIT
 	help
 	  This is a driver for ATMizer based ATM card produced by Madge
 	  Networks Ltd. Say Y (or M to compile as a module named ambassador)
@@ -265,7 +265,7 @@ config ATM_AMBASSADOR_DEBUG
 
 config ATM_HORIZON
 	tristate "Madge Horizon [Ultra] (Collage PCI 25 and Collage PCI 155 Client)"
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_64BIT
 	help
 	  This is a driver for the Horizon chipset ATM adapter cards once
 	  produced by Madge Networks Ltd. Say Y (or M to compile as a module
@@ -289,7 +289,7 @@ config ATM_HORIZON_DEBUG
 
 config ATM_IA
 	tristate "Interphase ATM PCI x575/x525/x531"
-	depends on PCI && ATM && !64BIT
+	depends on PCI && ATM && BROKEN_ON_64BIT
 	---help---
 	  This is a driver for the Interphase (i)ChipSAR adapter cards
 	  which include a variety of variants in term of the size of the
