Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135889AbRDTM2j>; Fri, 20 Apr 2001 08:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135888AbRDTM23>; Fri, 20 Apr 2001 08:28:29 -0400
Received: from sirius-giga.rz.uni-ulm.de ([134.60.246.36]:11225 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S135887AbRDTM2Y>; Fri, 20 Apr 2001 08:28:24 -0400
Date: Fri, 20 Apr 2001 14:28:14 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
cc: Markus Schaber <markus.schaber@student.uni-ulm.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AHA-154X/1535 not recognized any more
In-Reply-To: <3ADDB684.392B8AC1@neuronet.pitt.edu>
Message-ID: <Pine.SOL.4.33.0104201401110.11952-100000@lyra.rz.uni-ulm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

lunix:/home/schabi/public_html/scsi# /rescue/sbin/isapnp pnpconfig_nocheck.txt
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




