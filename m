Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSD1Lp2>; Sun, 28 Apr 2002 07:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSD1Lp1>; Sun, 28 Apr 2002 07:45:27 -0400
Received: from smtp2.wanadoo.nl ([194.134.35.138]:10131 "EHLO smtp2.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S293510AbSD1Lp0>;
	Sun, 28 Apr 2002 07:45:26 -0400
Message-Id: <200204281145.g3SBjJJ20178@smtp2.wanadoo.nl>
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Dave Jones <davej@suse.de>
Subject: Re: Linux 2.5.10-dj1
Date: Sun, 28 Apr 2002 13:45:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020427030823.GA21608@suse.de> <200204271313.g3RDD4024060@smtp1.wanadoo.nl> <20020427155116.I14743@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 April 2002 15:51, Dave Jones wrote:
> On Sat, Apr 27, 2002 at 02:51:21PM +0200, Rudmer van Dijk wrote:
>  > compiled fine, but after booting the system does not respond to the
>  > keyboard (I can see the message "serio: i8042 KBD port at 0x60,0x64 irq
>  > 1" om my screen)
>
> There are some reports that ACPI is having a bad interaction with the
> keyboard controller. For now, disabling it may fix this.

I have no ACPI or APM enabled (mobo does not know what it is)

>  > The system also hangs after fscking my root partition (fsck completed
>  > without errors)
>  > After my harddisks went to sleep I switched the system off and after
>  > booting the kernel (2.4.19-pre7) panics (and the caps- and scroll-lock
>  > leds are blinking) as it can not mount the root fs due to the following
>  > errors: EXT2-fs error (device ide0(3,1)): ext2_check_descriptors: Block
>  > bitmap for group 0 not in group (block 0)!
>  > EXT2-fs: group descriptors corrupted!
>
> This is somewhat disturbing. I'll look over the VFS changes, but I'm not
> aware of anything added specifically to my tree that could cause this,
> so it may be either an ext2 issue in mainline, or one of the drivers.

It happens after fsck (1.27) examined the root partition (hda1) finished and 
the bootscripts executed the next command (fsck hdc1)
with exactly the same fsck on 2.4.19-pre7 everything is fine (after repairing 
the damage done in 2.5.10-dj1)

luckily I do not have a cdrom or floppy drive attached so it was easy to 
recover :), going to create a 'rescue' partition...

BTW, I had this same problem with 2.5.9-dj1... not tried with 2.5.9 or 2.5.10.

> IDE ? SCSI ?

IDE

frodo:~ # lspci
00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
00:11.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet 
LANCE] (rev 16)

IDE/ATA part of my .config:
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_IDEDMA_PCI is not set

CONFIG_BLK_DEV_IDEDMA_PCI and CONFIG_BLK_DEV_PIIX were set in 2.5.9-dj1 but 
that generated the same problem.

        Rudmer
