Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVJ0O1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVJ0O1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJ0O1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 10:27:04 -0400
Received: from smtp.rol.ru ([194.67.1.9]:3695 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S1750762AbVJ0O1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 10:27:02 -0400
Message-ID: <4360E3A0.70501@rol.ru>
Date: Thu, 27 Oct 2005 18:26:40 +0400
From: Eugene Crosser <crosser@rol.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org, multiman@rol.ru,
       linux-kernel@vger.kernel.org
Subject: Re: Status of Marvell SATA driver (was Re: Trying latest sata_mv
 - and getting freeze)
References: <435F8AFF.3030404@rol.ru> <435F9737.3050409@emc.com> <435FA5D8.2090406@rol.ru> <20051027111650.GO4774@suse.de>
In-Reply-To: <20051027111650.GO4774@suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0E24654BE5E1188264E273F2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E24654BE5E1188264E273F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

>>>>My hardware is SMP Supermicro with 6 disks on
>>>>Marvell MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
>>>>and the sata_mv.c is version 0.25 dated 22 Oct 2005
>>>>
>>>>The thing works with "old" mvsata340 driver, but the "new" kernel with
>>>>your driver freezes when it starts to probe disks.  Even Magic SysRq
>>>>does not work.  The last lines I see on screen are like this:
>>>>
>>>>sata_mv version 0.25
>>>>ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 185
>>>>sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via MSI
>>>>ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 185
>>>>ata2: .... <same things>            0xF8C24120 ...
>>>>...
>>>>ata8: .... <same thing>             0xF8C38120 ...
>>>>ATA: abnormal status 0x80 on port 0xF8C2211C
>>>>... <five more lines identical to the above>
>>>>ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
>>>>
>>>>- and at this point it freezes hard.
>>>>Any suggestions for me?  Any information I can collect to help
>>>>troubleshooting?
>>
>>[...]
>>
>>>In the meantime, try turning off SMP and seeing if that makes a
>>>difference.  There still might be a problem with the spinlocks and if so
>>>it should go away in uniprocessor mode.
>>
>>'nosmp' makes no difference.
> 
> 
> Booting with nosmp isn't enough, you need to compile the kernel with
> CONFIG_SMP turned off. Otherwise the spinlocks will still be used and
> could cause a hard hang.

Yeah, that was it!  It boots with the kernel compiled for UP.
(did not yet have a chance to check how it works).
Any chance that somebody competent would fix the driver for SMP?

Eugene

--------------enig0E24654BE5E1188264E273F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDYOOktQFsU5rTNjcRAoSAAJ42coGoCdTtyiI6HXZeP07PfFDb/gCdFocQ
doKATy59wG88nGZr3q1GSr8=
=3MEm
-----END PGP SIGNATURE-----

--------------enig0E24654BE5E1188264E273F2--
