Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSHKTFQ>; Sun, 11 Aug 2002 15:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318144AbSHKTFQ>; Sun, 11 Aug 2002 15:05:16 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:25432 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S318121AbSHKTFP>;
	Sun, 11 Aug 2002 15:05:15 -0400
From: <Hell.Surfers@cwctv.net>
To: steveb@unix.lancs.ac.uk, linux-kernel@vger.kernel.org
Date: Sun, 11 Aug 2002 20:08:55 +0100
Subject: RE:Re: 2.4.19 IDE Partition Check issue (again)
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1029092935422"
Message-ID: <09e824508190b82DTVMAIL1@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1029092935422
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

i have a liveEVAL cd (SuSE 7.3) and a maxtor hard disk et 686, it freezes on writing bootloader, hangs with a constantbeep.. I wonder if this is related...



On 	Sun, 11 Aug 2002 19:16:08 +0100 	steveb@unix.lancs.ac.uk wrote:

--1029092935422
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Sun, 11 Aug 2002 19:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSHKSMW>; Sun, 11 Aug 2002 14:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSHKSMW>; Sun, 11 Aug 2002 14:12:22 -0400
Received: from zooty.lancs.ac.uk ([148.88.16.231]:65508 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S316113AbSHKSMV>; Sun, 11 Aug 2002 14:12:21 -0400
Received: from wing0.lancs.ac.uk ([148.88.1.12])
	by zooty.lancs.ac.uk with esmtp (Exim 3.36 #1)
	id 17dxG5-0004gd-00
	for linux-kernel@vger.kernel.org; Sun, 11 Aug 2002 19:16:09 +0100
Received: from apache by wing0.lancs.ac.uk with local (Exim 3.22 #1)
	id 17dxG4-0008LS-00
	for linux-kernel@vger.kernel.org; Sun, 11 Aug 2002 19:16:08 +0100
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: steveb@unix.lancs.ac.uk
Date: Sun, 11 Aug 2002 19:16:08 +0100
Subject: Re: 2.4.19 IDE Partition Check issue (again)
To: linux-kernel@vger.kernel.org
Message-Id: <E17dxG4-0008LS-00@wing0.lancs.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

Some more on this...
at http://www.netzerver.com/downloads/software/firmware/readme320.txt
there's a reference to an issue with Maxtor drives.

They say:
>- Maxtor ATA/66 Disk Compatibility -
>  An ATA/66 disk compatibility issue has been identified and published
>  by Maxtor, which has provided a utility to correct it. The problem
>  manifests itself in one of two ways:
>
>     The system can hang during a power up,
>                   or
>     The system can hang during the first attempt to write to the
>     Maxtor IDE disk.
>
>  According to Maxtor, the incompatibility exists with, but is not
>  limited to, the following chipsets:
>
>     Intel 440TX, 440LX, 440BX
>     VIA 586A, 586B, 596, 686
>     SiS 5598, 5591, 5600, 530, 620
>     ALi 1543C, 1533A-J, 1543A-F
>
>  The host chipset and the Maxtor drives do not negotiate to the same
>  operating mode. It is necessary to force the drive to DMA/33 or
>  DMA/66 mode if using the DMA/66 channels.

Maxtor technical note 21006 (at http://www.maxtor.com/products/diamondmax/techsupport/technicalprocedures/21006.html)
seems to refer to this. There's a tool called UDMAUPDT that (presumably)
pokes the flash on the HDD to say what flavour of UDMA to claim support for.
I guess that you're meant to try all the values until you find one that
works.
I've just all the DMA modes on my drive, the tool seems to work (the
corresponding DMA mode is reported in the boot messages), but it still
fails in the same way - as soon as you try to do anything to the drive with
DMA enabled it goes into a big sulk.

My mobo is an ASUS A7A266, with the latest BIOS (v1011).

I've rejigged my server now - I've put the two drives that work with DMA enabled on to ide0, and the Maxtor and CDROM onto ide1. I'm booting 2.4.19-ac4 with ide=nodma (so that the thing will start) and then manually enabling DMA on hda and hdb with hdparm. Manually enabling DMA on the Maxtor still makes the IDE channel freeze (as does booting without ide=nodma), but it doesn't kill the machine outright now, so it's a bit easier to play with things.

I really do want to get DMA working on this drive (without DMA the performance is ~3.5MB/s as opposed to 40MB/s on the drives with DMA working). If anyone can suggest other things to prod I'd be extremely grateful...


Steve.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1029092935422--


