Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271043AbTG1Usm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270824AbTG1UqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:46:16 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:6879 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S271036AbTG1UpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:45:17 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <linux-kernel@vger.kernel.org>, "Mark Hahn" <hahn@physics.mcmaster.ca>
Subject: RE: Problems related to DMA or DDR memory on Intel 845 chipset?
Date: Mon, 28 Jul 2003 16:56:42 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGGEJBCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0307281610170.25853-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark,

>> then "hang".  I had discovered that upon this failure, the logic analyzer
>> shows that our device is asserting the interrupt.  However, I also found
(by
>> adding my own debug to the kernel) that the 8259 Programmable Interrupt
>> Controller never received the interrupt (it's bit was not set in the

>OK, so the problem is strictly on the PCI bus, between your device
>and the PIC (or apic?)

That would appear to be the case. But as I said, it appears to be a nasty
side affect from something that has gone wrong during a DMA transfer.  BTW,
we are using PIC

>> interrupt on the device).  At this point of failure, no other IRQs are
>> getting through, so the system appears to be completely hard hung even
>> though various software components are still running.  We are operating
in a

>so why do you think this is a software problem?

I made this posting to see if anyone else has had problems with this
hardware or to see if there were any known issues similar to what I've
found.

>> employs the DDR memory technology) running Linux 2.4.20-8.   Further
testing
>> has shown that "not receiving an interrupt" is just a nasty side affect
from
>> something that has gone wrong during a DMA transfer by our device.  This
was
>> discovered when I changed the driver to poll for a DMA completion rather
>> than have it interrupt me.  Our system still hung.  We are have tried

>that one mystifies me: how do you conclude the problem is a broken
>DMA transfer if, when you convert to polling, the problem remains?

Why?  The device is _still_ a DMA device.  In this particular test I told it
to initiate the DMA, but I did not enable it's ability to interrupt me when
it was finished with the DMA.  I poll to watch for it's completion.

>my conclusion would be that your device has somehow managed to lock
>up the PIC's state-machine, or is somehow playing nasty with the bus.

I haven't ruled that out.

. . . Meanwhile, I made another discovery on the internet that indicates
that DMA is not supported with an ICH4 controller (which is what this system
has) until Linux version 2.5.12 (we're using 2.4.20-8).  See:
http://64.143.3.64/downloads/drivers/845/perform/linux/udma.htm.  I posted a
question concerning this to linux-kernel.  See thread:  DMA not supported
with Intel ICH4 I/O controller?  Unfortunately, I have not received any
response that supports or refutes this.  Any thoughts?

Thanks,
Kathy

