Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269978AbTG1Ogz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 10:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbTG1Ogy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 10:36:54 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:46812 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S269978AbTG1Ogx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 10:36:53 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problems related to DMA or DDR memory on Intel 845 chipset?
Date: Mon, 28 Jul 2003 11:03:36 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGEEIACDAA.kfrazier@mdc-dayton.com>
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

Hello all,

I posted a message a few weeks back concerning a problem I was having with
our device not receiving interrupts.  Our system will run for awhile and
then "hang".  I had discovered that upon this failure, the logic analyzer
shows that our device is asserting the interrupt.  However, I also found (by
adding my own debug to the kernel) that the 8259 Programmable Interrupt
Controller never received the interrupt (it's bit was not set in the
Interrupt Request Register, nor did I ever reach my ISR to clear the
interrupt on the device).  At this point of failure, no other IRQs are
getting through, so the system appears to be completely hard hung even
though various software components are still running.  We are operating in a
system with an ASUS P4PE motherboard (uses the Intel 845PE chipset and
employs the DDR memory technology) running Linux 2.4.20-8.   Further testing
has shown that "not receiving an interrupt" is just a nasty side affect from
something that has gone wrong during a DMA transfer by our device.  This was
discovered when I changed the driver to poll for a DMA completion rather
than have it interrupt me.  Our system still hung.  We are have tried
tweaking various BIOS settings (set memory freq, DDR reference voltage, PCI
latency amoung others) but have not had any luck.  We also tried some slower
DDR memory without luck.  Another thing worth mentioning:  When I built a
debug version of the kernel, I turned on several of the kernel hacking
features and added some of my own debug in the do_IRQ routine.  I had a user
application query a new home grown debug routine in the kernel (via another
driver) to see what the status was with respect to the interrupt I was
watching and the state of the 8259.  All of this changed the timing enough
that the system would complete a 3 hour test instead of the usual case in
which it dies in minutes under a non-debug kernel.  Also, our device and
software work fine in a Pentium III system (using Intel 815E chipset with
133/100 MHz SDRAM) with the same (non-debug) version of Linux.  So it seems
that this problem is sensitive to timing/speed.

In posting this, I'm hoping that someone may be able to lend some advice on
the situation.  I have seen some past threads on this mailing list dealing
with issues of IDE DMA problems with Intel 845 chipset in version 2.4.19 of
the kernel.  There were evidently some patches to this version (-ac1
through -ac3) which address these problems.  Did these changes make it to
2.4.20?  Or could the problem be due to the faster DDR memory?  I have seen
some references to the memtest86 tool, but I'm not sure if that would shed
any light on this problem.  I've downloaded, but have not tried it yet.  Any
advice is welcome.  Please let me know if I can provide you with any
additional information.

Thanks in advance for your help.


Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com



