Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313578AbSEHMYN>; Wed, 8 May 2002 08:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313690AbSEHMYM>; Wed, 8 May 2002 08:24:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55821 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313578AbSEHMYL>; Wed, 8 May 2002 08:24:11 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 8 May 2002 13:42:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        padraig@antefacto.com (Padraig Brady),
        aia21@cantab.net (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CD9075C.6080505@evision-ventures.com> from "Martin Dalecki" at May 08, 2002 01:09:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175QmK-0001V8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Make hdX gone and use the scsi device major/minor number stuff instead.
> And then just making the ATA driver looking like if it where some
> incapable SCSI would actually reduce tons of code from kudzu and
> friends without the need for any adjustment there.

The SCSI layer is significant overhead even in 2.5. Right now for example
it appears to be the primary bottleneck for the aacraid drivers.  ATA6 is
also more capable than SCSI in several areas regardless of the notional
market positioning.

Linus talked about having a /dev/disc/... which once you have 32bit dev_t
makes complete sense. What you don't do however is throw IDE through the
SCSI midlayer, you merely make the /dev/disc/ point call into the right
drivers - be they raid, scsi or ide. That also lets the scsi emulation
crap get ripped out of the megaraid and aacraid drivers which will up
performance.

Alan

