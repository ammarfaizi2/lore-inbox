Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUBJRym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUBJRvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:51:09 -0500
Received: from tristate.vision.ee ([194.204.30.144]:20702 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265979AbUBJR0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:26:21 -0500
Message-ID: <4029143B.30408@vision.ee>
Date: Tue, 10 Feb 2004 19:26:19 +0200
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: irq 7: nobody cared! (intel8x0 sound / 2.6.2-rc3-mm1)
References: <4023BEA8.5060306@vision.ee> <s5hd68o2ia7.wl@alsa2.suse.de>
In-Reply-To: <s5hd68o2ia7.wl@alsa2.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

>
>could you check the status register value when this happens with the
>attached patch?
>  
>
It never happened after applying this patch (not the right circumstances 
I think). It always printed this:

intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0

And sound worked.

Today discovered this message from dmesg:

intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
irq 7: nobody cared!
Call Trace:
 [<c010c0f4>] __report_bad_irq+0x24/0x80
 [<c010c1d1>] note_interrupt+0x61/0x90
 [<c010c46d>] do_IRQ+0x10d/0x120
 [<c0279e1c>] common_interrupt+0x18/0x20
 [<c010c093>] handle_IRQ_event+0x23/0x60
 [<c010c3e3>] do_IRQ+0x83/0x120
 [<c0279e1c>] common_interrupt+0x18/0x20
 [<f99a97dc>] dl_done_list+0x7c/0x110 [ohci_hcd]
 [<f99aa114>] ohci_irq+0x84/0x160 [ohci_hcd]
 [<f99ade79>] nic_irq+0x1a9/0x1d0 [forcedeth]
 [<f996d52e>] usb_hcd_irq+0x2e/0x60 [usbcore]
 [<c010c09f>] handle_IRQ_event+0x2f/0x60
 [<c010c3e3>] do_IRQ+0x83/0x120
 [<c0107000>] _stext+0x0/0x50
 [<c0279e1c>] common_interrupt+0x18/0x20
 [<c0107000>] _stext+0x0/0x50
 [<c0108b53>] default_idle+0x23/0x30
 [<c0108bbc>] cpu_idle+0x2c/0x40
 [<c02fe70a>] start_kernel+0x13a/0x150
 [<c02fe480>] unknown_bootoption+0x0/0x100

handlers:
[<f99a1720>] (snd_intel8x0_interrupt+0x0/0x200 [snd_intel8x0])
Disabling IRQ #7

And mplayer stalls again. The 'ignored irq' message was the same and no 
additional messages
after call trace.

/proc/interrupts:

           CPU0
  0:   78008640          XT-PIC  timer
  1:      35441          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:   18501105          XT-PIC  eth1
  7:     203478          XT-PIC  NVidia nForce2
  8:   22814379          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:     639763          XT-PIC  ide2, ehci_hcd
 12:   47894522          XT-PIC  ohci_hcd, eth0
 14:     589578          XT-PIC  ide0
 15:     115750          XT-PIC  ide1
NMI:          0
LOC:   78015575
ERR:       3478
MIS:          0

Lenar
