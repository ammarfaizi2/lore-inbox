Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266725AbRGQQrs>; Tue, 17 Jul 2001 12:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbRGQQri>; Tue, 17 Jul 2001 12:47:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266725AbRGQQrZ>; Tue, 17 Jul 2001 12:47:25 -0400
Date: Tue, 17 Jul 2001 12:47:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: daniel sheltraw <l5gibson@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI and ioports question
In-Reply-To: <F1137cu85K9kINc0VUy00019f37@hotmail.com>
Message-ID: <Pine.LNX.3.95.1010717123908.3431A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001, daniel sheltraw wrote:

> Hello Kernel listees
> 
> I have a question about ioports on PCI devices but first: If
> there is a better mailing list for asking these types of questions
> would you kindly direct me there.
> 
> The question is this. When do I need to use ioremap for ioports
> on a PCI device (PC architecture)? Is the answer: always except
> when the physical address is within the 64K - 1M ISA region (legacy
> ports).
> 
> Thanks,
> Daniel

For PORTS, you use check_region(). If the result is non-zero, there
is a conflict. To get the region, use request_region(). ioremap()
is for memory address-space.

Ports only go from 0 to 0xffff on an Intel machine, even if the
device is on the PCI bus.

cat /dev/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b400-b403 : PCI device 104b:1040
  b400-b403 : BusLogic BT-958
b800-b87f : PCI device 10b7:9055
  b800-b87f : eth0
d000-d01f : PCI device 1022:2000
d400-d41f : PCI device 8086:7112
d800-d80f : PCI device 8086:7111
e400-e43f : PCI device 8086:7113
e800-e81f : PCI device 8086:7113


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


