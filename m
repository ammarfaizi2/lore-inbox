Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292380AbSBUNpQ>; Thu, 21 Feb 2002 08:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292377AbSBUNpH>; Thu, 21 Feb 2002 08:45:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42756 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292380AbSBUNox>; Thu, 21 Feb 2002 08:44:53 -0500
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 21 Feb 2002 13:59:04 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C74C03C.4060403@evision-ventures.com> from "Martin Dalecki" at Feb 21, 2002 10:39:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dtkW-0006yW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the next round of IDE driver cleanups.

How about fixing the stuff you've already messed up (like putting the
drive present flags and the probe return back) ? The changes you made
to the init code also broke the framework so that 2.5 would eventually
let you do

	open("/dev/cdrom")
	read/write
	close("/dev/cdrom")
	open("/dev/sda")		/* Same device */
	burn a cd

without loading/unloading modules

I'm also confused how you plan to fix the hot swap case after your changes
because you've not allowed for the fact drives might be hot swapped while
you are suspended. The old code was careful to keep the hooks for that
ready.

Finally you forgot to update the MAINTAINER entry since you've now clearly
decided to walk over Andre and become the IDE maintainer

Alan
