Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUG2M32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUG2M32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUG2M0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:26:44 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:44797 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S264501AbUG2MZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:25:39 -0400
From: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
Organization: TU Dresden - Operating System Group 
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 - modem dialup broken
Date: Thu, 29 Jul 2004 14:26:38 +0200
User-Agent: KMail/1.6.82
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Lenar L?hmus" <lenar@vision.ee>, "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjanv@redhat.com>,
       "Wood, Scott" <Scott.Wood@timesys.com>,
       "Saksena, Manas" <Manas.Saksena@timesys.com>
References: <3D848382FB72E249812901444C6BDB1D036EDFD3@exchange.timesys.com>
In-Reply-To: <3D848382FB72E249812901444C6BDB1D036EDFD3@exchange.timesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407291426.38785.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've found another problem w/ voluntary-preempt-2.6.8-rc2-L2:
my dialup connection with a modem is broken with voluntary-preempt=3.

With 
"echo 2 > /proc/sys/kernel/voluntary_preemption"
it works. All modem LEDs are blinking :)
Then 
"echo 3 > /proc/sys/kernel/voluntary_preemption"
-> the LEDs stop blinking after a few seconds. The connection times out.

The only log message I see when booting with voluntary-preempt on is this one:

Jul 29 10:57:51 linux irq event 4: bogus return value ffffffff
Jul 29 10:57:51 linux [<c01076ae>] dump_stack+0x1e/0x20
Jul 29 10:57:51 linux [<c0108b4b>] __report_bad_irq+0x2b/0x90
Jul 29 10:57:51 linux [<c0108be0>] report_bad_irq+0x30/0x40
Jul 29 10:57:51 linux [<c0108c82>] note_interrupt+0x92/0xa0
Jul 29 10:57:51 linux [<c0108ecb>] do_hardirq+0x11b/0x180
Jul 29 10:57:51 linux [<c012025c>] irqd+0x9c/0xc0
Jul 29 10:57:51 linux [<c012e25d>] kthread+0xad/0xc0
Jul 29 10:57:51 linux [<c01052b1>] kernel_thread_helper+0x5/0x14
Jul 29 10:57:51 linux handlers:
Jul 29 10:57:51 linux irq event 3: bogus return value ffffffff
Jul 29 10:57:51 linux [<c01076ae>] dump_stack+0x1e/0x20
Jul 29 10:57:51 linux [<c0108b4b>] __report_bad_irq+0x2b/0x90
Jul 29 10:57:51 linux [<c0108be0>] report_bad_irq+0x30/0x40
Jul 29 10:57:51 linux [<c0108c82>] note_interrupt+0x92/0xa0
Jul 29 10:57:51 linux [<c0108ecb>] do_hardirq+0x11b/0x180
Jul 29 10:57:51 linux [<c012025c>] irqd+0x9c/0xc0
Jul 29 10:57:51 linux [<c012e25d>] kthread+0xad/0xc0
Jul 29 10:57:51 linux [<c01052b1>] kernel_thread_helper+0x5/0x14

May be this related to the above problem.
Sorry for this inprecise description. Just ask me for more informations.

Regards,
Carsten

cat /proc/interrupts (without beeing online):
CPU0
  0:    5159722          XT-PIC  timer
  1:      14081          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:       2855          XT-PIC  VIA8233, uhci_hcd
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:     501556          XT-PIC  ohci1394, uhci_hcd
 11:      40604          XT-PIC  eth0, uhci_hcd, ehci_hcd
 14:      57086          XT-PIC  ide0
 15:         38          XT-PIC  ide1
NMI:          0
LOC:    5159632

cat /proc/interrupts (beeing online):
           CPU0
  0:    5248767          XT-PIC  timer
  1:      14803          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:    1945822          XT-PIC  serial
  7:       2893          XT-PIC  VIA8233, uhci_hcd
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:     512803          XT-PIC  ohci1394, uhci_hcd
 11:      40693          XT-PIC  eth0, uhci_hcd, ehci_hcd
 14:      57251          XT-PIC  ide0
 15:         38          XT-PIC  ide1
NMI:          0
LOC:    5248676
ERR:         21
