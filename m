Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136489AbRD3Q5B>; Mon, 30 Apr 2001 12:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136491AbRD3Q4w>; Mon, 30 Apr 2001 12:56:52 -0400
Received: from colorfullife.com ([216.156.138.34]:26631 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136489AbRD3Q4g>;
	Mon, 30 Apr 2001 12:56:36 -0400
Message-ID: <003901c0d196$89d8f2d0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <root@chaos.analogic.com>
Cc: <hosler@lugs.org.sg>, <linux-kernel@vger.kernel.org>
Subject: Re: AC'97 (VT82C686A) 
Date: Mon, 30 Apr 2001 18:56:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Observe that the PCI DWORD (long) register at DWORD offset 15 consists
> of 4 byte-wide registers (from the PCI specification), Max_lat,
> Min_Gnt, Interrupt pin, and interrupt line. Nothing has to fit into
> 4 bits, you have 8 bits. I haven't looked at the Linux code, but if
> it provides only 4 bits for the IRQ, it's broken.

I don't have the PCI specification, but at least some network cards
ignore all writes to that register. It's only an interface between the
bios and os. (pnic-82c168: "Interrupt Line. This 8-bit register will be
written by the POST software. The value of this register indicates which
input of the system interrupt controller PNIC's interrupt pin is
connected to."). The AC97 documentation says that only the low 4 bits
are writable. Perhaps it reconfigures itself if
someone writes to that register? Linux never writes to the low byte of
DWORD offset 15.

Greg, what's the value of 'dev->irq'? Usually drivers should never read
offset 3C, instead they should use 'dev->irq'.

arch/i386/kernel/mpparse should figure out where the interrupts arrive.
If that doesn't work: the MP table is documented at
http://developer.intel.com/design/pentium/datashts/24201606.pdf
and one of the debugging options in arch/i386/kernel/mpparse.c will
print all interrupt routing entries during boot up.

The routing entries are (bus, function and pin) -> io apic pin, and the
values for bus, function and pin are known.

--
    Manfred






