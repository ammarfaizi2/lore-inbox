Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292961AbSCIVu0>; Sat, 9 Mar 2002 16:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSCIVuP>; Sat, 9 Mar 2002 16:50:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26122 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292956AbSCIVuC>; Sat, 9 Mar 2002 16:50:02 -0500
Subject: Re: Suspend support for IDE
To: pavel@ucw.cz (Pavel Machek)
Date: Sat, 9 Mar 2002 22:05:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20020309210319.GA691@elf.ucw.cz> from "Pavel Machek" at Mar 09, 2002 10:03:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16joxm-0002g6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wake from S3 or S4 should look like power-up from disks perspective. I
> should need no commands to do that.

Assuming the BIOS didn't do the work you need to bring the disks up as
if you were the BIOS. That means doing the controller configuration, waking
the drive as per ATA6. What does ACPI guarantee here ? If ACPI brough the
drive back into its "happy bios state" then I agree you are right. If its
like an APM resume from suspend to ram then its not always so clear cut.

Also there is the some fun about buggy drives and power up happenings. On no
account can you issue any command that might touch the platter unless you
know the drive is at full running speed when spinning up certain old drives
because the firmware in some cases forgets to check the drive is at speed
and you physically destroy the disk over time. Thankfully thats old old
drives (540Mb quantum if I remember rightly)

> > then flush the disk cache, then when it completes you can tell the
> > drive
> 
> Disks that need cache flush are broken, anyway -- they lied us on
> command completion -- right?

Wrong. Please read the spec. If you are going to be the IDE maintainer you are
wasting your time until you read and understand the specifications. If you
don't do the cache flush you will lose data on some drives. An IDE drive
is permitted to keep a write back cache. Forced writes to the media are in an
upcoming IDE command set draft (although in general you can half fake that
with a read and verify).

> Why should I tell the drive to power down? It is going to loose its
> power, anyway (I believe in both S3 and S4).

So it can shut itself down nicely and do any housework it wants to do
(like flushing the cache if the cache flush command isnt supported.. its
 optional in older ATA standards)

> > On some systems you want to drop it back to PIO0 non DMA
> > before the powerdown or S4BIOS restore from disk will fail.
> 
> S4BIOS is not on my list just now; agreed it would be better.

Alan
