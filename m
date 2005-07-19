Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVGUQy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVGUQy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 12:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVGUQy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 12:54:56 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:17103 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261813AbVGUQyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 12:54:55 -0400
X-ME-UUID: 20050721165453696.AA1341C00217@mwinf0109.wanadoo.fr
Message-ID: <42DD8845.7070008@crans.org>
Date: Wed, 20 Jul 2005 01:09:57 +0200
From: =?ISO-8859-15?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Michel Bouissou <michel@bouissou.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, bjorn.helgaas@hp.com,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C5D@USRV-EXCH4.na.uis.unisys.com> <200507172022.46975@totor.bouissou.net>
In-Reply-To: <200507172022.46975@totor.bouissou.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Bouissou a écrit :

>Hi there,
>
>Natalie Protasevich and Alan Stern have worked a lot on helping me out with a 
>VIA KT400 chipset / kernel 2.6.12 / IO-APIC / IRQ problem "irq 21: nobody 
>cared!", which so far hasn't found its solution.
>
>Research done with Alan shows that, on my system, the USB 2.0 controller seems 
>to generate interrupts on the IRQ line attributed to the USB 1.1 controller, 
>which isn't supposed to happen, and puzzles the system, when IO-APIC is 
>enabled.
>
>However, this didn't cause problems with 2.4 series kernels.
>
>For the time being, there is no solution (Natalie is still investigating 
>this), and it boils down to the following:
>
>- If I boot with USB 2.0 enabled in BIOS, AND IO-APIC enabled in the kernel, 
>then it badly breaks.
>
>- If I either disable USB 2.0 in BIOS, or IO-APIC in the kernel, then it's OK.
>
>I found today the thread between Bjorn Helgaas and Mathieu Bérard on LKML, 
>where Mathieu reported the same problem, and Bjorn advised him to reverse a 
>kernel patch (http://lkml.org/lkml/2005/6/21/243 ).
>
>Mathieu (I don't have his email address, Bjorn, could you be so kind to 
>forward this message to him) reports that it apparently solved this problem, 
>so I tried to do the same, and reversed the same patch.
>
>
>
>
Hi,
yes I've encountered the same problem but my system
is a little bit different: It's a MSI mainboard with a VIA KT266A chipset
and no USB 2.0 controller (just 3 uhci).
IO-APIC is enabled.

With a 2.6.13-rc1-mm1 kernel, for example,
I got those error messages just after
the integrated sound card detection:

Jul  2 21:04:12 perenold kernel: irq 21: nobody cared (try booting with 
the "irqpoll" option)
Jul  2 21:04:12 perenold kernel: [<c0133c24>] __report_bad_irq+0x24/0x80
Jul  2 21:04:12 perenold kernel: [<c0133d22>] note_interrupt+0x72/0xc0
Jul  2 21:04:12 perenold kernel: [<c0133710>] __do_IRQ+0xe0/0xf0
Jul  2 21:04:12 perenold kernel: [<c0104f8e>] do_IRQ+0x3e/0x60
Jul  2 21:04:12 perenold kernel: =======================
Jul  2 21:04:12 perenold kernel: [<c0103502>] common_interrupt+0x1a/0x20
Jul  2 21:04:12 perenold kernel: [<c0142102>] zap_pte_range+0x82/0x1c0
Jul  2 21:04:12 perenold kernel: [<c01422bf>] unmap_page_range+0x7f/0xb0
Jul  2 21:04:12 perenold kernel: [<c01423f6>] unmap_vmas+0x106/0x210
Jul  2 21:04:12 perenold kernel: [<c01469c1>] exit_mmap+0x71/0x140
Jul  2 21:04:12 perenold kernel: [<c011547e>] mmput+0x2e/0xe0
Jul  2 21:04:12 perenold kernel: [<c015af3c>] exec_mmap+0xac/0x160
Jul  2 21:04:12 perenold kernel: [<c015b0a0>] flush_old_exec+0x70/0x700
Jul  2 21:04:12 perenold kernel: [<c0151475>] vfs_read+0xf5/0x160
Jul  2 21:04:12 perenold kernel: [<c015ae70>] kernel_read+0x40/0x60
Jul  2 21:04:12 perenold kernel: [<c0178f32>] load_elf_binary+0x252/0xd20
Jul  2 21:04:12 perenold kernel: [<c0138bf7>] buffered_rmqueue+0xb7/0x210
Jul  2 21:04:12 perenold kernel: [<c0138eeb>] __alloc_pages+0xdb/0x400
Jul  2 21:04:12 perenold kernel: [<c0104f95>] do_IRQ+0x45/0x60
Jul  2 21:04:12 perenold kernel: [<c01c2c6e>] __copy_from_user_ll+0x3e/0x70
Jul  2 21:04:12 perenold kernel: [<c015b92f>] 
search_binary_handler+0x4f/0x1d0
Jul  2 21:04:12 perenold kernel: [<c015bbfe>] do_execve+0x14e/0x200
Jul  2 21:04:12 perenold kernel: [<c010181f>] sys_execve+0x2f/0x70
Jul  2 21:04:12 perenold kernel: [<c0102aeb>] sysenter_past_esp+0x54/0x75
Jul  2 21:04:12 perenold kernel: handlers:
Jul  2 21:04:12 perenold kernel: [<e0c59450>] 
(snd_via82xx_interrupt+0x0/0xc0 [snd_via82xx])
Jul  2 21:04:12 perenold kernel: Disabling IRQ #21

and later:

Jul  2 21:04:37 perenold kernel: uhci_hcd 0000:00:11.3: Unlink after 
no-IRQ?  Controller is probably using the wrong IRQ.

IRQ 21 is then crazy with a rate of increasing of around 200000 per 
second in /proc/interrupts

All those error messages disappear if I revert the patch as I was 
advised to.

I have that in /proc/interrupts: (with an healthy kernel)
           CPU0
  0:  201893429    IO-APIC-edge  timer
  1:         21    IO-APIC-edge  i8042
  7:          2    IO-APIC-edge  parport0
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:    5448524    IO-APIC-edge  ide0
 15:   14583934    IO-APIC-edge  ide1
 16:     172543   IO-APIC-level  ide3
 17:     299810   IO-APIC-level  saa7134[0]
 18:   24973124   IO-APIC-level  eth0
 19:    5233000   IO-APIC-level  eth1
 20:         82   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 21:          0   IO-APIC-level  VIA8233
NMI:          0
LOC:  201897508
ERR:          0
MIS:          0


So maybe, in my case, it's a mess between the IRQ of the uhci controllers
and the one of the integrated AC'97 sound ship.

But as it is mainly a server box nor the usb controllers nor the sound 
card are used very often,
so I don't know if those devices are actually working now. I am currently on
vacation 300 km away from that box so I can't really plug an USB key to
do some tests. But I will as soon as a can if that can help.
I will also try to reboot the box several times to see if the "IRQ 21 
nobody cared" error
reappears.

-- 
Mathieu









