Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271787AbRH0Q6m>; Mon, 27 Aug 2001 12:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271788AbRH0Q6c>; Mon, 27 Aug 2001 12:58:32 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:20203 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S271787AbRH0Q6V>;
	Mon, 27 Aug 2001 12:58:21 -0400
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.8/9 panic on serial with MSI-694D MB
Date: Mon, 27 Aug 2001 17:59:03 +0100
Message-ID: <000001c12f19$94010ff0$f5237ad5@hayholt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.4.21.0108271052440.14250-100000@kleintje.nozone.nl>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be the same crash that I have reported 3 times 
over the last few weeks.  I have not heard anything, but I suspected
that it was a console bug because I have 2 video cards and
the <c0105262> addresses are in vgacon...  I didn't think that
it might be the serial port.

Thanks for the pointer.  2.4.9 SMP now boots, and everything
Seems to work alright.  My new config does not use serial or
any power management.

It only appears in SMP mode (I can boot any kernel with maxcpus=1)
so it is probably a locking problem.  I did notice that mine stopped
right after printing a notice about ttyS0, but the oops pushed that 
Off the screen.

Laramie


-----Original Message-----
On Behalf Of Tony den Haan

From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] 
Sent: Monday, August 27, 2001 10:00 AM
To: linux-kernel@vger.kernel.org
Subject: 2.4.8/9 panic on serial with MSI-694D MB


hi,

i ran into strange problem with2.4.9 panics, first only sometimes, later
on it just wouldn't boot at all.

VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
        ide0: BM-DMA at 0x9000-0x9007, BIOS settings hda:DMA, hdb:pio
        ide1: BM-DMA at 0x9008-0x900f, BIOS settings hdc:pio, hdd:pio
Unable to handle kernel NULL pointer dereference at virtual address
00000018
 printing eip:
00000018
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<00000018>]
EFLAGS: 00010246
eax: 00000000 ebx: c01051d0 ecx: c15f6000 edx: c15f6000
esi: c15f6000 edi: c01051d0 ebp: 00000000 esp: c15f7fb0
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 0, stackpage=c15f7000)
Stack:  c0105262 00000002 00000000 00000000 c0247a4a c02a0e80 00000000
        c0199b77 00000000 0000000d 00000000 00000000 c016956e c1443000
        00000001 c02a0e0a 00000000 00000000
Call Trace: [c0105262>] [<c0199b77>] [<c016966e>]

Code: Bad EIP value
Kernel panicL Attempted to kill the idle task!
In idle task - not syncing

all attempts came up with same 0018

this is where serial gets initialized, removing serial support from
kernel
fixed the problem

it's SMP PIII system with via82Cxx chipset, no special hardware added.
2.4.5 did ok.

any thoughts? hints what to look at?

tony


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

