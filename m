Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310436AbSCTBQI>; Tue, 19 Mar 2002 20:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310963AbSCTBP6>; Tue, 19 Mar 2002 20:15:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23044 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310436AbSCTBPq>; Tue, 19 Mar 2002 20:15:46 -0500
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP (RH7.2)
To: ken@irridia.com (Ken Brownfield)
Date: Wed, 20 Mar 2002 01:31:46 +0000 (GMT)
Cc: m.knoblauch@TeraPort.de,
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20020319190211.B15811@asooo.flowerfire.com> from "Ken Brownfield" at Mar 19, 2002 07:02:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nUx8-0000w4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We're seeing this with Tyan 2410s and Seagate drives.  I think Tyan just
> can't get DMA right.  Luckily we mainly lost docs or man pages before we
> disabled DMA, although losing the rpm database sucked.  MDMA2 seems okay
> but we haven't tested it long enough to form a lasting impression.
> I'm actually patching the ServerWorks driver to honor the CONFIG flag,
> since even with hdparm there is a narrow risk to the fs during the boot
> process before DMA is disabled.

I can confirm problems with serverworks OSB4 and UDMA. With UDMA and
a seagate disk you see 4 bytes repeat from one transfer into the next
shuffling all the data up 4 bytes (which since it includes inode and
metadata is *messy*). Current 2.4 has detect code that sometimes traps this
and panics to avoid fs death.

With MWDMA all was fine.

This was observed across a large number of boxes in a rendering farm so its
not a one off flawed box, and across two board vendors. I reported it to
serverworks who were interested but couldnt reproduce it in their lab.
