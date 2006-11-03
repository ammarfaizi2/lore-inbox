Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753121AbWKCFhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbWKCFhi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 00:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbWKCFhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 00:37:38 -0500
Received: from web38407.mail.mud.yahoo.com ([209.191.125.38]:32433 "HELO
	web38407.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753121AbWKCFhh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 00:37:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XTSzsIWxp87vommvjD3Qj4zha7qbGig7lX31EoI/6ZJu7gPk0VZhByd0wQJsZryxlJyrzeJH3SA1uqu/zJ5Njai5BEUKeNfHmJU2Kt+zJqJ60hPgI2ukpSGzjaFQ3SllxuSLi20loMYnIHuJ7tbPn2iujyNZKhaMu3FueUVR4m0=  ;
Message-ID: <20061103053737.78243.qmail@web38407.mail.mud.yahoo.com>
Date: Thu, 2 Nov 2006 21:37:37 -0800 (PST)
From: xp newbie <xp_newbie@yahoo.com>
Subject: irqpoll kernel option hurts performance?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After much time investment and uncertainty, I managed to install
Ubuntu 6.0.6 on a system which has its only hard drive connected via
the P-ATA channel of a Promise FastTrack 387 controller in UDMA7 mode
(aka ATA 133).

However, the only way I was able to make that
Live CD complete its boot (which is essential to double-clicking the
"Install to HDD" icon on the desktop), was by specifying the "irqpoll"
kernel option at the boot prompt. Thereafter, installation proceeded
without a hassle and, in fact, I am posting this message from this
newly installed Linux-based system.

My question is: once I
specified the "irqpoll" option to boot the installation CD, is the
system doomed to always work in "IRQ polling mode" (which is much more
CPU wasteful if I understand this correctly)? Am I really using my
hardware now in less than optimal manner (like in PIO vs. DMA, for
example)?

I am enclosing some relevant lines from my system's dmesg:
            
[17179569.184000] Kernel command line: root=/dev/sda3 ro quiet splash irqpoll
[17179569.184000] Misrouted IRQ fixup and polling support enabled
[17179569.184000] This may significantly impact system performance
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
   
            
[17179579.472000] irq 177: nobody cared (try booting with the "irqpoll" option)
[17179579.472000]  [<c014fc8a>] __report_bad_irq+0x2a/0xa0
[17179579.472000]  [<c014fda7>] note_interrupt+0x87/0xf0
[17179579.472000]  [<c014f57d>] __do_IRQ+0xfd/0x110
[17179579.472000]  [<c0105c79>] do_IRQ+0x19/0x30
[17179579.472000]  [<c0103eb6>] common_interrupt+0x1a/0x20
[17179579.472000]  [<f88f44f4>] ehci_irq+0x34/0x1c0 [ehci_hcd]
[17179579.472000]  [<f891f1f9>] usb_hcd_irq+0x39/0x70 [usbcore]
[17179579.472000]  [<c014f44d>] handle_IRQ_event+0x3d/0x70
[17179579.472000]  [<c014f51d>] __do_IRQ+0x9d/0x110
[17179579.472000]  [<c0105c79>] do_IRQ+0x19/0x30
[17179579.472000]  [<c0103eb6>] common_interrupt+0x1a/0x20
[17179579.472000]  [<c03100e3>] _read_unlock+0x3/0x20
[17179579.472000]  [<c0184fc2>] path_lookup+0x82/0x170
[17179579.472000]  [<c0185403>] __user_walk+0x33/0x60
[17179579.472000]  [<c017ed2f>] vfs_stat+0x1f/0x60
[17179579.472000]  [<c017f458>] sys_stat64+0x18/0x40
[17179579.472000]  [<c017323c>] put_unused_fd+0x2c/0x60
[17179579.472000]  [<c01733b6>] do_sys_open+0xd6/0x100
[17179579.472000]  [<c0103471>] syscall_call+0x7/0xb
[17179579.472000] handlers:
[17179579.472000] [<c02737f0>] (ide_intr+0x0/0x1f0)
[17179579.472000] [<c02737f0>] (ide_intr+0x0/0x1f0)
[17179579.472000] Disabling IRQ #177


Thanks for any tip or insight!

Alex










