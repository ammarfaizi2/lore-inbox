Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135568AbRDXLyd>; Tue, 24 Apr 2001 07:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135559AbRDXLyC>; Tue, 24 Apr 2001 07:54:02 -0400
Received: from mail.informatik.uni-ulm.de ([134.60.68.63]:17474 "EHLO
	mail.informatik.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S135556AbRDXLxs>; Tue, 24 Apr 2001 07:53:48 -0400
Message-ID: <3AE56932.A62BF389@student.uni-ulm.de>
Date: Tue, 24 Apr 2001 13:53:22 +0200
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
Organization: University of Ulm
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: de,de-DE,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: AHA-154X/1535 not recognized any more [Repost]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As my original message seems to have disappeared, here a Repost:

-------- Original Message --------
Subject: Re: AHA-154X/1535 not recognized any more
Date: Fri, 20 Apr 2001 14:28:14 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
CC: Markus Schaber <markus.schaber@student.uni-ulm.de>,Alan Cox
<alan@lxorguk.ukuu.org.uk>,Linux Kernel Mailing List
<linux-kernel@vger.kernel.org>

On Wed, 18 Apr 2001, Rafael E. Herrera wrote:

> > lunix:~# isapnp pnpconfig.txt
> > Board 1 has Identity 08 0f 6d b9 45 42 15 90 04:  ADP1542 Serial No 258849093 [checksum 08]
> > pnptext:60 -- Fatal - IO range check attempted while device activated
> > pnptext:60 -- Fatal - Error occurred executing request '<IORESCHECK> ' --- further action aborted
>
> I've a pnp sound card that fails to configure with a similar error
> message when a (CHECK) entry was found in an (IO ...) block. Removing
> those entries solved the problem. Try this in your pnpconfig.txt:
>
> (IO 0 (SIZE 4) (BASE 0x0330))

In this case, isapnp configures the card.

Using a modularized kernel, modprobe also loads the driver without any
further parameters:

lunix:/home/schabi/public_html/scsi# /rescue/sbin/isapnp
pnpconfig_nocheck.txt
Board 1 has Identity 08 0f 6d b9 45 42 15 90 04:  ADP1542 Serial No
258849093 [checksum 08]
ADP1542/258849093[0]{SCSI Host Adapter   }: Port 0x330; IRQ10 DMA0 ---
Enabled OK
lunix:/home/schabi/public_html/scsi# modprobe aha1542
lunix:/home/schabi/public_html/scsi#
ls /proc/scsi
advansys  aha1542  ide-scsi  scsi  sg
lunix:/home/schabi/public_html/scsi# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW8424S         Rev: 1.0j
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: 03.H
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: SAMSUNG  Model: CD-ROM SCR-3231  Rev: S104
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100 PLUS     Rev: J.66
  Type:   Direct-Access                    ANSI SCSI revision: 02

So the isapnp tools can configure the card correctly.

markus
