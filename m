Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSLXM3j>; Tue, 24 Dec 2002 07:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSLXM3j>; Tue, 24 Dec 2002 07:29:39 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:8656 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261545AbSLXM3i>; Tue, 24 Dec 2002 07:29:38 -0500
Date: Tue, 24 Dec 2002 13:33:45 +0100
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: Crash with 3c59x.o
Message-ID: <20021224123341.GA22985@kiwi.hjbaader.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I experienced a reproducible crash with the 3c59x network module on my dual
Celeron machine. To reproduce, do the following:

/etc/init.d/networking stop
rmmod 3c59x; modprobe 3c59x (several times)
rmmod 3c59x
/etc/init.d/networking start

Then the system freezes. All kernels from 2.4.20-rc1 to 2.4.21-pre2 appear
to have this bug. Some time after the freeze, a message appears, I didn't
copy it completely:

wait_on_irq, CPU1:
irq: 1 [ 2 0 ]
bh:  0 [ 1 0 ]

CPU 0 call stack appears to be empty
CPU 1 call stack appears to be:
  __global_cli flush_to_ldisc __run_task_queue context_thread kernel_thread

lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
00:0b.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P) (rev 01)
00:0f.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 01)
00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 01)

As you can see, there are two 3Com cards which are both recognized by the
driver.

Regards,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA
