Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUKOMln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUKOMln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 07:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUKOMlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 07:41:42 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:55695 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261580AbUKOMli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 07:41:38 -0500
Message-ID: <4198A3F9.3070107@g-house.de>
Date: Mon, 15 Nov 2004 13:41:29 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Matt Domsch <Matt_Domsch@dell.com>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.10-rc1 (solved)
References: <200411122248_MC3-1-8E97-BFE5@compuserve.com> <20041113142835.GA9109@lists.us.dell.com> <20041114025814.GA20342@lists.us.dell.com> <4197B9D9.9010806@g-house.de> <20041114215521.GA9717@lists.us.dell.com>
In-Reply-To: <20041114215521.GA9717@lists.us.dell.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matt Domsch schrieb:
> 
> OK, the patch below (which Linus applied to his tree yesterday) should
> fix the oopses.
>  

so i've compiled a pristine 2.6.10-rc1-bk24 as your patch should be
included there (i've tried to apply your patch with --dry-run -> it did
not succeed, -R *would* have been successful) and finally it works!

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.10-rc1-bk24.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.10-rc1-bk24

snd_ens1371 is working fine, no oops, i can load/unload the drivers, no
problems ;-)

> 
>>BIOS EDD facility v0.16 2004-Jun-25, 16 devices found
> 
> but the patch to edd.S doesn't resolve that EDD believes you've got 16
> devices (I would expect it to report 2, as you have only 2 disks).

but still:

BIOS EDD facility v0.16 2004-Jun-25, 6 devices found

i have 2 disks now (1 ide, 1 scsi), 2 cdrom drives (ide). as you can see
from the dmesg, i have an additional ide-controller onboard:

PDC20265: chipset revision 2
PDC20265: ROM enabled at 0xdffe0000
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: ST320413A, ATA DISK drive
ide2 at 0xbc00-0xbc07,0xb802 on irq 10
Probing IDE interface ide3...
Probing IDE interface ide1...
Probing IDE interface ide3...
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !

but there are only 4 ide channels on my board (Gigabyte GA7ZXR):
ide0  - with hda+hdb connected (2x cdrom)
ide1  - none
ide2  - with hde connected (ST320413A)
ide3  - none

so it's probing for a non-existent ide4+ide5! but it did that even in -bk4
times, so it's not "new behaviour", i guess.

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.9-bk4.txt

anyway, it's working now, the oops is gone, but i can do further testing
regarding this EDD issue of course.

Thanks to all involved,
Christian.
- --
BOFH excuse #195:

We only support a 28000 bps connection.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBmKP4+A7rjkF8z0wRAooxAJ9dD5QEXsEPUJjlBNvtfhtPteGoNwCfdfCA
tsYq86N5Y/bpegSXYWS+nkw=
=kFOh
-----END PGP SIGNATURE-----
