Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274171AbRI3UpI>; Sun, 30 Sep 2001 16:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274172AbRI3Uo6>; Sun, 30 Sep 2001 16:44:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20744 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274171AbRI3Uop>; Sun, 30 Sep 2001 16:44:45 -0400
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
To: mjustice@austin.rr.com
Date: Sun, 30 Sep 2001 21:50:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, timm@fnal.gov
In-Reply-To: <01093015371606.00965@bozo> from "Marvin Justice" at Sep 30, 2001 03:37:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nnXL-0007aB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Curious - OSB4 thinks the DMA is still running.
> OSB4 wait exit

This is an OSB4 trap for a problem I've seen with seagate drivers on some
boxes. Under very high load with UDMA seagate drives the OSB4 returns to
us with the chip reporting DMA in progress. The next I/O after this will
cause disk corruption as it DMA's the last 4 bytes of the previous write,
then the data shifted up by 4 bytes until the end of that I/O. I need
to confirm nobody else is seeing this with other working workloads, then
I'll swap it for a panic - better to die than kill the disc contents.

Serverworks have been looking at the problem but have yet to duplicate it.
As far as we can tell (and Red Hat have been working with a customer on this
directly) your choices are

1.	Use multiword DMA not UDMA
2.	Use non seagate disks with that controller

I am hopeful that serverworks will figure out what is up, but not every box
sees it - and indeed they've yet to be able to reproduce it.


Alan
