Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270143AbTGUOyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270148AbTGUOyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:54:18 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:8904 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S270143AbTGUOyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:54:10 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <linux-kernel@vger.kernel.org>
Cc: <bullet.train@ntlworld.com>, <no_spam@ntlworld.com>
Subject: Re: Fwd: Missing interrupts?
Date: Mon, 21 Jul 2003 11:20:07 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGCEFOCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your posting caught my eye, as I am currently having a problem with a device
driver not receiving interrupts on a Pentium 4 system.  In the debugging
process we found that our board is asserting it's interrupt, but my driver
never receives it (sound familiar?).  I added code to the linux kernel
(version 2.4.20-8) to determine if the IRQ was getting to the O/S once my
system hangs.  We found that not only is it NOT getting to the O/S, it never
even makes it to the 8259 Programmable Interrupt Controller.  Futhermore, it
appears that things on the motherboard are is such a bad state, that no
other interrupts are getting through (keyboard, mouse, network, etc).  This
same board and driver works fine in a Pentium 3 system.



>Machines test where everything worked: kernels 2.4.18-10 and 2.4.18-24.8.0
> on athlon based PCs


>Machine where interrupts failed to appear: kernel 2.4.18-3 on a pentium 4.

Are you running these tests using the same board?  You might try moving the
board for this device driver from the athlon PC to the pentium 4 PC just to
insure it is not a problem with the board.

>I register the interrupt on open with

>
err=request_irq(pi_stage.interrupt,pi_int_handler,SA_SHIRQ,PI_IRQ_ID,(void*)
> &pi_stage);

Is the value in pi_stage.interrupt assigned from the irq element of the
pci_dev structure (returned by pci_find_device routine)?  This is the
preferred way to obtain your IRQ rather than look directly at your device's
config space.

Even though you are indicating that you will share the IRQ, have you tried
adjusting BIOS settings or moving board to another slot to try to establish
a unique IRQ for yourself?  That would at least prevent another device
driver from getting in your way.

Just curious:  Are you receiving any interrupts at all in the pentium 4
system?  Or is it running for awhile and then missing some?  Does a missing
interrupt hang your system?



Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com



