Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129727AbRBGTeD>; Wed, 7 Feb 2001 14:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbRBGTdx>; Wed, 7 Feb 2001 14:33:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47877 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129921AbRBGTdn>; Wed, 7 Feb 2001 14:33:43 -0500
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Wed, 7 Feb 2001 19:33:31 +0000 (GMT)
Cc: sajjad@vgkk.com (A.Sajjad Zaidi), linux-kernel@vger.kernel.org
In-Reply-To: <14CC6FFB19AD@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Feb 07, 2001 01:15:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QaLP-000184-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is known bug which I reported to Andre already. Open
> drivers/ide/ide.c in favorite text editor, and replace strange
> body of ide_delay_50ms() with simple mdelay(50). Promise driver
> invokes ide_delay_50ms with interrupts disabled, so it freezes
> here forever. If you have NMI watchdog, you'll get nice oopses.

Its a bug in the promise driver. ide_delay_50ms() is being friendly to the
rest of the box. If the reset path for the promise cant be polite then it
should use mdelay() itself.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
