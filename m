Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284336AbRLMQWa>; Thu, 13 Dec 2001 11:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284334AbRLMQWV>; Thu, 13 Dec 2001 11:22:21 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S284330AbRLMQWM>;
	Thu, 13 Dec 2001 11:22:12 -0500
Message-ID: <066801c183f2$53f90ec0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Thomas Capricelli" <orzel@kde.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011213160007.D998D23CCB@persephone.dmz.logatique.fr>
Subject: Re: Mounting a in-ROM filesystem efficiently
Date: Thu, 13 Dec 2001 11:22:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have maintained, on and off, a patch to crafms that supports traditional
cramfs decompress-and-read/run-from-RAM, plus direct mmaping with no
decompression and read/run straight out of ROM:

    http://www.ltc.com/~brad/mips/cramfs-linear-root-xip-linux-2.4.9-2.diff

It includes a modification to mkcramfs to compress or not compress
individual files based on their +t mode setting.  Mkcramfs will leave +t
uncompressed in the cramfs image and cramfs will directly mmap them.

Please note that the patch is against 2.4.9.  I haven't tried to use it
since then.

Regards,
Brad

----- Original Message -----
From: "Thomas Capricelli" <orzel@kde.org>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 13, 2001 11:02 AM
Subject: Mounting a in-ROM filesystem efficiently


>
>
> Hello,
>
> I'm looking for a way to put a filesystem into ROM.
> Seems pretty trivial, isn't it ?
>
> My understanding is (the way initrd does, and the way I do as of today)
> * create a RAMDISK
> * loads the data into ramdisk
> * mount the ramdisk
>
> problem is that I don't want to waste the RAM as the data in the ROM is
> already in the address space. (it's an embedded system, btw)
>
> Speed is not an issue here. ROM access might be slower than RAM, it will
> always be so much quicker than a disk access. (wrong?)
>
> Ideally, i would give address/length of the fs in ROM to a function, and I
> would get a ramdisk configured to read its data exactly there, and not in
> ram.
>
> Any hint ?
>
> I've tried to look in the different options from mainstream kernels and
> embedded-oriented kernels whithout success.
>
>
> thanx,
> Thomas
> ps : i'm subscribed to lkml, no need to cc:
>
> --
> Thomas Capricelli <orzel@kde.org>
> boson.eu.org, kvim, zetalinux-
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

