Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263747AbRFCTyR>; Sun, 3 Jun 2001 15:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263748AbRFCTyH>; Sun, 3 Jun 2001 15:54:07 -0400
Received: from front3m.grolier.fr ([195.36.216.53]:60125 "EHLO
	front3m.grolier.fr") by vger.kernel.org with ESMTP
	id <S263747AbRFCTxz> convert rfc822-to-8bit; Sun, 3 Jun 2001 15:53:55 -0400
Date: Sun, 3 Jun 2001 18:38:27 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Matthias Schniedermeyer <ms@citd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI-CD-Writer don't show up
In-Reply-To: <Pine.LNX.4.20.0106020917560.13579-100000@citd.owl.de>
Message-ID: <Pine.LNX.4.10.10106031820370.1735-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Jun 2001, Matthias Schniedermeyer wrote:

> #Include <hallo.h>
> 
> 
> 
> I have 3 SCSI-CD-Writers. "Strange" is that the boot-process only finds
> the first one (1 0 5 0), the other two i have to add with
> 
> echo "scsi add-single-device 2 0 4 0" > /proc/scsi/scsi
> echo "scsi add-single-device 2 0 6 0" > /proc/scsi/scsi
> 
> to make them useable.
> 
> Here is the complete ist of my SCSI-Devices:
> 
> Host: scsi0 Channel: 00 Id: 06 Lun: 00
>   Vendor: IBM      Model: DDYS-T18350N     Rev: S93E
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 01 Lun: 00
>   Vendor: PIONEER  Model: DVD-ROM DVD-303  Rev: 1.10
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 05 Lun: 00
>   Vendor: TEAC     Model: CD-R58S          Rev: 1.0N
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi2 Channel: 00 Id: 02 Lun: 00
>   Vendor: PIONEER  Model: DVD-ROM DVD-304  Rev: 1.03
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi2 Channel: 00 Id: 03 Lun: 00
>   Vendor: PIONEER  Model: DVD-ROM DVD-304  Rev: 1.03
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi2 Channel: 00 Id: 04 Lun: 00
>   Vendor: TEAC     Model: CD-R58S          Rev: 1.0K
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi2 Channel: 00 Id: 06 Lun: 00
>   Vendor: TEAC     Model: CD-R58S          Rev: 1.0P
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> 
> I have a "Symbios 53c1010 (Dual Channel Ultra 160)" and a "NCR 810a" The
> two devices which are not found are connected through adapters onto the
> second channel of the Symbios 53c1010.
> 
> Kernel is 2.4.4 or 2.4.5ac6. 
> As host-adapter-driver i use the "SYM53C8XX"-driver
> 
> If other info is needed, no problem. :-)

You should check if your devices are enabled for SCAN in the NVRAM.

Devices that aren't enabled for "SCAN AT BOOT" are forced by the driver to
fail the initial SCSI scan. As a plus, the driver also applies the boot
order for all Symbios HBAs that look Symbios-compatible regarding GPIO
pins and NVRAM layout.

For such subset of SCSI BUSes, this allows to present SCSI devices to the
kernel in the same order as BIOS saw them. On the other hand, this may
speed-up the system boot process a lot. If you had numerous O/Ses
installed on a single system, you would appreciate as useful it is. For
example, I use to boot an O/S with only drive 80 seen by BIOS and sda seen
by system, and then mount the other disks in the order I want.

  Gérard.

PS: See README.ncr53c8xx for the way to disable this feature if it does
    not fit your expectation. :)

