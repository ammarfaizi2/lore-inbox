Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTDICjv (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 22:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbTDICju (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 22:39:50 -0400
Received: from [217.129.103.98] ([217.129.103.98]:51614 "EHLO wizepc.casa")
	by vger.kernel.org with ESMTP id S261369AbTDICjs convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 22:39:48 -0400
From: Ricardo Correia <wizeman@netvisao.pt>
To: linux-kernel@vger.kernel.org
Subject: [BUG] bttv locks up
Date: Wed, 9 Apr 2003 03:51:25 +0100
User-Agent: KMail/1.5.1
Cc: kraxel@bytesex.org, video4linux-list@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304090351.25480.wizeman@netvisao.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC to my email address, I'm not subscribed to this mailing list)

Hi, I have a BestBuy EasyTV card with the bt878 chip, and since I started 
using the bttv driver for tv capturing (I only used it for remote control 
with lirc for a few weeks, now I'm also using it with mencoder for 
recording), the system completely locks up, not even Alt-SysRq works.

It always happens when I capture, sometimes after a few hours, sometimes after 
a few minutes. I can not tell exactly why and when this happens, I've tried 
stressing the system but it doesn't seem to trigger it, and it happens also 
when the system load is low. The problem is it *always* happens.

I've tried the vanilla kernel 2.4.20 supplied driver, I've tried with the 
2.4.20 patches from http://bytesex.org/patches/ and with the 0.9.9 version. 
It happens with all these versions. If I don't use mencoder it never crashes, 
it's completely rock-solid, and I stress the system a lot.

BTW, when the kernel locks up it never leaves anything in syslog (no oops..), 
the only thing that I notice is that when I use the 0.9.9 version these 
messages appear:

-------------------------------------------------
Apr  9 02:08:07 wizepc kernel: Linux video capture interface: v1.00
Apr  9 02:08:07 wizepc kernel: bttv: driver version 0.9.9 loaded
Apr  9 02:08:07 wizepc kernel: bttv: using 8 buffers with 2080k (520 pages) 
each for capture
Apr  9 02:08:07 wizepc kernel: bttv: Host bridge is VIA Technologies, Inc. 
VT8753 [P4X266 AGP]
Apr  9 02:08:07 wizepc kernel: bttv: Bt8xx card found (0).
Apr  9 02:08:07 wizepc kernel: bttv0: Bt878 (rev 17) at 00:0b.0, irq: 11, 
latency: 32, mmio: 0xdedfe000
Apr  9 02:08:07 wizepc kernel: bttv0: using: BT878(Askey CPH061/ BESTBUY E) 
[card=62,insmod option]
Apr  9 02:08:07 wizepc kernel: tuner: probing bt848 #0 i2c adapter 
[id=0x10005]
Apr  9 02:08:07 wizepc kernel: tuner: chip found @ 0xc2
Apr  9 02:08:07 wizepc kernel: i2c-core.o: client [(tuner unset)] registered 
to adapter [bt848 #0](pos. 0).
Apr  9 02:08:07 wizepc kernel: i2c-core.o: adapter bt848 #0 registered as 
adapter 0.
Apr  9 02:08:07 wizepc kernel: bttv0: using tuner=5
Apr  9 02:08:07 wizepc kernel: tuner: type set to 5 (Philips PAL_BG (FI1216 
and compatibles))
Apr  9 02:08:07 wizepc kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not 
found
Apr  9 02:08:07 wizepc kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not 
found
Apr  9 02:08:07 wizepc kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not 
found
Apr  9 02:08:07 wizepc kernel: bttv0: registered device video0
Apr  9 02:08:07 wizepc kernel: bttv0: registered device vbi0
Apr  9 02:08:07 wizepc kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Apr  9 02:10:18 wizepc kernel: bttv0: skipped frame. no signal? high irq 
latency?
Apr  9 02:10:23 wizepc kernel: bttv0: OCERR @ 16a54014,bits: HSYNC OFLOW 
OCERR*
Apr  9 02:10:47 wizepc kernel: bttv0: skipped frame. no signal? high irq 
latency?
Apr  9 02:10:51 wizepc kernel: bttv0: skipped frame. no signal? high irq 
latency?
Apr  9 02:10:52 wizepc kernel: bttv0: OCERR @ 16a54014,bits: HSYNC OFLOW 
OCERR*
Apr  9 02:10:57 wizepc kernel: bttv0: skipped frame. no signal? high irq 
latency?
Apr  9 02:10:58 wizepc kernel: bttv0: OCERR @ 16a54014,bits: HSYNC OFLOW 
OCERR*
Apr  9 02:11:03 wizepc kernel: bttv0: skipped frame. no signal? high irq 
latency?
Apr  9 02:11:39 wizepc kernel: bttv0: OCERR @ 16a54014,bits: HSYNC OFLOW 
OCERR*
Apr  9 02:11:49 wizepc kernel: bttv0: skipped frame. no signal? high irq 
latency?
Apr  9 02:12:03 wizepc kernel: bttv0: OCERR @ 16a54014,bits: HSYNC OFLOW 
OCERR*
-------------------------------------------------

The first messages I believe are normal show up when I load the bttv module, 
the OCERR and skipped frame messages I'm not sure if it means anything is 
wrong. They keep going like this with about 7 messages per minute average.

For the record I'm using Gentoo Linux 1.4, with gcc 3.2.2, kernel 2.4.20 with 
the ext3 filesystem, a 2.4GHz Pentium-4, 512 MB of RAM, the motherboard is 
from VIA... I think that's it. The machine is completely stable except for 
this.

Since nothing shows up in syslog, what can I do to help locating the bug? I 
can't tell exactly how to trigger it, but it always happens.. I also know C, 
but I don't have any kernel programming knowledge. I'm commited to find the 
bug, since it is very frustrating, I really need to use this sh*tty card :-)
Just please don't ask me to install 2.5.x :P

--
Ricardo Correia
Faculdade de Ciências e Tecnologia,
Universidade Nova de Lisboa, Portugal

