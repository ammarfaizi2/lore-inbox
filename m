Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbQJ3Sxv>; Mon, 30 Oct 2000 13:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbQJ3Sxl>; Mon, 30 Oct 2000 13:53:41 -0500
Received: from deckard.concept-micro.com ([62.161.229.193]:9570 "EHLO
	deckard.concept-micro.com") by vger.kernel.org with ESMTP
	id <S129112AbQJ3Sxe>; Mon, 30 Oct 2000 13:53:34 -0500
Message-ID: <XFMail.20001030195540.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <39FD9A2D.951BB5A7@haque.net>
Date: Mon, 30 Oct 2000 19:55:40 +0100 (CET)
X-Face: #eTSL0BRng*(!i1R^[)oey6`SJHR{3Sf4dc;"=af8%%;d"%\#"Hh0#lYfJBcm28zu3r^/H^
 d6!9/eElH'p0'*,L3jz_UHGw"+[c1~ceJxAr(^+{(}|DTZ"],r[jSnwQz$/K&@MT^?J#p"n[J>^O[\
 "%*lo](u?0p=T:P9g(ta[hH@uvv
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: Mohammad Haque <mhaque@haque.net>
Subject: Re: ide/disk perf?
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 30-Oct-2000, Mohammad Haque écrivait :
> At the bottom is the IDE/ATA part of my .config. let me knwo if I am
> missing something. Should I worry about the Multi_Mode configuration?

I have it enabled, however I never used any HPT366 controller, so YMMV. 
The BX chipset is what I tested the most.

># ATA/IDE/MFM/RLL support
>#
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
># CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_OFFBOARD=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_HPT366=y
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_PIIX_TUNING=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y

Looks very similar to my own settings

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y


But I only do 

        hdparm -qu1c1k1 idedevice

at boot time. Also, I've found 

        append="ide0=autotune ide1=autotune"

in my lilo.conf, left from earlier testing session. Remarks in ide.c say it
only has influence on PIO modes, so unless the comment is obsolete I guess I
could as well remove that line.

Best regards,
Pierre.


-- 
Linux blade.workgroup 2.4.0-test10 #1 Mon Oct 30 15:30:15 CET 2000 i686 unknown
  7:55pm  up  4:12,  5 users,  load average: 1.11, 1.20, 1.38

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
