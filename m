Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbSK1UrW>; Thu, 28 Nov 2002 15:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSK1UrW>; Thu, 28 Nov 2002 15:47:22 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:47593 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S266728AbSK1UrU>;
	Thu, 28 Nov 2002 15:47:20 -0500
Date: Thu, 28 Nov 2002 21:52:33 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc4-ac1
Message-ID: <20021128215233.B17357@fafner.intra.cogenit.fr>
References: <200211261901.gAQJ13T11036@devserv.devel.redhat.com> <20021128134332.GD6981@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021128134332.GD6981@fs.tum.de>; from bunk@fs.tum.de on Thu, Nov 28, 2002 at 02:43:32PM +0100
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> :
[non-modular iphase build broken]

drivers/atm/atmdev_init.c
[...]
/*
 * For historical reasons, atmdev_init returns the number of devices found.
 * Note that some detections may not go via atmdev_init (e.g. eni.c), so this
 * number is meaningless.
 */

pci_dev style init does the job. Trivial patch + dmesg output follows.

Linux version 2.4.20-rc4-ac1 (romieu@aglae) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #3 SMP Thu Nov 28 21:36:30 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[...]
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
IA: 00-00-77-97-C0-29
IA: SUNI carrier detected

--- linux-2.4.20-rc4-ac1.orig/drivers/atm/atmdev_init.c	Thu Nov 28 20:29:23 2002
+++ linux-2.4.20-rc4-ac1/drivers/atm/atmdev_init.c	Thu Nov 28 20:31:37 2002
@@ -19,9 +19,6 @@ extern int amb_detect(void);
 #ifdef CONFIG_ATM_HORIZON
 extern int hrz_detect(void);
 #endif
-#ifdef CONFIG_ATM_IA
-extern int ia_detect(void);
-#endif
 #ifdef CONFIG_ATM_FORE200E
 extern int fore200e_detect(void);
 #endif
@@ -53,9 +50,6 @@ int __init atmdev_init(void)
 #ifdef CONFIG_ATM_HORIZON
 	devs += hrz_detect();
 #endif
-#ifdef CONFIG_ATM_IA
-	devs += ia_detect();
-#endif
 #ifdef CONFIG_ATM_FORE200E
 	devs += fore200e_detect();
 #endif
