Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279518AbRJ3J01>; Tue, 30 Oct 2001 04:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279515AbRJ3J0S>; Tue, 30 Oct 2001 04:26:18 -0500
Received: from inje.iskon.hr ([213.191.128.16]:26776 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S279496AbRJ3J0F>;
	Tue, 30 Oct 2001 04:26:05 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <E15xu2b-0008QL-00@the-village.bc.nu>
	<Pine.LNX.4.33.0110280945150.7360-100000@penguin.transmeta.com>
	<20011030095606.I618@suse.de>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 30 Oct 2001 10:26:32 +0100
In-Reply-To: <20011030095606.I618@suse.de> (Jens Axboe's message of "Tue, 30 Oct 2001 09:56:06 +0100")
Message-ID: <dn7ktdpjg7.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Jens Axboe <axboe@suse.de> writes:

> hpt366 has no special work arounds or stuff it disables, it can't be
> anything like that.
> 

Followup on the problem. Yesterday I was upgrading my Debian Linux. To
do that I have to remount /usr read-write. After the update finished,
I tested once again disk writing speed. And there it was, full
22MB/sec (on the same partition). And once I get to that point, disk
will remain performant. Then I thought (poor man's logic) that poor
performance might have something to do with my /usr mounted read-only
(BTW, it's on the same disk I'm having problems with).

Quick test: reboot (/usr is ro), check speed -> only 8MB/sec, remount
/usr rw, but unfortunately didn't help, writing speed remains low.

So it was just an idea. I still don't know what can be done to return
speed to normal. I don't know if I have mentioned, but reading from
the same disk is always going at the full speed.

Also, I'm pretty sure that I have the same problem on the completely
another machine (at the work) which doesn't use HPT366, but standard
controller (BX chipset).

So, something might be wrong with my setup, but I'm still unable to
find what.

I'm compiling with 2.95.4 20011006 (Debian prerelease) from the Debian
unstable distribution. Kernel is completely monolithic (no modules).

Attached is the _relevant_ part of IDE configuration.


--=-=-=
Content-Disposition: attachment; filename=A

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

--=-=-=


-- 
Zlatko

--=-=-=--
