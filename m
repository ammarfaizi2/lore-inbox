Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262503AbREUVtv>; Mon, 21 May 2001 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbREUVtl>; Mon, 21 May 2001 17:49:41 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:59088 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262501AbREUVti>;
	Mon, 21 May 2001 17:49:38 -0400
Date: Mon, 21 May 2001 23:49:14 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200105212149.XAA10612@harpo.it.uu.se>
To: camm@enhanced.com, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19+ide: corrupts ide tape output
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2001 14:49:55 -0400, Camm Maguire <camm@enhanced.com> wrote:

>Greetings!  2.2.19+ide, applied the patch because this box has a new
>Promise PDC20267 ide controller.  14GB HP Colorado tape drive.  Before
>we installed the new ide controller and patched the kernel, i.e. with
>unpatched 2.2.19 running on a different ide controller, this setup
>works just fine.  Now I get the following occasionally, which results
>in corrupted dumps to tape:
>
>May 21 10:27:47 intech9 kernel: hdh: status error: status=0x40 { DriveReady }
>May 21 10:27:47 intech9 kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted

You added a Promise Ultra100 PCI card, right?
>From what I hear, it doesn't support ATAPI devices well, only disks.
So if you moved the HP tape drive to the PDC, move it back to
the mainboard's IDE controller.
Also, don't disable the mainboard's controller thinking you can save
some interrupts that way. Andre Hedrick (Linux IDE guy) once wrote
that this could cause the PDC to grab IRQ 14, which had some nasty
side-effects.

(My main box runs with disks on a Promise Ultra100 card and
ATAPI CD-RW and tape on the mainboard's IDE (440BX) controller.
Both 2.2+ide and 2.4 work fine.)

/Mikael
