Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284979AbSAMPIM>; Sun, 13 Jan 2002 10:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285593AbSAMPIC>; Sun, 13 Jan 2002 10:08:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26887 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285134AbSAMPH5>; Sun, 13 Jan 2002 10:07:57 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Sun, 13 Jan 2002 15:19:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <3C418CCC.3854D76E@linux-m68k.org> from "Roman Zippel" at Jan 13, 2002 02:34:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PmQ7-0007CJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wouldn't say it gets it wrong, the driver also has to take a non irq
> spinlock anyway, so the window is quite small and even then the packet
> is only delayed.

Or you lose a pile of them

> But now I really have to look at that driver and try a more optimistic
> irq disabling approach, otherwise it will happily disable the most
> important shared interrupt on my Amiga for ages.

If you play with the code remember that the irq delivery on x86 is
asynchronous. You can disable the irq on the chip, synchronize_irq() on 
the result and very occasionally get the irq delivered after all of that
