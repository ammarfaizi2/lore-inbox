Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268566AbTGIWL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268568AbTGIWL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:11:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25283 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268566AbTGIWL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:11:27 -0400
Date: Wed, 9 Jul 2003 15:25:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
In-Reply-To: <3F0C9251.2010107@pobox.com>
Message-ID: <Pine.LNX.4.44.0307091520570.16947-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jul 2003, Jeff Garzik wrote:
> 
> I'm curious where interrupts are re-enabled, though?

The low-level drivers seem to do it at every IO. Don't ask me why. But it 
gets done automatically by any code that does

	hwif->OUTB(drive->ctl, IDE_CONTROL_REG);

which is pretty common (just grep for "IDE_CONTROL_REG" and you'll see 
what I mean).

I note that I should have made this "disable irq" be dependent on 
IDE_CONTROL_REG being non-zero. Although I don't see when that register 
_can_ be zero, it would be a major bummer not to have access to the 
control register.

(Obviously it must be zero for some architecture, though, or those
conditionals woulnd't make sense. Alan?  Bartlomiej? What kind of sick
pseudo-IDE controller doesn't have a control register?).

			Linus

