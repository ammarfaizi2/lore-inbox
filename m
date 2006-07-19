Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWGSTmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWGSTmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWGSTmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 15:42:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:51083 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030245AbWGSTmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 15:42:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bTgiTyS5oA1l/bM1dp1GC9Ex8GKgLhVitcGODGxVqqQeeWOKBDwpJEqXtF6OPI/Cox4wowegXUeH9VnA+seQet2EEX+waqacaK9FllUNn7/U5iNjMoH7Fv/sioxtAKbbKyRq5NVJtShvPal3dixjVuYVPQoVfe1qpzx5ehV/SV4=
Message-ID: <5bdc1c8b0607191242v6c94a346s65febc8a0a27fbe@mail.gmail.com>
Date: Wed, 19 Jul 2006 12:42:13 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>
Subject: BUG: scheduling while atomic: events/0/0x00000001/10
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
   I brought up the -rt kernel on my son's SIS-based machine and got
this bug report in dmesg this morning. I've not seen this on previous
standard kernels so I thought I might be of interest to you. Let me
know what other sort of info you might want to have (if any) and I'll
post it along.

   He has run other MUCH older -rt kernels, circa 2.6.9 or so. I'm
assuming this is new because of the rt_mutex stuff.

   Networking is working since I'm writing this email on the same machine.

Cheers,
Mark

Bank 1: d400400000000152
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 2: d40040000000017a
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: d400400000000152
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 2: d40040000000017a
BUG: scheduling while atomic: events/0/0x00000001/10
 [<c03a97b1>] __schedule+0x591/0x730 (8)
 [<c0133651>] __rt_mutex_adjust_prio+0x21/0x30 (56)
 [<c03a9980>] schedule+0x30/0x110 (36)
 [<c03aa7d3>] rt_lock_slowlock+0x93/0x1b0 (28)
 [<c03ab0fe>] rt_lock+0x1e/0x20 (84)
 [<c0160c0e>] kfree+0x1e/0x70 (4)
 [<c0111e24>] __wake_up+0x44/0x70 (8)
 [<d792d198>] free_send_packet+0x28/0x70 [ndiswrapper] (16)
 [<d792d629>] sendpacket_done+0x79/0x160 [ndiswrapper] (28)
 [<d79220ae>] NdisMSendComplete+0x1e/0x40 [ndiswrapper] (40)
 [<c03a9599>] __schedule+0x379/0x730 (108)
 [<d79215d1>] ndis_irq_bh+0xb1/0xe0 [ndiswrapper] (56)
 [<c01293cb>] run_workqueue+0x6b/0x100 (20)
 [<d7921520>] ndis_irq_bh+0x0/0xe0 [ndiswrapper] (24)
 [<c01295b8>] worker_thread+0x158/0x180 (20)
 [<c0111d40>] default_wake_function+0x0/0x30 (32)
 [<c0111d40>] default_wake_function+0x0/0x30 (32)
 [<c03a9980>] schedule+0x30/0x110 (12)
 [<c0129460>] worker_thread+0x0/0x180 (24)
 [<c012c716>] kthread+0xb6/0xf0 (4)
 [<c012c660>] kthread+0x0/0xf0 (32)
 [<c0101165>] kernel_thread_helper+0x5/0x10 (16)
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: d400400000000152
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 2: d40040000000017a


matt@christmas ~ $ uname -a
Linux christmas 2.6.17-rt5 #2 PREEMPT Fri Jul 14 11:38:07 PDT 2006
i686 AMD Athlon(tm) XP 20 00+ GNU/Linux
matt@christmas ~ $

christmas ~ # lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 741/741GX/M741
Host (rev 03)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS AGP Port
(virtual PCI-to-PCI bridge)00:02.0 ISA bridge: Silicon Integrated
Systems [SiS] SiS964 [MuTIOL Media IO] (rev 36)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
AC'97 Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
PCI Fast Ethernet (rev 91)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8180L
802.11b MAC (rev 20)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
661/741/760/761 PCI/AGP VGA Display Adapter
christmas ~ #
