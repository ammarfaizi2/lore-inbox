Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUGHPx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUGHPx7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUGHPx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:53:58 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:23438 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S264503AbUGHPxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:53:55 -0400
Date: Thu, 8 Jul 2004 07:53:56 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: IRQ issues, (nobody cared, disabled), not USB
Message-ID: <20040708155356.GG22065@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

For the past few iterations of 2.6 (including the vanilla 2.6.7 I'm 
running now) I've had this problem:

 03:27:26 kernel: irq 7: nobody cared!
 03:27:26 kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20 
 03:27:26 kernel:  [__report_bad_irq+43/144] __report_bad_irq+0x2b/0x90
 03:27:26 kernel:  [note_interrupt+100/160] note_interrupt+0x64/0xa0
 03:27:26 kernel:  [do_IRQ+303/320] do_IRQ+0x12f/0x140
 03:27:26 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 03:27:26 kernel:  [do_softirq+44/48] do_softirq+0x2c/0x30
 03:27:26 kernel:  [do_IRQ+265/320] do_IRQ+0x109/0x140
 03:27:26 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 03:27:26 kernel:  [cpu_idle+52/64] cpu_idle+0x34/0x40
 03:27:26 kernel:  [start_kernel+345/384] start_kernel+0x159/0x180
 03:27:26 kernel:  [L6+0/2] 0xc010019f
 03:27:26 kernel:
 03:27:26 kernel: handlers:
 03:27:26 kernel: [pg0+574356528/1067782144] (rtl8139_interrupt+0x0/0x1a0 [8139too])
 03:27:26 kernel: Disabling IRQ #7

And afterwords my second ethernet card doesn't work.  

Here's /proc/interrupts:

            CPU0       
   0:  177141414          XT-PIC  timer
   1:     183996          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   7:     447254          XT-PIC  eth1
   8:      57157          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:    2222075          XT-PIC  eth0
  11:     230779          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd, EMU10K1
  12:     731171          XT-PIC  i8042
  14:   14054351          XT-PIC  ide0
  15:      43448          XT-PIC  ide1
 NMI:          0 
 LOC:  177146541 
 ERR:     247303
 MIS:          0

And 'lspci':

 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
 0000:00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
 0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
 0000:00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
 0000:00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
 0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
 0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
 0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
 0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
 0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)

I've tried booting without ACPI, and I've tried an eepro100 card instead 
of the 8139too that's causing the error above.  I believe I've tried 
different PCI slots for the second ethernet card too, but I may be 
mistaken about that.  No matter what I've tried, under 2.6, the second 
ethernet card gets disabled at some point between a few hours and a few 
days after the system boots.

Other threads I've googled on the subject seem to point to ECHI, but I 
don't have this sort of device, and this driver isn't built into my 
kernel.

Can anyone offer some advice?  Is this a kernel issue, or do I have bad 
hardware?  Is there some kernel configuration option / patch that 
attempts to resolve this issue?

Thanks!  I'm happy to post dmesg / config.gz or whatever else might be 
helpful.

Respectfully,

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu (work)
Intl. Arctic Research Center            cswingle@gmail.com (personal)
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

