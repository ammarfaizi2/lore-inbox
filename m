Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314635AbSEBQZ7>; Thu, 2 May 2002 12:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSEBQZ6>; Thu, 2 May 2002 12:25:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65036 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314635AbSEBQZ6>; Thu, 2 May 2002 12:25:58 -0400
Subject: Re: devfs: BKL *not* taken while opening devices
To: arjanv@redhat.com (Arjan van de Ven)
Date: Thu, 2 May 2002 17:44:15 +0100 (BST)
Cc: zippel@linux-m68k.org (Roman Zippel), arjanv@redhat.com (Arjan van de Ven),
        haveblue@us.ibm.com (Dave Hansen), linux-kernel@vger.kernel.org
In-Reply-To: <20020429134659.A26165@devserv.devel.redhat.com> from "Arjan van de Ven" at Apr 29, 2002 01:46:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173Jgl-0004Iu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The BKL doesn't make a driver safe, remember that it's released on
> > schedule.
> 
> I know. But a LOT of in kernel and out-of kernel drives don't schedule
> in open and are therefore safe right now

I looked at this for video4linux and for watchdog drivers. The score was
something like 80% buggy 20% correct. Remember things like request_irq
can schedule.

Fix the drivers, even if they get fixed before the lock is removed
