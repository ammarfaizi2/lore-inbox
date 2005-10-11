Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVJKNQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVJKNQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVJKNQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:16:15 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:30382 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751134AbVJKNQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:16:15 -0400
Message-ID: <4085.192.168.201.6.1129036560.squirrel@pc300>
Date: Tue, 11 Oct 2005 14:16:00 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: linux-kernel@vger.kernel.org
Cc: "Kalin KOZHUHAROV" <kalin@thinrope.net>
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> So you are saying: "Dump GRUB and lilo, use Gujin!" ??
>
> I don't think anybody will agree with that even if it is a better
> way in some way.
> Until some level of compatibility is guaranteed with the currently
> de facto loaders, at least I cannot support this idea in any way.
> Discussing that with GRUB and lilo devs, might be an idea, but
> who knows.

  It is even worse than that, I not only said to change the
 bootloader but also to remove one of the two links produced
 during a standard "make bzImage", the one which handle the
 real mode ia32 code, in Linux/arch/i386/boot/*.

  Sometimes, to simplify, you need to remove things. As I said,
 a Linux kernel "linux.kgz" is just a compressed binary image of
 an ELF file - it no more deals with real mode, its first
 instruction is in protected mode (no virtual memory, just flat
 one, and interrupts disabled). It still contains the processor
 it is compiled for in the GZIP comment part, in text mode.

  That has advantages like that you use a clean real mode
 environment to get all the BIOS information you want, the
 first kernel assembler instruction can be located anywhere in
 memory (even at an address currently used by BIOS/DOS because
 the relocation is very late), and there is no more any limit
 to the kernel size.
 So, at the bootloader time, you can start a FreeDOS environment
 with DOS USB drivers and load your kernel at any address you want,
 or decide that you do not want to touch the BIOS environment
 and boot from a simulated floppy on a ATAPI IDE CDROM.
 If your kernel no more boots (got a HD with SMART failure lately),
 you can get an error while loading the kernel and just can boot
 a CDROM with a IDE disk RMA generator.
 When network support will be included in Gujin, because the
 processor is still in real mode, it will be able to use the
 network BIOS with its IRQ in a transparent way.

  Note that there is no more any development for LILO or the real
 mode part of the kernel, probably people no more want to deal with
 assembler software. I can't blame them, I stopped too to use
 assembler in Gujin. I can't talk to the development teams of LILO
 or the real mode part of the kernel...

 Anyway, it is technically not possible to rely on the old real
 mode interface because things are not done at the right time,
 complete backward compatibility is kept because you just describe
 what you want at the "make" time, by typing "make bzImage" or
 "make /boot/linux-2.13.kgz".

 I can't force anybody to switch to Gujin; I am just proposing a
 way to start Linux which is a lot simpler, involves a lot less
 assembler code so is a lot easier to maintain, which is working
 right now, which is quite easy to debug (with the DBG*.exe files).
 You can boot your PC with your USB FLASH disk, your CD/DVD-ROM
 or a simple disk / partition / floppy right now, there isn't
 any configuration file because everything is autodetected - at
 least anything which cannot be selected by the graphic/mouse
 interface.
http://gujin.org

  Etienne.

