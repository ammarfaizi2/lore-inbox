Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbUKWFRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUKWFRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUKWFRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 00:17:38 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:64938 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262196AbUKWFOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 00:14:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2-bk7, back to an irq 12 "nobody cared!"
Date: Tue, 23 Nov 2004 00:14:15 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411230014.15354.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.10.220] at Mon, 22 Nov 2004 23:14:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Just built bk7 after running the bk4-kjt1 version for a cpouple of 
days, and noticed this in /var/log/dmesg:

>From grub.conf to dmesg:
Kernel command line: ro root=/dev/hda7 acpi_skip_timer_override

Then, quite a ways down in that logfile:
irq 12: nobody cared!
 [<c0130aea>] __report_bad_irq+0x2a/0x90
 [<c01304a0>] handle_IRQ_event+0x30/0x70
 [<c0130bdc>] note_interrupt+0x6c/0xd0
 [<c0130610>] __do_IRQ+0x130/0x160
 [<c01042fe>] do_IRQ+0x3e/0x60
 =======================
 [<c01028aa>] common_interrupt+0x1a/0x20
 [<c011a370>] __do_softirq+0x30/0x90
 [<c0104401>] do_softirq+0x41/0x50
 =======================
 [<c0130464>] irq_exit+0x34/0x40
 [<c0104305>] do_IRQ+0x45/0x60
 [<c01028aa>] common_interrupt+0x1a/0x20
 [<c0130899>] setup_irq+0x99/0x120
 [<c0259950>] i8042_interrupt+0x0/0x190
 [<c0130a91>] request_irq+0x81/0xb0
 [<c0432172>] i8042_check_aux+0x32/0x170
 [<c0259950>] i8042_interrupt+0x0/0x190
 [<c04326f0>] i8042_init+0x130/0x1b0
 [<c041a81b>] do_initcalls+0x2b/0xc0
 [<c04379bd>] sock_init+0x3d/0x80
 [<c0100440>] init+0x0/0x110
 [<c010046f>] init+0x2f/0x110
 [<c010086c>] kernel_thread_helper+0x0/0x14
 [<c0100871>] kernel_thread_helper+0x5/0x14
handlers:
[<c0259950>] (i8042_interrupt+0x0/0x190)
Disabling IRQ #12
serio: i8042 AUX port at 0x60,0x64 irq 12

Which seems a bit odd, to didsable it, and immediately enable it.

Anyway, a cat of /proc/interrupts:
[root@coyote CIO-DIO96]# cat /proc/interrupts
           CPU0
  0:    4012186          XT-PIC  timer
  1:      10124          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         20          XT-PIC  serial
  4:      18077          XT-PIC  serial
  5:     226903          XT-PIC  ehci_hcd, radeon@pci:0000:02:00.0
  7:       7514          XT-PIC  parport0
  8:    2491893          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:     667445          XT-PIC  ohci_hcd, eth0, Bt87x audio, bttv0
 12:     118320          XT-PIC  ohci_hcd, NVidia nForce2
 14:      21876          XT-PIC  ide0
 15:       4710          XT-PIC  ide1
NMI:          0
LOC:    4012345
ERR:        125

Which shows that ACPI didn't manage to seperate them all.

Is there a quick cli based fix to put into that grub.conf entry?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
