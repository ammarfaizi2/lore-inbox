Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314583AbSD3Tl5>; Tue, 30 Apr 2002 15:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSD3Tl4>; Tue, 30 Apr 2002 15:41:56 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:526 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S314583AbSD3Tly>; Tue, 30 Apr 2002 15:41:54 -0400
Date: Tue, 30 Apr 2002 15:41:54 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: jason@jedi.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA UHCI USB controller interrupt problems
Message-ID: <20020430154154.V21887@sventech.com>
In-Reply-To: <20020430165537.GA24479@rancor.jedi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002, Jason Crickmer <jason@rancor.jedi.net> wrote:
> I have been working with a HP Pavilion zt1170 laptop for the past few
> days, trying to get it to work with a PS/2 mouse and keyboard via a
> USB connector (Inland "USB to PS/2 Converter").  The problem seems to
> be that the devices are never heard back from once the kernel inits
> them.  Windows and Grub seem to have no problem using these devices
> through the USB port, but Linux is having a bear of a time.

GRUB uses it as a normal keyboard and mouse because the BIOS does USB
legacy device emulation. That's why it works for GRUB. It doesn't have
any native USB support.

The Linux kernel does have native USB support on the other hand.

> Windows XP gives the USB hubs (which the machine has two of) IRQ 9,
> along with every other PCI device, except the AGP video.  The
> out-of-the-box Redhat Rawhide kernel (2.4.18-0.22) assigns it IRQ 10.
> With this setting, I get a bunch of "usb_control/bulk_msg: timeout"
> errors.  After searching around, I found that some people blamed these
> types of errors on faulty BIOS's and ended up just hacking pci-irq.c
> to force the appropriate behavior for their USB devices.
> 
> So, I have given this several tries following the suggestions made by
> Jan Slupski <jslupski@email.com>
> (http://www.pm.waw.pl/~jslupski/vaio/,
> http://www.ussg.iu.edu/hypermail/linux/kernel/0111.3/1532.html) and
> John Clemens <john@deater.net>
> (http://www.ussg.iu.edu/hypermail/linux/kernel/0111.2/0005.html).
> 
> After doing this, I was able to get the kernel to "say" that IRQ 9 is
> being used for the devices, but lspci -x still shows a value of 0x0a
> at 0x3d (PCI_INTERRUPT_LINE).  And, I still get the
> "usb_control/bulk_msg: timeout" messages, as well as "usb.c: USB
> device not accepting new address=3 (error=-110)" when I plug a USB
> device in.  I have tried using setpci to set the IRQ, but to no avail.
> 
> Below are the following:
> 
>   1. my most recent patch to arch/i386/kernel/pci-irq.c
>   2. kernel boot messages (dmesg) (with my patch)
>   3. relevant snippets from /var/log/messages (with my patch)
>   4. /proc/interrupts (with my patch)
>   5. lspci -x (with my patch)
>   6. Windows XP Device Manager dump
> 
> I know this list is primarily for development, and my question is more
> support related, so if it would be me appropraite to take this
> off-line, just let me know.  Any help or suggestions would be much
> appreciated!

It appears you're working down the correct path. The error message you
quoted is usually indicitive of an IRQ routing problem.

Unfortunately, I'm not an IRQ routing person, so I'll leave for the
others on the list to hopefully help you out further :)

JE

